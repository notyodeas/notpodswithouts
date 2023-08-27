import 'dart:convert';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../exempla/constantes.dart';
import '../exempla/exempla.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/utils.dart';
import 'dart:io';
// import '../connect/pervideas_to_pervideas.dart';
import '../server.dart';

Future<Response> submittere(Request req) async {
  SubmittereRationem sr =
      SubmittereRationem.fromJson(json.decode(await req.readAsString()));
  Directory dir = Directory('vincula/${argumentis!.obstructionumDirectorium}');
  if (await Pera.isPublicaClavisDefended(sr.publicaClavis!, dir)) {
    return Response.badRequest(body: {
      "code": 0,
      "nuntius": "Publica clavis iam defendi",
      "message": "Public key  already defended"
    });
  }
  for (Propter prop in ptp!.propters) {
    if (prop.interioreRationem.publicaClavis == sr.publicaClavis) {
      return Response.badRequest(
          body: json.encode({
        "code": 1,
        "nuntius": "publica clavem iam in piscinam",
        "english": "Public key is already in pool"
      }));
    }
  }
  ReceivePort acciperePortus = ReceivePort();
  InterioreRationem interioreRationem =
      InterioreRationem(sr.publicaClavis!, BigInt.zero);
  isolates.propterIsolates[interioreRationem.id] = await Isolate.spawn(
      Propter.quaestum,
      List<dynamic>.from([interioreRationem, acciperePortus.sendPort]));
  acciperePortus.listen((propter) {
    print('listentriggeredrationem');
    ptp!.syncPropter(propter as Propter);
  });
  return Response.ok(json.encode({"propterIdentitatis": interioreRationem.id}));
}

Future<Response> rationemIdentitatis(Request req) async {
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
  for (InterioreObstructionum interiore
      in obs.map((o) => o.interioreObstructionum)) {
    // List<GladiatorOutput> outputs = [];
    for (int i = 0; i < interiore.gladiator.outputs.length; i++) {
      for (Propter propter in interiore.gladiator.outputs[i].rationem) {
        if (propter.interioreRationem.id == identitatis) {
          PropterInfo propterInfo = PropterInfo(
              true,
              i,
              interiore.indicatione,
              interiore.obstructionumNumerus,
              interiore.gladiator.outputs[i].defensio);
          return Response.ok(json.encode({
            "data": propterInfo.toJson(),
            "scriptum": interiore.gladiator.toJson(),
            "gladiatorId": interiore.gladiator.id
          }));
        }
      }
    }
  }
  for (Propter propter in ptp!.propters) {
    if (propter.interioreRationem.id == identitatis) {
      PropterInfo propterInfo = PropterInfo(false, 0, null, null, null);
      return Response.ok(json.encode({
        "data": propterInfo.toJson(),
        "scriptum": propter.toJson(),
        "gladiatorId": null
      }));
    }
  }
  return Response.badRequest(
      body: json.encode({"code": 0, "message": "Propter not found"}));
}

Future<Response> novus(Request req) async {
  KeyPair kp = KeyPair();
  return Response.ok(
      json.encode({"publicaClavis": kp.public, "privatusClavis": kp.private}));
}
