import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../exempla/pera.dart';
import '../server.dart';

Future<Response> statera(Request req) async {
  Directory directory =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  bool liber = bool.parse(req.params['liber']!);
  String publica = req.params['publica']!;
  BigInt statera = await Pera.statera(liber, publica, directory);
  return Response.ok(json.encode({"statera": statera.toString()}));
}
