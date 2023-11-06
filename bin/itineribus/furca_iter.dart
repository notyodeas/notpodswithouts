import 'dart:convert';

import 'package:shelf/shelf.dart';
import '../server.dart';

Future<Response> furcaForamen(Request req) async {
  return Response.ok(
      json.encode(par!.foramenFurca.map((mff) => mff.toJson()).toList()));
}

Future<Response> furcaTridentes(Request req) async {
  return Response.ok(
      json.encode(par!.tridentes.map((mt) => mt.toJson()).toList()));
}
