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
import '../exempla/obstructionum.dart';
import '../exempla/petitio/probationem_jugum.dart';
import '../exempla/utils.dart';
import '../server.dart';
import '../exempla/constantes.dart';
import 'package:collection/collection.dart';

Future<Response> obstructionumPerNumerus(Request req) async {
  final List<int> on = List<int>.from(json.decode(await req.readAsString()));
  try {
    File file = File(
        'vincula/${argumentis!.obstructionumDirectorium}/${Constantes.caudices}${(on.length - 1).toString()}.txt');
    return Response.ok(await Utils.fileAmnis(file)
        .elementAt(on[on.length - 1]));
  } catch (err) {
    return Response.notFound(json.encode({
      "code": 0,
      "nuntius": "angustos non inveni",
      "message": "block not found"
    }));
  }
}

Future<Response> obstructionumPrior(Request req) async {
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}');
  Obstructionum o = await Obstructionum.acciperePrior(directorium);
  return Response.ok(json.encode(o.toJson()));
}

Future<Response> obstructionumRemovereUltimum(Request req) async {
  Directory directorium =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  Obstructionum obs = await Obstructionum.acciperePrior(directorium);
  if (obs.interiore.generare == Generare.incipio) {
    return Response.badRequest(
        body: json.encode({
      "code": 0,
      "nuntius": "Incipio scandalum removere non potes",
      "message": "You can't remove the Incipio block"
    }));
  }
  await Obstructionum.removereUltimumObstructionum(directorium);
  par!.liberTransactions = [];
  par!.fixumTransactions = [];
  par!.rationibus = [];
  stamina.efectusThreads = [];
  return Response.ok(json.encode({
    "nuntius": "remotus",
    "message": "removed",
    "obstructionum": obs.toJson()
  }));
}

Future<Response> obstructionumNumerus(Request req) async {
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}');
  Obstructionum obs = await Obstructionum.acciperePrior(directorium);
  return Response.ok(json
      .encode({"numerus": obs.interiore.obstructionumNumerus}));
}

Future<Response> obstructionumProbationemJugum(Request req) async {
  ProbationemJugum pj =
      ProbationemJugum.fromJson(json.decode(await req.readAsString()));
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}');
  List<Obstructionum> obs = await Obstructionum.getBlocks(directorium);
  if (obs.length == 1) return Response.ok([obs.first.probationem]);
  int start = 0;
  int end = 0;
  for (int i = 0; i < obs.length; i++) {
    if (ListEquality().equals(
        obs[i].interiore.obstructionumNumerus, pj.primis)) {
      start = i;
    }
    if (ListEquality().equals(
        obs[i].interiore.obstructionumNumerus,
        pj.novissime)) {
      end = i;
    }
  }
  return Response.ok(
      obs.map((o) => o.probationem).toList().getRange(start, end).toList());
}
