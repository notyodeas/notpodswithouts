import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../auxiliatores/fossor_praecipuus.dart';
import '../auxiliatores/print.dart';
import '../auxiliatores/requiritur_in_probationem.dart';
import '../connect/par_ad_rimor.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/errors.dart';
import '../exempla/petitio/incipit_pugna.dart';
import '../exempla/scan.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/solucionis_propter.dart';
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
    await Obstructionum.grabGladiator(ip.victima!.gladiatorIdentitatis!, lo);
    if (gladiator == null) {
      return Response.badRequest(
          body: json.encode({
        "code": 1,
        "nuntius": "Gladiator non inveni",
        "message": "Gladiator not found"
      }));
    }
    PrivateKey pk = PrivateKey.fromHex(Pera.curve(), ip.privatusClavis!);
    if (await Obstructionum.gladiatorConfodiantur(
        ip.victima!.gladiatorIdentitatis!, pk.publicKey.toHex(), lo)) {
      return Response.badRequest(
          body: json.encode({
        "code": 2,
        "message": "Non te oppugnare",
        "english": "Can not attack yourself"
      }));
    }
    List<Transactio> lttip = [];
    lttip.addAll(par!.liberTransactions);
    lttip.addAll(prior.interioreObstructionum.expressiTransactions);
    // lttip.addAll(prior.interioreObstructionum.expressiTransactions);
    COE coe = await COE.computo(100, prior, gladiator, ip, lttip, lo);
    print('iscoetheproblem ${coe.toJson()}');
    print('expressillt ${lttip.map((e) => e.toJson())}');
    print('coeltt ${coe.llt.map((e) => e.toJson())}');
    FossorPraecipuus fp = FossorPraecipuus.coe(llttbi: coe.llt, lfttbi: coe.lft, efectus: false, maxime: coe.maxime, llt: lttip.where((wlttip) => wlttip.interioreTransactio.probatur), lft: par!.fixumTransactions.where((wft) => wft.interioreTransactio.probatur), let: par!.expressiTransactions, lcle: par!.connexiaLiberExpressis, lsr: par!.siRemotiones, lp: par!.rationibus, lsp: par!.solucionisRationibus, lfsp: par!.fissileSolucionisRationibus, lo: lo);
    // fp.llttbi.addAll(prior.interioreObstructionum.expressiTransactions);
    for (SiRemotionem sr in fp.lsrtbi.where((wlsr) => wlsr.interioreSiRemotionem.siRemotionemInput != null)) {
        sr.interioreSiRemotionem.siRemotionemInput?.interioreTransactio = null;
    }
    List<String> scuta = await RequiriturInProbationem.requiriturInProbationem(ip, lo);
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
      gladiator: Gladiator.nullam(InterioreGladiator.ce(input: await InterioreGladiator.cegi(privatusClavis: ip.privatusClavis!, inimicus: GladiatorInputPar(ip.inimicus!.primis!, ip.inimicus!.gladiatorIdentitatis!), victima: GladiatorInputPar(ip.victima!.primis!, ip.victima!.gladiatorIdentitatis!), lo: lo))),
      liberTransactions: fp.llttbi,
      fixumTransactions: fp.lfttbi,
      expressiTransactions: [],
      connexaLiberExpressis: [],
      siRemotiones: fp.lsrtbi,
      solucionisRationibus: fp.lsptbi,
      fissileSolucionisRationibus: fp.lfsptbi,
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

// Future<Response> fossorExpressi(Request req) async {

//   bool estFurca = bool.parse(req.params['furca']!);
// Directory directory =
//       Directory('vincula/${argumentis!.obstructionumDirectorium}');
//       IncipitPugna ip =
//     IncipitPugna.fromJson(json.decode(await req.readAsString()));
//     List<Obstructionum> lo = await Obstructionum.getBlocks(directory);

//   print('recievedcommandtofossor');
//   try {

