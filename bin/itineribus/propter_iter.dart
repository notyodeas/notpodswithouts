import 'dart:convert';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../exempla/constantes.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/clavis_par.dart';
import '../exempla/petitio/submittere_rationem.dart';
import '../exempla/responsio/propter_notitia.dart';
import '../exempla/utils.dart';
import 'dart:io';
import '../server.dart';

Future<Response> propterSubmittere(Request req) async {
  SubmittereRationem sr =
      SubmittereRationem.fromJson(json.decode(await req.readAsString()));
  Directory directorium =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  if (await Pera.isPublicaClavisDefended(sr.publicaClavis!, lo)) {
    return Response.badRequest(
        body: json.encode({
      "code": 0,
      "nuntius": "Publica clavis iam defendi",
      "message": "Public key  already defended"
    }));
  }
  for (Propter prop in par!.rationibus) {
    if (prop.interiorePropter.publicaClavis == sr.publicaClavis) {
      return Response.badRequest(
          body: json.encode({
        "code": 1,
        "nuntius": "publica clavem iam in piscinam",
        "english": "Public key is already in pool"
      }));
    }
  }
  ReceivePort acciperePortus = ReceivePort();
  InteriorePropter interioreRationem =
      InteriorePropter(sr.publicaClavis!, BigInt.zero);
  isolates.propterIsolates[interioreRationem.identitatis] = await Isolate.spawn(
      Propter.quaestum,
      List<dynamic>.from([interioreRationem, acciperePortus.sendPort]));
  acciperePortus.listen((propter) {
    print('listentriggeredrationem');
    par!.syncPropter(propter as Propter);
  });
  return Response.ok(
      json.encode({"propterIdentitatis": interioreRationem.identitatis}));
}

Future<Response> propterStatus(Request req) async {
  String propterIdentitatis = req.params['propter-identitatis']!;
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
  for (InterioreObstructionum interiore
      in obs.map((o) => o.interioreObstructionum)) {
    // List<GladiatorOutput> outputs = [];
    for (int i = 0;
        i < interiore.gladiator.interioreGladiator.outputs.length;
        i++) {
      for (Propter propter
          in interiore.gladiator.interioreGladiator.outputs[i].rationibus) {
        if (propter.interiorePropter.identitatis == propterIdentitatis) {
          bool primis = await Pera.isPrimis(propterIdentitatis, directory);
          PropterNotitia propterInfo = PropterNotitia(
              true,
              primis,
              interiore.indicatione,
              interiore.obstructionumNumerus,
              interiore.gladiator.interioreGladiator.outputs[i].defensio,
              interiore.gladiator.interioreGladiator.outputs[i].impetum);
          return Response.ok(json.encode({
            "data": propterInfo.toJson(),
            "scriptum": interiore.gladiator.toJson(),
            "gladiatorIdentitatis":
                interiore.gladiator.interioreGladiator.identitatis
          }));
        }
      }
    }
  }
  for (Propter propter in par!.rationibus) {
    if (propter.interiorePropter.identitatis == propterIdentitatis) {
      PropterNotitia propterInfo =
          PropterNotitia(false, null, null, null, null, null);
      return Response.ok(json.encode({
        "data": propterInfo.toJson(),
        "scriptum": propter.toJson(),
        "gladiatorIdentiatis": null
      }));
    }
  }
  return Response.badRequest(
      body: json.encode({"code": 0, "message": "Propter not found"}));
}

Future<Response> propterNovus(Request req) async {
  ClavisPar kp = ClavisPar();
  return Response.ok(json.encode({
    "publicaClavis": kp.publicaClavis,
    "privatusClavis": kp.privatusClavis
  }));
}

Future<Response> propterStagnum(Request req) async {
  return Response.ok(json.encode(par!.rationibus.map((e) => e.toJson())));
}
