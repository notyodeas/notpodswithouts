import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import '../exempla/exempla.dart';
import '../exempla/pera.dart';
import '../exempla/transaction.dart';
import '../connect/pervideas_to_pervideas.dart';
import '../exempla/errors.dart';
import '../server.dart';

Future<Response> submittereLiberTransactio(Request req) async {
  SubmittereTransaction st =
      SubmittereTransaction.fromJson(json.decode(await req.readAsString()));
  Directory directory =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  try {
    if (st.pod == BigInt.zero) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 0,
                  nuntius: "non potest mittere 0",
                  message: "can not send 0")
              .toJson()));
    }
    PrivateKey pk = PrivateKey.fromHex(Pera.curve(), st.privatus!);
    if (pk.publicKey.toHex() == st.publica) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 0,
                  message: "potest mittere pecuniam publicam clavem",
                  nuntius: "can not send money to the same public key")
              .toJson()));
    }
    if (!await Pera.isPublicaClavisDefended(st.publica!, directory) &&
        !await Pera.isProbationum(st.publica!, directory)) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 1,
                  nuntius: 'accipientis non defenditur',
                  message: 'public key is not defended')
              .toJson()));
    }
    final InterioreTransaction tx = await Pera.novamRem(true, true,
        st.privatus!, st.pod!, st.publica!, ptp!.liberTxs, directory, null);
    ptp!.liberTxs.add(Transaction.expressi(tx));
    ptp!.expressieTxs.add(Transaction.expressi(await Pera.novamRem(true, false,
        st.privatus!, st.pod!, st.publica!, ptp!.liberTxs, directory, tx.id)));
    ReceivePort acciperePortus = ReceivePort();
    isolates.liberTxIsolates[tx.id] = await Isolate.spawn(Transaction.quaestum,
        List<dynamic>.from([tx, acciperePortus.sendPort]));
    acciperePortus.listen((transaction) {
      ptp!.syncLiberTx(transaction as Transaction);
    });
    return Response.ok(json.encode({"transactionIdentitatis": tx.id}));
  } on BadRequest catch (br) {
    return Response.badRequest(body: json.encode(br.toJson()));
  }
}

Future<Response> liberTransactioStagnum(Request req) async {
  return Response.ok(
      json.encode(ptp!.liberTxs.map((e) => e.toJson()).toList()));
}

Future<Response> removereLiberTransactioStagnum(Request req) async {
  ptp!.liberTxs = [];
  return Response.ok(json.encode({
    "nuntius": "Liber transactios remota sunt a stagnum",
    "message": "Liber transactions are removed from the pool"
  }));
}
