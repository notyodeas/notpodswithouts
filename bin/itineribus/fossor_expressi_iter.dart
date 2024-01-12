import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../auxiliatores/fossor_praecipuus.dart';
import '../auxiliatores/requiritur_in_probationem.dart';
import '../exempla/errors.dart';
import '../exempla/petitio/incipit_pugna.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/transactio.dart';
import '../exempla/constantes.dart';
import '../server.dart';

Future<Response> fossorExpressi(Request req) async {
  bool estFurca = bool.parse(req.params['furca']!);
  try {
    IncipitPugna ip =
      IncipitPugna.fromJson(json.decode(await req.readAsString()));
    Directory directorium =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
    Obstructionum prior = await Obstructionum.acciperePrior(directorium);
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    if (!File('${directorium.path}/${Constantes.caudices}0.txt').existsSync()) {
      return Response.badRequest(
          body: json.encode({
        "code": 0,
        "nuntius": "adhuc expectans incipio obstructionum",
        "message": "Still waiting on incipio block"
      }));
    }
    Gladiator? gladiator =
    await Obstructionum.grabGladiator(ip.victima.identitatis, lo);
    if (gladiator == null) {
      return Response.badRequest(
          body: json.encode({
        "code": 1,
        "nuntius": "Gladiator non inveni",
        "message": "Gladiator not found"
      }));
    }
    PrivateKey pk = PrivateKey.fromHex(Pera.curve(), ip.ex);
    if (await Obstructionum.gladiatorConfodiantur(
      ip.victima.primis, ip.victima.identitatis, pk.publicKey.toHex(), lo)) {
      return Response.badRequest(
          body: json.encode({
        "code": 2,
        "message": "Non te oppugnare",
        "english": "Can not attack yourself"
      }));
    }
    String publica = pk.publicKey.toHex();
    if (publica != argumentis!.publicaClavis) {
      return Response.badRequest(body: json.encode(BadRequest(code: 3, nuntius: 'doleo te solum posse meum confussum vel expressi cum clavis privatis quae ad argumentum producentis in nodi launch datam pertinet', message: 'sorry you can only mine a confussus or expressi with the private key that belongs to the argument of producentis given on node launch')));
    }
    List<Transactio> lttip = [];
    lttip.addAll(par!.liberTransactions);
    lttip.addAll(prior.interiore.expressiTransactions);
    // lttip.addAll(prior.interioreObstructionum.expressiTransactions);
    COE coe = await COE.computo(100, prior, gladiator, ip, lttip, lo);
    print('iscoetheproblem ${coe.toJson()}');
    print('expressillt ${lttip.map((e) => e.toJson())}');
    print('coeltt ${coe.llt.map((e) => e.toJson())}');
    FossorPraecipuus fp = FossorPraecipuus.coe(
      llttbi: coe.llt, 
      lfttbi: coe.lft, 
    );
    fp.accipere(      
      efectus: false,
      maxime: coe.maxime, 
      llt: lttip, 
      lft: par!.fixumTransactions, 
      let: par!.expressiTransactions, 
      lcle: par!.connexiaLiberExpressis, 
      lsr: par!.siRemotiones, 
      lp: par!.rationibus, 
      lsp: par!.solucionisRationibus,
      lfsp: par!.fissileSolucionisRationibus,
      lit: par!.inritaTransactions,
      lo: lo
    );
    // fp.llttbi.addAll(prior.interioreObstructionum.expressiTransactions);
    for (SiRemotionem sr in fp.lsrtbi.where((wlsr) => wlsr.interiore.siRemotionemInput != null)) {
        sr.interiore.siRemotionemInput?.interioreTransactio = null;
    }
    final primis = await Pera.isPrimis(publica, directorium);
    final gladiatorIdentitatis =
        await Pera.accipereGladiatorIdentitatis(publica, directorium);
    List<String> scuta = await RequiriturInProbationem.requiriturInProbationem(primis, gladiatorIdentitatis, ip.victima, lo);
    List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
    BigInt numerus = await Obstructionum.numeruo(on);
    final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
    InterioreObstructionum interiore = InterioreObstructionum.expressi(
      estFurca: estFurca,
      obstructionumDifficultas: obstructionumDifficultas.length,
      divisa: (numerus / await Obstructionum.utSummaDifficultas(lo)),
      forumCap: await Obstructionum.accipereForumCap(lo),
      liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
      fixumForumCap: await Obstructionum.accipereForumCapLiberFixum(false, lo),
      summaObstructionumDifficultas: await Obstructionum.utSummaDifficultas(lo),
      obstructionumNumerus: on,
      producentis: argumentis!.publicaClavis,
      priorProbationem: prior.probationem,
      gladiator: Gladiator.nullam(InterioreGladiator.ce(input: 
      await InterioreGladiator.cegi(privatusClavis: ip.ex, 
      inimicus: GladiatorInputPar(primis, gladiatorIdentitatis), 
      victima: GladiatorInputPar(ip.victima.primis, ip.victima.identitatis), lo: lo))),
      liberTransactions: fp.llttbi,
      fixumTransactions: fp.lfttbi,
      expressiTransactions: [],
      connexaLiberExpressis: [],
      siRemotiones: fp.lsrtbi,
      solucionisRationibus: fp.lsptbi,
      fissileSolucionisRationibus: fp.lfsptbi,
      inritaTransactions: fp.littbi,
      prior: prior);
    ReceivePort acciperePortus = ReceivePort();
    stamina.expressiThreads.add(await Isolate.spawn(Obstructionum.expressi,
        List<dynamic>.from([interiore, scuta, acciperePortus.sendPort])));
    acciperePortus.listen((nuntius) async {
      Obstructionum obstructionum = nuntius as Obstructionum;
      stamina.expressiThreads.forEach((et) => et.kill(priority: Isolate.immediate));
      await par!.syncBlock(obstructionum);
    });
    return Response.ok(json.encode({
      "nuntius": "coepi expressi miner",
      "message": "started expressi miner",
      "threads": stamina.expressiThreads.length 
    }));    
  } on BadRequest catch (e) {
     return Response.badRequest(body: json.encode(e.toJson()));
  } 
}

Future<Response> expressiThreads(Request req) async {
  return Response.ok({"threads": stamina.expressiThreads.length});
}

Future<Response> prohibereExpressi() async {
  stamina.expressiThreads.forEach((e) => e.kill(priority: Isolate.immediate));
  return Response.ok({
    "message": "bene substitit expressi miner",
    "english": "succesfully stopped expressi miner",
  });
}
