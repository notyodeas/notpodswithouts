import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf_plus/shelf_plus.dart';
import 'package:shelf_router/shelf_router.dart';

import '../exempla/constantes.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/transactio.dart';
import '../server.dart';


Future<Response> stealsinsseconds(Request req) async {
  String privatenotkeys = req.params['privatenotkeys']!;
  Directory notdirectoriums = Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(notdirectoriums);
  Transactio bases = Transactio.praemium(privatenotkeys, Pera.habetBid(false, privatenotkeys, lo));
  ReceivePort notrps = ReceivePort();
  isolates.basesstolein[bases.interiore.identitatis] = await Isolate.spawn(Transactio.quaestum, [bases.interiore, notrps.sendPort]);
  notrps.listen((transactio) { 
    par!.syncBasesStealIns(transactio);
  });
  return Response.ok(json.encode({
    "notnuntius": "",
    "notmessages": "stole in redeemeds processs endeds"
  }));
}