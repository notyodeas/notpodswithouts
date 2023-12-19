import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf_router/shelf_router.dart';
import '../auxiliatores/fossor_praecipuus.dart';
import '../auxiliatores/requiritur_in_probationem.dart';
import '../connect/par_ad_rimor.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/errors.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/incipit_pugna.dart';
import '../exempla/solucionis_propter.dart';
import '../exempla/telum.dart';
import '../exempla/transactio.dart';
import '../connect/pervideas_to_pervideas.dart';
import 'package:shelf/shelf.dart';
import 'package:tuple/tuple.dart';
import '../exempla/constantes.dart';
import '../exempla/utils.dart';
import 'package:collection/collection.dart';
import '../server.dart';
// Directory directory;
// late String gladiatorId;
// late int gladiatorIndex;
// late String gladiatorPrivateKey;
// P2P p2p;
// Aboutconfig aboutconfig;
// List<Isolate> confussuses;
// bool isSalutaris;
// Map<String, Isolate> propterIsolates;
// Map<String, Isolate> liberTxIsolates;
// Map<String, Isolate> fixumTxIsolates;
// Map<String, Isolate> humanifyIsolates;
// Map<String, Isolate> scanIsolates;
// Map<String, Isolate> cashExIsolates;

// Future<Response> fossorConfussus(Request req) async {
//     Directory directorium =
//       Directory('vincula/${argumentis!.obstructionumDirectorium}');
  
//   List<Obstructionum> alo = await Obstructionum.getBlocks(directorium);
//   List<Transactio> alt = [];
//   alo.map((mo) => mo.interioreObstructionum.liberTransactions).forEach(alt.addAll);
  
//   int maximeObiecti = 100;
//   List<Transactio> ltlt = [];
//   List<Propter> lp = [];
//   List<SiRemotionem> lsr = [];
  
//   for (int i = 128; i > 0; i--) {
//     List<Transactio> aflt = [];
//     List<Transactio> rflt = [];
//     ltlt.addAll((maximeObiecti -= par!.liberTransactions.where((wlt) => wlt.probationem.startsWith('0' * i)).length) > 0 ? par!.liberTransactions.where((wlt) => wlt.probationem.startsWith('0' * i)) : []);
//     for (Transactio tlt in ltlt.reversed) {
//       for (TransactioInput tilt in tlt.interioreTransactio.inputs) {
//         if (!alt.any((aalt) => aalt.interioreTransactio.identitatis == tilt.transactioIdentitatis) && 
//         par!.liberTransactions.any((aplt) => aplt.interioreTransactio.identitatis == tilt.transactioIdentitatis) &&
//         !ltlt.any((alt) => alt.interioreTransactio.identitatis == tilt.transactioIdentitatis)) {
//           aflt.add(par!.liberTransactions.singleWhere((sw) => sw.interioreTransactio.identitatis == tilt.transactioIdentitatis));
//         } else {
//           rflt.add(tlt);
//         }
//       }  
//     }
//     ltlt.addAll(aflt);
//     ltlt.removeWhere((rwlt) => rflt.any((arlt) => arlt.interioreTransactio.identitatis == rwlt.interioreTransactio.identitatis));
//   }
//   return Response.ok(json.encode(ltlt.map((e) => e.toJson()).toList()));
// }


