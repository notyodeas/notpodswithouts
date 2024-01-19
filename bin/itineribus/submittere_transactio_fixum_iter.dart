import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import '../exempla/constantes.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/submittere_transactio.dart';
import '../exempla/transactio.dart';

import '../server.dart';

Future<Response> submittereFixumTransaction(Request req) async {
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  SubmittereTransaction st = SubmittereTransaction.fromJson(
      await req.readAsString() as Map<String, dynamic>);
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  if (st.pod == BigInt.zero) {
    return Response.badRequest(body: {
      "code": 0,
      "message": "non potest mittere 0",
      "english": "can not send 0"
    });
  }
  PrivateKey pk = PrivateKey.fromHex(Pera.curve(), st.ex);
  if (pk.publicKey.toHex() == st.to) {
    return Response.ok({
      "message": "potest mittere pecuniam publicam clavem",
      "english": "can not send money to the same public key"
    });
  }
  final Transactio transactio = Transactio.nullam(await Pera.novamRem(
      necessitudo: false,
      liber: false,
      twice: false,
      ts: TransactioSignificatio.regularis,
      ex: st.ex,
      value: st.pod,
      to: st.to,
      transactioStagnum: par!.fixumTransactions,
      lo: lo));
  ReceivePort acciperePortus = ReceivePort();
  isolates.fixumTxIsolates[transactio.interiore.identitatis] =
      await Isolate.spawn(
          Transactio.quaestum,
          List<dynamic>.from(
              [transactio.interiore, acciperePortus.sendPort]));
  acciperePortus.listen((transactio) {
    par!.syncFixumTransaction(transactio as Transactio);
  });
  return Response.ok(
      {"transactionIdentitatis": transactio.interiore.identitatis});
}

Future<Response> fixumTransactionStagnum(Request req) async {
  return Response.ok(par!.fixumTransactions.map((e) => e.toJson()).toList());
}
