import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../exempla/constantes.dart';
import '../exempla/exempla.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/transaction.dart';
import '../exempla/utils.dart';
import '../connect/pervideas_to_pervideas.dart';
import '../exempla/errors.dart';
import 'dart:convert';
import '../server.dart';

Future<Response> transactioIdentitatis(Request req) async {
  String identitatis = req.params['identitatis']!;
  Directory directory =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  List<Obstructionum> obs = [];
  for (int i = 0; i < directory.listSync().length; i++) {
    await for (String obstructionum in Utils.fileAmnis(
        File('${directory.path}${Constantes.caudices}$i.txt'))) {
      obs.add(Obstructionum.fromJson(
          json.decode(obstructionum) as Map<String, dynamic>));
    }
  }
  Obstructionum prior = await Utils.priorObstructionum(directory);
  for (InterioreObstructionum interiore
      in obs.map((o) => o.interioreObstructionum)) {
    for (Transaction tx in interiore.liberTransactions) {
      if (tx.interioreTransaction.id == identitatis) {
        TransactionInfo txInfo = TransactionInfo(
            true,
            tx.interioreTransaction.inputs.map((x) => x.transactionId).toList(),
            interiore.indicatione,
            interiore.obstructionumNumerus,
            Utils.confirmationes(interiore.obstructionumNumerus,
                prior.interioreObstructionum.obstructionumNumerus));
        return Response.ok(
            json.encode({"data": txInfo.toJson(), "scriptum": tx.toJson()}));
      }
    }
    for (Transaction tx in interiore.fixumTransactions) {
      if (tx.interioreTransaction.id == identitatis) {
        TransactionInfo txInfo = TransactionInfo(
            true,
            tx.interioreTransaction.inputs.map((x) => x.transactionId).toList(),
            interiore.indicatione,
            interiore.obstructionumNumerus,
            Utils.confirmationes(interiore.obstructionumNumerus,
                prior.interioreObstructionum.obstructionumNumerus));
        return Response.ok(
            json.encode({"data": txInfo.toJson(), "scriptum": tx.toJson()}));
      }
    }
  }
  for (Transaction tx in ptp!.liberTxs) {
    if (tx.interioreTransaction.id == identitatis) {
      TransactionInfo txInfo = TransactionInfo(
          false,
          tx.interioreTransaction.inputs.map((x) => x.transactionId).toList(),
          null,
          null,
          null);
      return Response.ok({"data": txInfo.toJson(), "scriptum": tx.toJson()});
    }
  }
  for (Transaction tx in ptp!.fixumTxs) {
    if (tx.interioreTransaction.id == identitatis) {
      TransactionInfo txInfo = TransactionInfo(
          false,
          tx.interioreTransaction.inputs.map((x) => x.transactionId).toList(),
          null,
          null,
          null);
      return Response.ok({"data": txInfo.toJson(), "scriptum": tx.toJson()});
    }
  }
  return Response.badRequest(
      body: json.encode({
    "code": 0,
    "nuntius": "Re non inveni",
    "message": "Transaction not found"
  }));
}
