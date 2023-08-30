// import 'package:conduit/conduit.dart';
// import 'package:appologi_es/appologi_es.dart';
// import 'package:appologi_es/exempla/obstructionum.dart';
// import 'package:appologi_es/exempla/utils.dart';
// import 'package:collection/collection.dart';
// import 'package:appologi_es/p2p.dart';
// import '../exempla/exampla.dart';
// import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'dart:convert';
import '../exempla/exempla.dart';
import '../exempla/obstructionum.dart';
import '../exempla/utils.dart';
import '../server.dart';
import '../exempla/constantes.dart';
import 'package:shelf_router/shelf_router.dart';

Future<Response> obstructionum(Request req) async {
  final ObstructionumNumerus on =
      ObstructionumNumerus.fromJson(json.decode(await req.readAsString()));
  try {
    File file = File(
        'vincula/${argumentis!.obstructionumDirectorium}/${Constantes.caudices}${(on.numerus!.length - 1).toString()}.txt');
    return Response.ok(await Utils.fileAmnis(file)
        .elementAt(on.numerus![on.numerus!.length - 1]));
  } catch (err) {
    return Response.notFound(json.encode({
      "code": 0,
      "nuntius": "angustos non inveni",
      "message": "block not found"
    }));
  }
}

Future<Response> prior(Request req) async {
  Obstructionum obs = await Utils.priorObstructionum(
      Directory('vincula/${argumentis!.obstructionumDirectorium}'));
  return Response.ok(json.encode(obs.toJson()));
}

Future<Response> probationemGenerare(Request req) async {
  final probationem = req.params['probationem'];
  Obstructionum obs = await Utils.accipereObstructionumProbationem(probationem!,
      Directory('vincula/${argumentis!.obstructionumDirectorium}'));
  return Response.ok(json.encode(
      {"generare": obs.interioreObstructionum.generare.name.toString()}));
}

Future<Response> furcaUnumRetro(Request req) async {
  Directory directory =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  Obstructionum obs = await Utils.priorObstructionum(directory);
  if (obs.interioreObstructionum.generare == Generare.INCIPIO) {
    return Response.badRequest(
        body: json.encode({
      "code": 0,
      "nuntius": "Incipio scandalum removere non potes",
      "message": "You can't remove the Incipio block"
    }));
  }
  await Utils.removeObstructionumsUntilProbationem(directory);
  ptp!.liberTxs = [];
  ptp!.fixumTxs = [];
  ptp!.propters = [];
  stamina.efectusThreads = [];
  return Response.ok(json.encode({
    "nuntius": "remotus",
    "message": "removed",
    "obstructionum": obs.toJson()
  }));
}
