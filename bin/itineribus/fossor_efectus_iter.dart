import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:isolate';
import '../connect/par_ad_rimor.dart';
import '../connect/pervideas_to_pervideas.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/transactio.dart';
import '../exempla/constantes.dart';
import '../exempla/utils.dart';
import 'package:collection/collection.dart';
import '../server.dart';
import 'obstructionum_iter.dart';

Future<Response> fossorEfectus(Request req) async {
  if (!File(
          'vincula/${argumentis!.obstructionumDirectorium}/${Constantes.caudices}0.txt')
      .existsSync()) {
    return Response.badRequest(
        body: json.encode({
      "nuntius": "Adhuc expectans in initio obstructionum",
      "message": "Still waiting on incipio block"
    }));
  }
  Directory directory =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  bool estFurca = bool.parse(req.params['furca']!);
  Obstructionum priorObstructionum =
      await Obstructionum.acciperePrior(directory);

  ReceivePort acciperePortus = ReceivePort();
  List<Propter> propters = [];
  propters.addAll(InterioreGladiator.grab(par!.rationibus));
  List<Transactio> liberTxs = [];
  liberTxs.add(Transactio.nullam(
      InterioreTransactio.praemium(argumentis!.publicaClavis)));
  liberTxs.addAll(Transactio.grab(par!.liberTransactions
      .where((wlt) => wlt.interioreTransactio.probatur == true)));
  List<Transactio> fixumTxs = [];
  fixumTxs.addAll(Transactio.grab(par!.fixumTransactions
      .where((wft) => wft.interioreTransactio.probatur == true)));
  List<String> ltum = [];
  liberTxs.map((lt) => lt.interioreTransactio.identitatis).forEach(ltum.add);
  List<ConnexaLiberExpressi> cles = par!.invenireConnexaLiberExpressis(ltum);
  List<Transactio> expressiTxs = par!.expressiTransactions
      .where((et) => cles.any((cle) =>
          et.interioreTransactio.identitatis ==
          cle.interioreConnexaLiberExpressi.expressiIdentitatis))
      .toList();
  liberTxs.addAll(
  priorObstructionum.interioreObstructionum.siRemotiones.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null && wsr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio.liber)
      .map((msr) => Transactio.nullam(msr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio)));
  fixumTxs.addAll(priorObstructionum.interioreObstructionum.siRemotiones.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null && !wsr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio.liber)
      .map((msr) => Transactio.nullam(msr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio)));
  List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
  final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
  List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
  BigInt numerus = await Obstructionum.numeruo(on);
  List<SiRemotionem> lsr = SiRemotionem.grab(par!.siRemotiones);
  InterioreObstructionum interiore = InterioreObstructionum.efectus(
      estFurca: estFurca,
      obstructionumDifficultas: obstructionumDifficultas.length,
      divisa: numerus / await Obstructionum.utSummaDifficultas(lo),
      forumCap: await Obstructionum.accipereForumCap(lo),
      liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
      fixumForumCap: await Obstructionum.accipereForumCapLiberFixum(false, lo),
      summaObstructionumDifficultas: await Obstructionum.utSummaDifficultas(lo),
      obstructionumNumerus: on,
      producentis: argumentis!.publicaClavis,
      priorProbationem: priorObstructionum.probationem,
      gladiator: Gladiator.nullam(InterioreGladiator.efectus(
          outputs: InterioreGladiator.egos(propters))),
      liberTransactions: liberTxs,
      fixumTransactions: fixumTxs,
      expressiTransactions: expressiTxs,
      connexaLiberExpressis: cles,
      siRemotiones: lsr,
      prior: priorObstructionum);
  stamina.efectusThreads.add(await Isolate.spawn(Obstructionum.efectus,
      List<dynamic>.from([interiore, acciperePortus.sendPort])));
  acciperePortus.listen((nuntius) async {
    Obstructionum obstructionum = nuntius as Obstructionum;
    InFieriObstructionum ifo = obstructionum.inFieriObstructionum();
    ifo.gladiatorIdentitatum.forEach((gi) =>
        isolates.propterIsolates[gi]?.kill(priority: Isolate.immediate));
    ifo.liberTransactions.forEach((lt) =>
        isolates.liberTxIsolates[lt]?.kill(priority: Isolate.immediate));
    ifo.fixumTransactions.forEach((ft) =>
        isolates.fixumTxIsolates[ft]?.kill(priority: Isolate.immediate));
    ifo.expressiTransactions.forEach((et) =>
        isolates.expressiTxIsolates[et]?.kill(priority: Isolate.immediate));
    ifo.connexaLiberExpressis.forEach((cle) {
      isolates.connexaLiberExpressiIsolates[cle]
          ?.kill(priority: Isolate.immediate);
    });
    ifo.siRemotionems.forEach((sr) =>
        isolates.siRemotionemIsolates[sr]?.kill(priority: Isolate.immediate));
    stamina.efectusThreads.forEach((et) => et.kill());
    print('libertxsafterefectus\n');
    await par!.removePropters(ifo.gladiatorIdentitatum);
    await par!.removeLiberTransactions(ifo.liberTransactions);
    await par!.removeFixumTransactions(ifo.fixumTransactions);
    await par!.removeExpressiTransactions(ifo.liberTransactions);
    await par!.removeConnexaLiberExpressis(ifo.connexaLiberExpressis);
    await par!.removeSiRemotionems(ifo.siRemotionems);
    print('libertxafterrem\n');
    print(par!.liberTransactions.map((e) => e.toJson()));    
    await par!.sumoLiberTransactions(ifo.liberTransactions);
    await par!.sumoFixumTransactions(ifo.fixumTransactions);
    await par!.sumoExpressiTransactions(ifo.expressiTransactions);
    print('captatrue\n');
    print(par!.liberTransactions.map((e) => e.toJson()));
    await par!.syncBlock(obstructionum);
  });
  return Response.ok(json.encode({
    "nuntius": "coepi efectus fossores",
    "message": "started efectus miner",
    "threads": stamina.efectusThreads.length
  }));
}

Future<Response> efectusThreads(Request req) async {
  return Response.ok(json.encode({
    "relatorum": stamina.efectusThreads.length,
    "threads": stamina.efectusThreads.length
  }));
}

Future<Response> prohibereEfectus(Request req) async {
  for (int i = 0; i < stamina.efectusThreads.length; i++) {
    stamina.efectusThreads[i].kill(priority: Isolate.immediate);
  }
  return Response.ok(json.encode({
    "nuntius": "bene substitit efectus miner",
    "message": "succesfully stopped efectus miner",
  }));
}
