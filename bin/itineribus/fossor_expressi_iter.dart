import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../auxiliatores/print.dart';
import '../connect/par_ad_rimor.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/petitio/incipit_pugna.dart';
import '../exempla/scan.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/telum.dart';
import '../exempla/transactio.dart';
import '../connect/pervideas_to_pervideas.dart';
import 'package:tuple/tuple.dart';
import '../exempla/constantes.dart';
import '../exempla/utils.dart';
import 'package:collection/collection.dart';
import '../server.dart';
import 'obstructionum_iter.dart';

Future<Response> fossorExpressi(Request req) async {
  IncipitPugna ip =
      IncipitPugna.fromJson(json.decode(await req.readAsString()));
  bool estFurca = bool.parse(req.params['furca']!);
  Directory directory =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directory);

  List<Isolate> syncExpressiBlocks = [];
  if (!File('${directory.path}/${Constantes.caudices}0.txt').existsSync()) {
    return Response.badRequest(
        body: json.encode({
      "code": 0,
      "nuntius": "adhuc expectans incipio obstructionum",
      "message": "Still waiting on incipio block"
    }));
  }
  List<Transactio> liberTxs = [];
  List<Transactio> fixumTxs = [];
  Obstructionum priorObstructionum =
      await Obstructionum.acciperePrior(directory);
  ReceivePort acciperePortus = ReceivePort();
  fixumTxs.addAll(Transactio.grab(par!.fixumTransactions
      .where((wft) => wft.interioreTransactio.probatur == true)));
  liberTxs.addAll(Transactio.grab(par!.liberTransactions
      .where((lt) => lt.interioreTransactio.probatur == true)));
  final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
  // liberTxs
  //     .addAll(priorObstructionum.interioreObstructionum.expressiTransactions);
  Gladiator? gladiatorOppugnare =
      await Obstructionum.grabGladiator(ip.gladiatorIdentitatis!, lo);
  if (gladiatorOppugnare == null) {
    return Response.badRequest(
        body: json.encode({
      "code": 1,
      "nuntius": "Gladiator non inveni",
      "message": "Gladiator not found"
    }));
  }
  PrivateKey pk = PrivateKey.fromHex(Pera.curve(), ip.privatusClavis!);
  if (await Obstructionum.gladiatorConfodiantur(
      ip.gladiatorIdentitatis!, pk.publicKey.toHex(), lo)) {
    return Response.badRequest(
        body: json.encode({
      "code": 2,
      "message": "Non te oppugnare",
      "english": "Can not attack yourself"
    }));
  }
  String gladiatorExpressiPrivateKey = ip.privatusClavis!;
  for (String acc in gladiatorOppugnare
      .interioreGladiator.outputs[(ip.primis! ? 0 : 1)].rationibus
      .map((e) => e.interiorePropter.publicaClavis)) {
    final balance = await Pera.statera(true, acc, lo);
    if (balance > BigInt.zero) {
      liberTxs.add(Transactio.burn(await Pera.ardeat(
          PrivateKey.fromHex(Pera.curve(), ip.privatusClavis!),
          acc,
          priorObstructionum.probationem,
          balance,
          lo)));
    }
  }
  Tuple2<InterioreTransactio?, InterioreTransactio?> transform =
      await Pera.transformFixum(
          gladiatorExpressiPrivateKey, par!.liberTransactions, lo);
  if (transform.item1 != null) {
    liberTxs.add(Transactio.nullam(transform.item1!));
  }
  if (transform.item2 != null) {
    fixumTxs.add(Transactio.nullam(transform.item2!));
  }
  liberTxs.addAll(Transactio.grab(par!.liberTransactions));
  fixumTxs.addAll(Transactio.grab(par!.fixumTransactions));
  List<String> ltum = [];
  liberTxs.map((lt) => lt.interioreTransactio.identitatis).forEach(ltum.add);
  List<ConnexaLiberExpressi> cles = par!.invenireConnexaLiberExpressis(ltum);
  List<Transactio> expressiTxs = par!.expressiTransactions
      .where((et) => cles.any((cle) =>
          et.interioreTransactio.identitatis ==
          cle.interioreConnexaLiberExpressi.expressiIdentitatis))
      .toList();
  List<Telum> impetus = [];
  impetus.addAll(await Pera.maximeArma(true, ip.primis!, true,
      gladiatorOppugnare.interioreGladiator.identitatis, lo));
  impetus.addAll(await Pera.maximeArma(false, ip.primis!, true,
      gladiatorOppugnare.interioreGladiator.identitatis, lo));
  List<Telum> defensiones = [];
  defensiones.addAll(await Pera.maximeArma(true, ip.primis!, false,
      gladiatorOppugnare.interioreGladiator.identitatis, lo));
  defensiones.addAll(await Pera.maximeArma(false, ip.primis!, false,
      gladiatorOppugnare.interioreGladiator.identitatis, lo));
  List<String> gladii = impetus.map((e) => e.telum).toList();
  List<String> scuta = defensiones.map((e) => e.telum).toList();
  final baseDefensio = await Pera.turpiaGladiatoriaTelum(
      ip.primis!, false, gladiatorOppugnare.interioreGladiator.identitatis, lo);
  final baseImpetus = await Pera.turpiaGladiatoriaTelum(
      ip.primis!, true, gladiatorOppugnare.interioreGladiator.identitatis, lo);
  gladii.add(baseDefensio);
  scuta.add(baseImpetus);
  scuta.removeWhere((defensio) => gladii.contains(defensio));
  List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
  BigInt numerus = await Obstructionum.numeruo(on);
  List<SiRemotionem> lsr = SiRemotionem.grab(par!.siRemotiones);
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
      priorProbationem: priorObstructionum.probationem,
      gladiator: Gladiator.nullam(InterioreGladiator.ce(
          input: await InterioreGladiator.cegi(ip.primis!, ip.privatusClavis!,
              gladiatorOppugnare.interioreGladiator.identitatis, lo))),
      liberTransactions: liberTxs,
      fixumTransactions: fixumTxs,
      expressiTransactions: [],
      connexaLiberExpressis: cles,
      siRemotiones: lsr,
      prior: priorObstructionum);
  stamina.expressiThreads.add(await Isolate.spawn(Obstructionum.expressi,
      List<dynamic>.from([interiore, scuta, acciperePortus.sendPort])));
  acciperePortus.listen((nuntius) async {
    Obstructionum obstructionum = nuntius as Obstructionum;
    InFieriObstructionum ifo = obstructionum.inFieriObstructionum();
    par!.removeLiberTransactions(ifo.liberTransactions);
    par!.removeFixumTransactions(ifo.fixumTransactions);
    par!.removeExpressiTransactions(ifo.expressiTransactions);
    par!.removePropters(ifo.fixumTransactions);
    par!.removeConnexaLiberExpressis(ifo.connexaLiberExpressis);
    par!.syncBlock(obstructionum);
  });
  return Response.ok(json.encode({
    "nuntius": "coepi expressi miner",
    "message": "started expressi miner",
    "threads": stamina.expressiThreads.length
  }));
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
