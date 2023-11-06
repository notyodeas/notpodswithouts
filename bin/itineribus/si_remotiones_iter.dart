import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/obstructionum.dart';
import '../exempla/petitio/submittere_si-remotionem.dart';
import '../exempla/responsio/recipiens_si_remotionem.dart';
import '../exempla/responsio/transactio_submittere_responsionis.dart';
import '../exempla/transactio.dart';
import '../server.dart';

class Dominium {
  String publicaClavis;
  Transactio transactio;
  Dominium(this.publicaClavis, this.transactio);
}

Future<Response> siRemotionessubmittereProof(Request req) async {
  SubmittereSiRemotionem ssr =
      SubmittereSiRemotionem.fromJson(json.decode(await req.readAsString()));
  Transactio lt = ssr.liber!
      ? par!.liberTransactions.singleWhere(
          (swlt) => swlt.interioreTransactio.identitatis == ssr.identitatis)
      : par!.fixumTransactions.singleWhere(
          (swft) => swft.interioreTransactio.identitatis == ssr.identitatis);
  lt.interioreTransactio.probatur = true;
  SiRemotionem reschet = lt.interioreTransactio.siRemotionem!;
  lt.interioreTransactio.siRemotionem = null;
  ReceivePort rp = ReceivePort();
  isolates.liberTxIsolates[lt.interioreTransactio.identitatis] =
      await Isolate.spawn(Transactio.quaestum,
          List<dynamic>.from([lt.interioreTransactio, rp.sendPort]));
  rp.listen((transactio) {
    par!.syncLiberTransaction(transactio as Transactio);
  });
  return Response.ok(json.encode(reschet.toJson()));
}

Future<Response> siRemotionesreprehendoSiExistat(Request req) async {
  bool liber = bool.parse(req.params[JSON.liber]!);
  String identitatis = req.params[JSON.identitatis]!;
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}');
  if (liber
      ? par!.liberTransactions
          .any((alt) => alt.interioreTransactio.identitatis == identitatis)
      : par!.fixumTransactions
          .any((alt) => alt.interioreTransactio.identitatis == identitatis)) {
    return Response.ok(true);
  }
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  List<Transactio> lt = [];
  lo
      .map((mo) => mo.interioreObstructionum.liberTransactions)
      .forEach(lt.addAll);
  lo
      .map((mo) => mo.interioreObstructionum.fixumTransactions)
      .forEach(lt.addAll);
  if (lt.any((at) => at.interioreTransactio.identitatis == identitatis)) {
    return Response.ok(false);
  } else {
    return Response.notFound({});
  }
}

Future<Response> siRemotionesdenuoProponendam(Request req) async {
  InterioreSiRemotionem sr =
      InterioreSiRemotionem.fromJson(json.decode(await req.readAsString()));
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  List<Transactio> lt = [];
  lo
      .map((mo) => sr.siRemotionemOutput!.liber
          ? mo.interioreObstructionum.liberTransactions
          : mo.interioreObstructionum.fixumTransactions)
      .forEach(lt.addAll);
  if (lt.any((alt) =>
      alt.interioreTransactio.identitatis ==
      sr.siRemotionemOutput!.transactioIdentitatis)) {
    return Response.badRequest(
        body: json.encode(BadRequest(
                code: 0,
                nuntius: 'transactio quae numquam remotus est',
                message: 'transaction has never been removed')
            .toJson()));
  }
  ReceivePort rp = ReceivePort();
  isolates.siRemotionemIsolates[sr.identitatisInterioreSiRemotionem] =
      await Isolate.spawn(
          SiRemotionem.quaestum, List<dynamic>.from([sr, rp.sendPort]));
  rp.listen((dp) {
    par!.syncSiRemotiones(dp as SiRemotionem);
  });
  return Response.ok(json.encode({
    "nuntius": "tuum remotum res exspectat prioritas piscinae",
    "message": "your removed transaction is waiting in the priority pool"
  }));
}

Future<Response> siRemotionesStagnum(Request req) async {
  return Response.ok(
      json.encode(par!.siRemotiones.map((e) => e.toJson()).toList()));
}
