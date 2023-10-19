import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/gladiator.dart';
import '../exempla/invictos_gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/obstructionum_arma.dart';
import '../exempla/pera.dart';
import 'package:tuple/tuple.dart';
import 'dart:io';
import '../exempla/responsio/gladiator_arma.dart';
import '../exempla/responsio/summa_bid_arma.dart';
import '../exempla/telum.dart';
import '../server.dart';

Future<Response> gladiatorInvictos(Request req) async {
  Directory directory =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  List<Tuple3<String, GladiatorOutput, bool>> gladiatores =
      await Obstructionum.invictosGladiatores(directory);
  final List<InvictosGladiator> invictos = [];
  for (Tuple3<String, GladiatorOutput, bool> gladiator in gladiatores) {
    invictos.add(
        InvictosGladiator(gladiator.item1, gladiator.item2, gladiator.item3));
  }
  return Response.ok(json.encode(invictos.map((e) => e.toJson()).toList()));
}

Future<Response> gladiatorDefenditur(Request req) async {
  String publica = req.params['publica-clavis']!;
  Directory directory =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
  if (await Pera.isPublicaClavisDefended(publica, lo)) {
    return Response.ok(json.encode({
      "defenditur": true,
      "nuntius": "publica clavis defenditur",
      "message": "the public key is protected"
    }));
  } else {
    return Response.ok(json.encode({
      "defenditur": false,
      "nuntius": "publica clavis non defenditur",
      "message": "the public key is not protected"
    }));
  }
}

Future<Response> gladiatorArma(Request req) async {
  try {
    final String propterIdentitatis = req.params['propter-identitatis']!;
    Directory directory =
        Directory('vincula/${argumentis!.obstructionumDirectorium}');
    List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
    final primis = await Pera.isPrimis(propterIdentitatis, directory);
    final gladiatorIdentitatis =
        await Pera.accipereGladiatorIdentitatis(propterIdentitatis, directory);
    final String basisDefensio = await Pera.turpiaGladiatoriaTelum(
        primis, false, gladiatorIdentitatis, lo);
    final basisImpetum =
        await Pera.turpiaGladiatoriaTelum(primis, true, propterIdentitatis, lo);
    final List<Telum> liberDefensiones =
        await Pera.maximeArma(true, primis, false, gladiatorIdentitatis, lo);
    final List<Telum> liberImpetus =
        await Pera.maximeArma(true, primis, true, gladiatorIdentitatis, lo);
    final List<Telum> fixumDefensiones =
        await Pera.maximeArma(false, primis, false, gladiatorIdentitatis, lo);
    final List<Telum> fixumImpetus =
        await Pera.maximeArma(false, primis, true, gladiatorIdentitatis, lo);
    GladiatorArma ga = GladiatorArma(
        basisDefensio: basisDefensio,
        basisImpetum: basisImpetum,
        defensionesLiber: liberDefensiones,
        defensionesFixum: fixumDefensiones,
        impetusLiber: liberImpetus,
        impetusFixum: fixumImpetus);
    return Response.ok(json.encode(ga.toJson()));
  } on BadRequest catch (e) {
    return Response.badRequest(body: json.encode(e.toJson()));
  }
}

Future<Response> gladiatorSummaBidArma(Request req) async {
  final String probationem = req.params['probationem']!;
  final Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  try {
    BigInt summaBid = await Pera.summaBid(probationem, lo);
    ObstructionumArma oa = await Pera.obstructionumArma(probationem, lo);
    return Response.ok(
        json.encode(SummaBidArma(probationem, summaBid, oa).toJson()));
  } on BadRequest catch (err) {
    return Response.badRequest(body: err.toJson());
  }
}
