import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:isolate';
import '../auxiliatores/fossor_praecipuus.dart';
import '../connect/par_ad_rimor.dart';
import '../connect/pervideas_to_pervideas.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/solucionis_propter.dart';
import '../exempla/transactio.dart';
import '../exempla/constantes.dart';
import '../exempla/utils.dart';
import 'package:collection/collection.dart';
import '../server.dart';
import 'obstructionum_iter.dart';


Future<Response> fossorEfectus(Request req) async {
  Directory directorium =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  bool estFurca = bool.parse(req.params['furca']!);
  List<Transactio> lltc = List<Transactio>.from(par!.liberTransactions.map((mlt) => Transactio.fromJson(mlt.toJson())));
  List<Propter> lpc = List<Propter>.from(par!.rationibus.map((mp) => Propter.fromJson(mp.toJson())));
  // List<ConnexaLiberExpressi> lclec = List<ConnexaLiberExpressi>.from(par!.connexiaLiberExpressis.map((cle) => ConnexaLiberExpressi.fromJson(cle.toJson())));
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  FossorPraecipuus fp = FossorPraecipuus(efectus: true, maxime: 100, llt: lltc.where((wltc) => wltc.interioreTransactio.probatur), lft: par!.fixumTransactions.where((wft) => wft.interioreTransactio.probatur),  let: par!.expressiTransactions.where((wet) => wet.interioreTransactio.probatur), lcle: par!.connexiaLiberExpressis, lsr: par!.siRemotiones, lp: lpc, lsp: par!.solucionisRationibus, lfsp: par!.fissileSolucionisRationibus, lo: lo);
  fp.llttbi.insert(0, Transactio.nullam(InterioreTransactio.praemium(argumentis!.publicaClavis)));
  final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
  List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
  BigInt numerus = await Obstructionum.numeruo(on);
  Obstructionum prior =
  await Obstructionum.acciperePrior(directorium);
  for (SiRemotionem sr in fp.lsrtbi.where((wlsr) => wlsr.interioreSiRemotionem.siRemotionemInput != null)) {
    sr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio = null;
  }
  ReceivePort rp = ReceivePort();
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
    priorProbationem: prior.probationem,
    gladiator: Gladiator.nullam(InterioreGladiator.efectus(
        outputs: InterioreGladiator.egos(fp.lptbi))),
    liberTransactions: fp.llttbi,
    fixumTransactions: fp.lfttbi,
    expressiTransactions: fp.lettbi,
    connexaLiberExpressis: fp.lcletbi,
    siRemotiones: fp.lsrtbi,
    solucionisRationibus: fp.lsptbi,
    fissileSolucionisRationibus: fp.lfsptbi,
    prior: prior);
    stamina.efectusThreads.add(await Isolate.spawn(Obstructionum.efectus,
      List<dynamic>.from([interiore, rp.sendPort])));
  rp.listen((nuntius) async {
    Obstructionum obstructionum = nuntius as Obstructionum;
    stamina.efectusThreads.forEach((et) => et.kill());
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