//       List<Isolate> syncExpressiBlocks = [];
//       if (!File('${directory.path}/${Constantes.caudices}0.txt').existsSync()) {
//         return Response.badRequest(
//             body: json.encode({
//           "code": 0,
//           "nuntius": "adhuc expectans incipio obstructionum",
//           "message": "Still waiting on incipio block"
//         }));
//       }
//       Obstructionum priorObstructionum =
//           await Obstructionum.acciperePrior(directory);
//       Gladiator? gladiatorOppugnare =
//       await Obstructionum.grabGladiator(ip.victima!.gladiatorIdentitatis!, lo);
//       if (gladiatorOppugnare == null) {
//         return Response.badRequest(
//             body: json.encode({
//           "code": 1,
//           "nuntius": "Gladiator non inveni",
//           "message": "Gladiator not found"
//         }));
//       }
//       PrivateKey pk = PrivateKey.fromHex(Pera.curve(), ip.privatusClavis!);
//       if (await Obstructionum.gladiatorConfodiantur(
//           ip.victima!.gladiatorIdentitatis!, pk.publicKey.toHex(), lo)) {
//         return Response.badRequest(
//             body: json.encode({
//           "code": 2,
//           "message": "Non te oppugnare",
//           "english": "Can not attack yourself"
//         }));
//       }
//       List<Transactio> liberTxs = [];
//       List<Transactio> fixumTxs = [];
//       liberTxs.addAll(priorObstructionum.interioreObstructionum.expressiTransactions);
//       fixumTxs.addAll(Transactio.grab(par!.fixumTransactions
//           .where((wft) => wft.interioreTransactio.probatur == true)));
//       liberTxs.addAll(Transactio.grab(par!.liberTransactions
//           .where((wlt) => wlt.interioreTransactio.probatur == true)));
//         // maby we need capta too to validate upon a youngerblock on a different node but lets see that would occur auto
//       List<SiRemotionem> lsr = SiRemotionem.grab(par!.siRemotiones);
//       liberTxs.addAll(lsr.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null && wsr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!.liber).map((msr) => Transactio.nullam(msr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!)));
//       fixumTxs.addAll(lsr.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null && !wsr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!.liber).map((msr) => Transactio.nullam(msr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!)));
//       for (SiRemotionem sr in lsr.where((wlsr) => wlsr.interioreSiRemotionem.siRemotionemInput != null)) {
//         sr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio = null;
//       }
//       final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
//       // liberTxs
//       //     .addAll(priorObstructionum.interioreObstructionum.expressiTransactions);
      
//       String gladiatorExpressiPrivateKey = ip.privatusClavis!;
//       List<Transactio> ltb = [];
//       for (String acc in gladiatorOppugnare
//           .interioreGladiator.outputs[(ip.victima!.primis! ? 0 : 1)].rationibus
//           .map((e) => e.interiorePropter.publicaClavis)) {
//             InterioreTransactio? it = await Pera.perdita(
//             PrivateKey.fromHex(Pera.curve(), ip.privatusClavis!),
//             acc,
//             priorObstructionum.probationem,
//             liberTxs,
//             lo);
//           if (it != null) {
//             ltb.add(Transactio.nullam(it));
//           }
//         // final balance = await Pera.statera(true, acc, lo);
//         // if (balance > BigInt.zero) {
//         }
//       // }

