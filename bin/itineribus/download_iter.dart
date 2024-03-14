
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../exempla/constantes.dart';
import '../exempla/obstructionum.dart';
import '../server.dart';
import 'package:shelf_plus/shelf_plus.dart';


Future<File> downloadchain(Request req) async {
  int i = int.parse(req.params['i']!);
  List<Obstructionum> lo = await Obstructionum.getBlocks(Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}'));
  return File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}$i.txt');
}