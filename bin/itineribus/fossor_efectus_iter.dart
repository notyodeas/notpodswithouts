import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:isolate';
import '../connect/pervideas_to_pervideas.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/transaction.dart';
import '../exempla/constantes.dart';
// import '../exempla/transaction.dart';
import '../exempla/utils.dart';
import 'package:collection/collection.dart';
import '../server.dart';

Future<Response> fossor(Request req) async {
  final loop = bool.parse(req.params['loop']!);
  try {
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
    Obstructionum priorObstructionum =
        await Utils.priorObstructionum(directory);
    ReceivePort acciperePortus = ReceivePort();
    List<Propter> propters = [];
    propters.addAll(Gladiator.grab(
        priorObstructionum.interioreObstructionum.propterDifficultas,
        ptp!.propters));
    List<Transaction> liberTxs = [];
    liberTxs.add(Transaction(
        Constantes.txObstructionumPraemium,
        InterioreTransaction(
            true,
            [],
            [
              TransactionOutput(argumentis!.publicaClavis,
                  Constantes.obstructionumPraemium, null)
            ],
            Utils.randomHex(32))));
    liberTxs.addAll(Transaction.grab(
        priorObstructionum.interioreObstructionum.liberDifficultas,
        ptp!.liberTxs));
    List<Transaction> fixumTxs = [];
    fixumTxs.addAll(Transaction.grab(
        priorObstructionum.interioreObstructionum.fixumDifficultas,
        ptp!.fixumTxs));
    final obstructionumDifficultas =
        await Obstructionum.utDifficultas(directory);
    BigInt numerus = BigInt.zero;
    for (int nuschum in await Obstructionum.utObstructionumNumerus(directory)) {
      numerus += BigInt.parse(nuschum.toString());
    }
    // List<Scan> praemium = priorObstructionum.interioreObstructionum.scans;
    // List<List<Scan>> scaschans = [];
    // List<Obstructionum> obss = await Utils.getObstructionums(directory);
    // for (Obstructionum obs in obss) {
    //   scaschans.add(obs.interioreObstructionum.scans);
    // }
    // final cex = priorObstructionum.interioreObstructionum.cashExs;
    // for (int i = 0; i < cex.length; i++) {
    //   liberTxs.add(Transaction(
    //       Constantes.cashEx,
    //       InterioreTransaction(
    //           false,
    //           [],
    //           [
    //             TransactionOutput(cex[i].interioreCashEx.signumCashEx.public,
    //                 cex[i].interioreCashEx.signumCashEx.nof, i)
    //           ],
    //           Utils.randomHex(32))));
    // }
    InterioreObstructionum interiore = InterioreObstructionum.efectus(
      obstructionumDifficultas: obstructionumDifficultas.length,
      divisa: (numerus / await Obstructionum.utSummaDifficultas(directory)),
      forumCap: await Obstructionum.accipereForumCap(directory),
      liberForumCap:
          await Obstructionum.accipereForumCapLiberFixum(true, directory),
      fixumForumCap:
          await Obstructionum.accipereForumCapLiberFixum(false, directory),
      propterDifficultas:
          Obstructionum.acciperePropterDifficultas(priorObstructionum),
      liberDifficultas:
          Obstructionum.accipereLiberDifficultas(priorObstructionum),
      fixumDifficultas:
          Obstructionum.accipereFixumDifficultas(priorObstructionum),
      // scanDifficultas:
      //     Obstructionum.accipereScanDifficultas(priorObstructionum),
      // cashExDifficultas:
      //     Obstructionum.accipereCashExDifficultas(priorObstructionum),
      summaObstructionumDifficultas:
          await Obstructionum.utSummaDifficultas(directory),
      obstructionumNumerus:
          await Obstructionum.utObstructionumNumerus(directory),
      producentis: argumentis!.publicaClavis,
      priorProbationem: priorObstructionum.probationem,
      gladiator: Gladiator(
          null,
          [
            GladiatorOutput(
                propters.take((propters.length / 2).round()).toList()),
            GladiatorOutput(
                propters.skip((propters.length / 2).round()).toList())
          ],
          Utils.randomHex(32)),
      liberTransactions: liberTxs,
      fixumTransactions: fixumTxs,
      expressiTransactions: ptp!.expressieTxs
          .where((tx) => liberTxs.any((l) =>
              l.interioreTransaction.id == tx.interioreTransaction.expressi))
          .toList(),
      // scans: Scan.grab(
      //     priorObstructionum.interioreObstructionum.scanDifficultas,
      //     p2p.scans),
      // humanify: Humanify.grab(p2p.humanifies),
      // cashExs: CashEx.grab(
      //     priorObstructionum.interioreObstructionum.cashExDifficultas,
      // p2p.cashExs)
    );
    stamina.efectusThreads.add(await Isolate.spawn(Obstructionum.efectus,
        List<dynamic>.from([interiore, acciperePortus.sendPort])));
    ptp!.isEfectusActive = true;
    acciperePortus.listen((nuntius) async {
      while (isSalutaris) {
        await Future.delayed(Duration(seconds: 1));
      }
      isSalutaris = true;
      Obstructionum obstructionum = nuntius as Obstructionum;
      Obstructionum priorObs = await Utils.priorObstructionum(directory);
      if (ListEquality().equals(
          obstructionum.interioreObstructionum.obstructionumNumerus,
          priorObs.interioreObstructionum.obstructionumNumerus)) {
        print('invalid blocknumber retrying');
        ptp!.efectusRp.sendPort.send("update miner");
        isSalutaris = false;
        return;
      }
      if (priorObs.probationem !=
          obstructionum.interioreObstructionum.priorProbationem) {
        print('invalid probationem');
        isSalutaris = false;
        ptp!.efectusRp.sendPort.send("update miner");
        return;
      }
      List<GladiatorOutput> outputs = [];
      for (GladiatorOutput output
          in obstructionum.interioreObstructionum.gladiator.outputs) {
        output.rationem.map((r) => r.interioreRationem.id).forEach((id) =>
            isolates.propterIsolates[id]?.kill(priority: Isolate.immediate));
        outputs.add(output);
      }
      obstructionum.interioreObstructionum.liberTransactions
          .map((e) => e.interioreTransaction.id)
          .forEach((id) =>
              isolates.liberTxIsolates[id]?.kill(priority: Isolate.immediate));
      obstructionum.interioreObstructionum.fixumTransactions
          .map((e) => e.interioreTransaction.id)
          .forEach((id) =>
              isolates.fixumTxIsolates[id]?.kill(priority: Isolate.immediate));
      List<String> gladiatorIds = [];
      for (GladiatorOutput output in outputs) {
        gladiatorIds.addAll(
            output.rationem.map((r) => r.interioreRationem.id).toList());
      }
      // humanifyIsolates[
      //         obstructionum.interioreObstructionum.humanify?.interiore.id]
      //     ?.kill(priority: Isolate.immediate);
      // if (obstructionum.interioreObstructionum.humanify != null) {
      //   p2p.removeHumanify(
      //       obstructionum.interioreObstructionum.humanify!.interiore.id);
      // }
      // obstructionum.interioreObstructionum.cashExs
      //     .map((c) => c.interioreCashEx.signumCashEx.id)
      //     .forEach(
      //         (id) => cashExIsolates[id]?.kill(priority: Isolate.immediate));
      // obstructionum.interioreObstructionum.scans
      //     .map((s) => s.interioreScan.id)
      //     .forEach(
      //         (id) => scanIsolates[id]?.kill(priority: Isolate.immediate));
      // p2p.removeScans(obstructionum.interioreObstructionum.scans
      //     .map((s) => s.interioreScan.id)
      //     .toList());
      // p2p.removeCashExs(obstructionum.interioreObstructionum.cashExs
      //     .map((c) => c.interioreCashEx.signumCashEx.id)
      //     .toList());
      ptp!.removePropters(gladiatorIds);
      ptp!.removeLiberTxs(obstructionum.interioreObstructionum.liberTransactions
          .map((l) => l.interioreTransaction.id)
          .toList());
      ptp!.removeFixumTxs(obstructionum.interioreObstructionum.fixumTransactions
          .map((f) => f.interioreTransaction.id)
          .toList());
      ptp!.syncBlocks.forEach((e) => e.kill(priority: Isolate.immediate));
      ptp!.syncBlocks.add(await Isolate.spawn(
          PervideasToPervideas.syncBlock,
          List<dynamic>.from([
            obstructionum,
            ptp!.sockets,
            directory,
            '${argumentis!.internumIp}:${argumentis!.pervideasPort}'
          ])));

      await obstructionum.salvare(directory);
      ptp!.expressieTxs = [];
      if (loop) {
        ptp!.efectusRp.sendPort.send("update miner");
      }
      if (ptp!.isConfussusActive) {
        ptp!.confussusRp.sendPort.send('update miner');
      }
      if (ptp!.isExpressiActive) {
        ptp!.expressiRp.sendPort.send("update miner");
      }
      isSalutaris = false;
    });
    return Response.ok(json.encode({
      "nuntius": "coepi efectus miner",
      "message": "started efectus miner",
      "threads": stamina.efectusThreads.length
    }));
  } catch (err, s) {
    print(err);
    print(s);
    return Response.badRequest();
  }
}

Future<Response> relatorum(Request req) async {
  return Response.ok(json.encode({"threads": stamina.efectusThreads.length}));
}

Future<Response> prohibere(Request req) async {
  for (int i = 0; i < stamina.efectusThreads.length; i++) {
    stamina.efectusThreads[i].kill(priority: Isolate.immediate);
  }
  return Response.ok(json.encode({
    "nuntius": "bene substitit efectus miner",
    "message": "succesfully stopped efectus miner",
  }));
}
