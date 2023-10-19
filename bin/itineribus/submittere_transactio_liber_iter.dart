import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/submittere_transactio.dart';
import '../exempla/responsio/transactio_submittere_responsionis.dart';
import '../exempla/transactio.dart';
import '../exempla/errors.dart';
import '../server.dart';

Future<Response> submittereTransactioLiber(Request req) async {
  SubmittereTransaction st =
      SubmittereTransaction.fromJson(json.decode(await req.readAsString()));
  Directory directorium =
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
    PrivateKey pk = PrivateKey.fromHex(Pera.curve(), st.ex!);
    if (pk.publicKey.toHex() == st.to) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 0,
                  message: "potest mittere pecuniam publicam clavem",
                  nuntius: "can not send money to the same public key")
              .toJson()));
    }
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    if (!await Pera.isPublicaClavisDefended(st.to!, lo) &&
        !await Pera.isProbationum(st.to!, lo)) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 1,
                  nuntius: 'accipientis non defenditur',
                  message: 'public key is not defended')
              .toJson()));
    }
    final bool isp = await Pera.isProbationum(st.to!, lo);
    List<Transactio> stagnum = par!.liberTransactions;
    if (isp) {
      final Transactio liber = Transactio.nullam(await Pera.novamRem(
          liber: true,
          twice: true,
          ts: TransactioSignificatio.ardeat,
          ex: st.ex!,
          value: st.pod!,
          to: st.to!,
          transactioStagnum: stagnum,
          lo: lo));
      await loschog(st.ex!, st.to!, st.pod!, liber, stagnum, lo);
      return Response.ok(json.encode(TransactioSubmittereResponsionis(
              true, liber.interioreTransactio.identitatis)
          .toJson()));
    } else {
      final Transactio liber = Transactio.nullam(await Pera.novamRem(
          liber: true,
          twice: true,
          ts: TransactioSignificatio.regularis,
          ex: st.ex!,
          value: st.pod!,
          to: st.to!,
          transactioStagnum: stagnum,
          lo: lo));
      await loschog(st.ex!, st.to!, st.pod!, liber, stagnum, lo);
      return Response.ok(json.encode(TransactioSubmittereResponsionis(
              true, liber.interioreTransactio.identitatis)
          .toJson()));
    }
  } on BadRequest catch (br) {
    return Response.badRequest(body: json.encode(br.toJson()));
  }
}

Future<Response> removereTransactioStagnumLiber(Request req) async {
  par!.liberTransactions = [];
  return Response.ok(json.encode({
    "nuntius": "Liber transactios remota sunt a stagnum",
    "message": "Liber transactions are removed from the pool"
  }));
}

Future loschog(String ex, String to, BigInt pod, Transactio liber,
    List<Transactio> stagnum, List<Obstructionum> lo) async {
  stagnum.remove(liber);
  final Transactio expressi = Transactio.nullam(await Pera.novamRem(
      liber: true,
      twice: false,
      ts: TransactioSignificatio.expressi,
      ex: ex,
      value: pod,
      to: to,
      transactioStagnum: stagnum,
      lo: lo));
  stagnum.add(liber);
  final InterioreConnexaLiberExpressi icle = InterioreConnexaLiberExpressi(
      liberIdentitatis: liber.interioreTransactio.identitatis,
      expressiIdentitatis: expressi.interioreTransactio.identitatis);
  final ConnexaLiberExpressi cle = ConnexaLiberExpressi(
      PrivateKey.fromHex(Pera.curve(), ex).publicKey.toHex(), icle, ex);
  par!.syncConnexaLiberExpressi(cle);
  ReceivePort acciperePortusLiber = ReceivePort();
  ReceivePort acciperePortusExpressi = ReceivePort();
  isolates.liberTxIsolates[liber.interioreTransactio.identitatis] =
      await Isolate.spawn(
          Transactio.quaestum,
          List<dynamic>.from(
              [liber.interioreTransactio, acciperePortusLiber.sendPort]));
  isolates.expressiTxIsolates[expressi.interioreTransactio.identitatis] =
      await Isolate.spawn(
          Transactio.quaestum,
          List<dynamic>.from(
              [expressi.interioreTransactio, acciperePortusExpressi.sendPort]));
  acciperePortusLiber.listen((transactio) {
    par!.syncLiberTransaction(transactio as Transactio);
  });
  acciperePortusExpressi.listen((transactio) {
    par!.syncExpressiTransaction(transactio as Transactio);
  });
}