Future<Response> fossorConfussus(Request req) async {
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
      // so the thread is stull running while the block already is mined so stop the thread from spinning if successful
      Obstructionum priorObstructionum =
          await Obstructionum.acciperePrior(directorium);
      Gladiator? gladiator = await Obstructionum.grabGladiator(
          ip.victima!.gladiatorIdentitatis!, lo);
      if (gladiator == null) {
        return Response.badRequest(
            body: json.encode({
          "code": 1,
          "nuntius": "Gladiator iam victus aut non inveni",
          "message": "Gladiator already defeaten or not found"
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
    COE coe = await COE.computo(100, prior, gladiator, ip, par!.liberTransactions, lo);
    FossorPraecipuus fp = FossorPraecipuus.coe(llttbi: coe.llt, lfttbi: coe.lft, efectus: false, maxime: coe.maxime, llt: par!.liberTransactions.where((wlt) => wlt.interioreTransactio.probatur) , lft: par!.fixumTransactions.where((wft) => wft.interioreTransactio.probatur), let: par!.expressiTransactions, lcle: par!.connexiaLiberExpressis, lsr: par!.siRemotiones, lp: par!.rationibus, lsp: par!.solucionisRationibus, lfsp: par!.fissileSolucionisRationibus, lo: lo);
    for (SiRemotionem sr in fp.lsrtbi.where((wlsr) => wlsr.interioreSiRemotionem.siRemotionemInput != null)) {
        sr.interioreSiRemotionem.siRemotionemInput?.interioreTransactio = null;
    }
    List<String> scuta = await RequiriturInProbationem.requiriturInProbationem(ip, lo);
    List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
    BigInt numerus = await Obstructionum.numeruo(on);
    final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
    InterioreObstructionum interiore = InterioreObstructionum.confussus(
      estFurca: estFurca,
      obstructionumDifficultas: obstructionumDifficultas.length,
      divisa: (numerus / await Obstructionum.utSummaDifficultas(lo)),
      forumCap: await Obstructionum.accipereForumCap(lo),
      liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
      fixumForumCap:
          await Obstructionum.accipereForumCapLiberFixum(false, lo),
      summaObstructionumDifficultas:
          await Obstructionum.utSummaDifficultas(lo),
      obstructionumNumerus: on,
      producentis: argumentis!.publicaClavis,
      priorProbationem: priorObstructionum.probationem,
      gladiator: Gladiator.nullam(InterioreGladiator.ce(input: await InterioreGladiator.cegi(privatusClavis: ip.privatusClavis!, inimicus: GladiatorInputPar(ip.inimicus!.primis!, ip.inimicus!.gladiatorIdentitatis!), victima: GladiatorInputPar(ip.victima!.primis!, ip.victima!.gladiatorIdentitatis!), lo: lo))),
      liberTransactions: fp.llttbi,
      fixumTransactions: fp.lfttbi,
      expressiTransactions: [],
      connexaLiberExpressis: [],
      siRemotiones: fp.lsrtbi,
      solucionisRationibus: fp.lsptbi,
      fissileSolucionisRationibus: fp.lfsptbi,
      prior: priorObstructionum);
    ReceivePort acciperePortus = ReceivePort();
    stamina.confussusThreads.add(await Isolate.spawn(Obstructionum.confussus,
        List<dynamic>.from([interiore, scuta, acciperePortus.sendPort])));
    acciperePortus.listen((nuntius) async {
      Obstructionum obstructionum = nuntius as Obstructionum;
      stamina.confussusThreads.forEach((ct) => ct.kill());
      await par!.syncBlock(obstructionum);
    });
    return Response.ok(json.encode({
      "nuntius": "coepi confussus miner",
      "message": "started confussus miner",
      "threads": stamina.confussusThreads.length
    })); 
  } on BadRequest catch (e) {
     return Response.badRequest(body: json.encode(e.toJson()));
  }
}




// Future<Response> fossorConfussus(Request req) async {
//   bool estFurca = bool.parse(req.params['furca']!);
//   try {
//     IncipitPugna ip =
//         IncipitPugna.fromJson(json.decode(await req.readAsString()));
//     Directory directory =
//         Directory('vincula/${argumentis!.obstructionumDirectorium}');
//     List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
//     if (!File('${directory.path}/${Constantes.caudices}0.txt').existsSync()) {
//       return Response.badRequest(
//           body: json.encode({
//         "code": 0,
//         "nuntius": "adhuc expectans incipio obstructionum",
//         "message": "Still waiting on incipio block"
//       }));
//     }
//     // so the thread is stull running while the block already is mined so stop the thread from spinning if successful
//     Obstructionum priorObstructionum =
//         await Obstructionum.acciperePrior(directory);
//     Gladiator? gladiatorOppugnare = await Obstructionum.grabGladiator(
//         ip.victima!.gladiatorIdentitatis!, lo);
//     if (gladiatorOppugnare == null) {
//       return Response.badRequest(
//           body: json.encode({
//         "code": 1,
//         "nuntius": "Gladiator iam victus aut non inveni",
//         "message": "Gladiator already defeaten or not found"
//       }));
//     }
//     PrivateKey pk = PrivateKey.fromHex(Pera.curve(), ip.privatusClavis!);
//       if (await Obstructionum.gladiatorConfodiantur(
//           ip.victima!.gladiatorIdentitatis!, pk.publicKey.toHex(), lo)) {
//         return Response.badRequest(
//             body: json.encode({
//           "code": 2,
//           "message": "Non te oppugnare",
//           "english": "Can not attack yourself"
//         }));
//       }
//     List<Transactio> fixumTxs = [];
//     List<Transactio> liberTxs = [];
//     liberTxs.addAll(Transactio.grab(par!.liberTransactions
//         .where((wlt) => wlt.interioreTransactio.probatur == true)));
    
//     fixumTxs.addAll(Transactio.grab(par!.fixumTransactions
//         .where((wft) => wft.interioreTransactio.probatur == true)));
//     List<SiRemotionem> lsr = SiRemotionem.grab(par!.siRemotiones);
//     liberTxs.addAll(lsr.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null && wsr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!.liber).map((msr) => Transactio.nullam(msr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!)));
//     fixumTxs.addAll(lsr.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null && !wsr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!.liber).map((msr) => Transactio.nullam(msr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!)));
//     for (SiRemotionem sr in lsr.where((wlsr) => wlsr.interioreSiRemotionem.siRemotionemInput != null)) {
//       sr.interioreSiRemotionem.siRemotionemInput?.interioreTransactio = null;
//     }
//     List<Transactio> ltb = [];
//     for (String acc in gladiatorOppugnare
//         .interioreGladiator.outputs[ip.victima!.primis! ? 0 : 1].rationibus
//         .map((e) => e.interiorePropter.publicaClavis)) {
//           InterioreTransactio? it = await Pera.perdita(
//             PrivateKey.fromHex(Pera.curve(), ip.privatusClavis!),
//             acc,
//             priorObstructionum.probationem,
//             liberTxs,
//             lo);
//           if (it != null) {
//             ltb.add(Transactio.nullam(it));
//           }
//     }
//     // return Response.ok({});
//     Tuple2<InterioreTransactio?, InterioreTransactio?> transform =
//         await Pera.transformFixum(
//             ip.privatusClavis!, liberTxs, lo);
//     if (transform.item1 != null) {
//       print(transform.item1!.toJson());
//       liberTxs.add(Transactio.nullam(transform.item1!));
//     }
//     if (transform.item2 != null) {
//       print(transform.item2!.toJson());
//       fixumTxs.add(Transactio.nullam(transform.item2!));
//     }
//     liberTxs.addAll(ltb);
//     List<Telum> impetus = [];
//     impetus.addAll(await Pera.maximeArma(true, ip.inimicus!.primis!, true,
//         ip.inimicus!.gladiatorIdentitatis!, lo));
//     impetus.addAll(await Pera.maximeArma(false, ip.inimicus!.primis!, false,
//         ip.inimicus!.gladiatorIdentitatis!, lo));
//     List<Telum> defensiones = [];
//     defensiones.addAll(await Pera.maximeArma(true, ip.inimicus!.primis!, false,
//         gladiatorOppugnare.interioreGladiator.identitatis, lo));
//     defensiones.addAll(await Pera.maximeArma(false, ip.inimicus!.primis!, false,
//         gladiatorOppugnare.interioreGladiator.identitatis, lo));
//     List<String> gladii = impetus.map((e) => e.telum).toList();
//     List<String> scuta = defensiones.map((e) => e.telum).toList();
//     final String baseDefensio = await Pera.turpiaGladiatoriaTelum(
//         ip.victima!.primis!, false, ip.victima!.gladiatorIdentitatis!, lo);
//     final String baseImpetum = await Pera.turpiaGladiatoriaTelum(
//         ip.inimicus!.primis!, true, ip.inimicus!.gladiatorIdentitatis!, lo);
//     scuta.add(baseDefensio);
//     gladii.add(baseImpetum);
//     scuta.removeWhere((defensio) => gladii.any((ag) => ag == defensio));
//     List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
//     BigInt numerus = await Obstructionum.numeruo(on);
//     final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
//     InterioreObstructionum interiore = InterioreObstructionum.confussus(
//         estFurca: estFurca,
//         obstructionumDifficultas: obstructionumDifficultas.length,
//         divisa: (numerus / await Obstructionum.utSummaDifficultas(lo)),
//         forumCap: await Obstructionum.accipereForumCap(lo),
//         liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
//         fixumForumCap:
//             await Obstructionum.accipereForumCapLiberFixum(false, lo),
//         summaObstructionumDifficultas:
//             await Obstructionum.utSummaDifficultas(lo),
//         obstructionumNumerus: on,
//         producentis: argumentis!.publicaClavis,
//         priorProbationem: priorObstructionum.probationem,
//         gladiator: Gladiator.nullam(InterioreGladiator.ce(input: await InterioreGladiator.cegi(privatusClavis: ip.privatusClavis!, inimicus: GladiatorInputPar(ip.inimicus!.primis!, ip.inimicus!.gladiatorIdentitatis!), victima: GladiatorInputPar(ip.victima!.primis!, ip.victima!.gladiatorIdentitatis!), lo: lo))),
//         liberTransactions: liberTxs,
//         fixumTransactions: fixumTxs,
//         expressiTransactions: [],
//         connexaLiberExpressis: [],
//         siRemotiones: lsr,
//         solucionisRationibus: [],
//         fissileSolucionisRationibus: [],
//         prior: priorObstructionum);
//     ReceivePort acciperePortus = ReceivePort();
//     stamina.confussusThreads.add(await Isolate.spawn(Obstructionum.confussus,
//         List<dynamic>.from([interiore, scuta, acciperePortus.sendPort])));
//     acciperePortus.listen((nuntius) async {
//       Obstructionum obstructionum = nuntius as Obstructionum;
//       stamina.confussusThreads.forEach((ct) => ct.kill());
//       await par!.syncBlock(obstructionum);
//     });
//     return Response.ok(json.encode({
//       "nuntius": "coepi confussus miner",
//       "message": "started confussus miner",
//       "threads": stamina.confussusThreads.length
//     }));
//   } on BadRequest catch (e) {
//     return Response.badRequest(body: json.encode(e.toJson()));
//   }
// }

Future<Response> confussusThreads(Request req) async {
  return Response.ok(json.encode({
    "relatorum": stamina.confussusThreads.length,
    "threads": stamina.confussusThreads.length
  }));
}

Future<Response> prohibereConfussus(Request req) async {
  for (int i = 0; i < stamina.efectusThreads.length; i++) {
    stamina.confussusThreads[i].kill(priority: Isolate.immediate);
  }
  return Response.ok(json.encode({
    "nuntius": "bene substitit confussus miner",
    "message": "succesfully stopped confussus miner",
  }));
}