//       Tuple2<InterioreTransactio?, InterioreTransactio?> transform =
//           await Pera.transformFixum(
//               gladiatorExpressiPrivateKey, liberTxs, lo);
//       if (transform.item1 != null) {
//         liberTxs.add(Transactio.nullam(transform.item1!));
//       }
//       if (transform.item2 != null) {
//         fixumTxs.add(Transactio.nullam(transform.item2!));
//       }
//       liberTxs.addAll(ltb);
//       // liberTxs.addAll(Transactio.grab(par!.liberTransactions.where((lt) => lt.interioreTransactio.probatur == true)));
//       // fixumTxs.addAll(Transactio.grab(par!.fixumTransactions.where((ft) => ft.interioreTransactio.probatur == true)));
//       List<String> ltum = [];
//       liberTxs.map((lt) => lt.interioreTransactio.identitatis).forEach(ltum.add);
//       List<Telum> impetus = [];
//       impetus.addAll(await Pera.maximeArma(true, ip.inimicus!.primis!, true,
//           ip.inimicus!.gladiatorIdentitatis!, lo));
//       impetus.addAll(await Pera.maximeArma(false, ip.inimicus!.primis!, true,
//           ip.inimicus!.gladiatorIdentitatis!, lo));
//       List<Telum> defensiones = [];
//       defensiones.addAll(await Pera.maximeArma(
//           true, ip.victima!.primis!, false, ip.victima!.gladiatorIdentitatis!, lo));
//       defensiones.addAll(await Pera.maximeArma(false, ip.victima!.primis!, false,
//           ip.victima!.gladiatorIdentitatis!, lo));
//       List<String> gladii = impetus.map((e) => e.telum).toList();
//       List<String> scuta = defensiones.map((e) => e.telum).toList();
//       final baseDefensio = await Pera.turpiaGladiatoriaTelum(
//           ip.victima!.primis!, false, ip.victima!.gladiatorIdentitatis!, lo);
//       final baseImpetus = await Pera.turpiaGladiatoriaTelum(
//           ip.inimicus!.primis!, true, ip.inimicus!.gladiatorIdentitatis!, lo);
//       gladii.add(baseImpetus);
//       scuta.add(baseDefensio);
//       scuta.removeWhere((impetus) => gladii.any((ag) => ag == impetus));
//       List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
//       BigInt numerus = await Obstructionum.numeruo(on);
//       InterioreObstructionum interiore = InterioreObstructionum.expressi(
//           estFurca: estFurca,
//           obstructionumDifficultas: obstructionumDifficultas.length,
//           divisa: (numerus / await Obstructionum.utSummaDifficultas(lo)),
//           forumCap: await Obstructionum.accipereForumCap(lo),
//           liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
//           fixumForumCap: await Obstructionum.accipereForumCapLiberFixum(false, lo),
//           summaObstructionumDifficultas: await Obstructionum.utSummaDifficultas(lo),
//           obstructionumNumerus: on,
//           producentis: argumentis!.publicaClavis,
//           priorProbationem: priorObstructionum.probationem,
//           gladiator: Gladiator.nullam(InterioreGladiator.ce(input: await InterioreGladiator.cegi(privatusClavis: ip.privatusClavis!, inimicus: GladiatorInputPar(ip.inimicus!.primis!, ip.inimicus!.gladiatorIdentitatis!), victima: GladiatorInputPar(ip.victima!.primis!, ip.victima!.gladiatorIdentitatis!), lo: lo))),
//           liberTransactions: liberTxs,
//           fixumTransactions: fixumTxs,
//           expressiTransactions: [],
//           connexaLiberExpressis: [],
//           siRemotiones: lsr,
//           solucionisRationibus: [],
//           fissileSolucionisRationibus: [],
//           prior: priorObstructionum);
//       ReceivePort acciperePortus = ReceivePort();
//       stamina.expressiThreads.add(await Isolate.spawn(Obstructionum.expressi,
//           List<dynamic>.from([interiore, scuta, acciperePortus.sendPort])));
//       acciperePortus.listen((nuntius) async {
//         print('whydoyouhitthistwice?');
//         Obstructionum obstructionum = nuntius as Obstructionum;
//         stamina.expressiThreads.forEach((et) => et.kill(priority: Isolate.immediate));
//         await par!.syncBlock(obstructionum);
//       });
//       return Response.ok(json.encode({
//         "nuntius": "coepi expressi miner",
//         "message": "started expressi miner",
//         "threads": stamina.expressiThreads.length
//       }));    
//   } on BadRequest catch (e) {
//     return Response.badRequest(body: json.encode(e.toJson()));
//   }

// }

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
