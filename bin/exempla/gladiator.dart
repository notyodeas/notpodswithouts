import 'dart:io';

import './utils.dart';
import 'dart:convert';
import 'package:hex/hex.dart';
import 'package:crypto/crypto.dart';
import 'dart:isolate';
import './constantes.dart';
import 'errors.dart';
import 'obstructionum.dart';
import 'pera.dart';
import 'package:elliptic/elliptic.dart';

class InteriorePropter {
  final String publicaClavis;
  BigInt nonce;
  final String identitatis;
  InteriorePropter(this.publicaClavis, this.nonce)
      : identitatis = Utils.randomHex(64);
  InteriorePropter.incipio(this.publicaClavis)
      : nonce = BigInt.zero,
        identitatis = Utils.randomHex(64);
  mine() {
    nonce += BigInt.one;
  }

  Map<String, dynamic> toJson() => {
        JSON.publicaClavis: publicaClavis,
        JSON.nonce: nonce.toString(),
        JSON.identitatis: identitatis
      };
  InteriorePropter.fromJson(Map<String, dynamic> jsoschon)
      : publicaClavis = jsoschon[JSON.publicaClavis].toString(),
        nonce = BigInt.parse(jsoschon[JSON.nonce].toString()),
        identitatis = jsoschon[JSON.identitatis].toString();
}

class Propter {
  late String probationem;
  final InteriorePropter interiorePropter;
  Propter(this.probationem, this.interiorePropter);

  Propter.incipio(this.interiorePropter)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interiorePropter.toJson())))
            .bytes);
  static void quaestum(List<dynamic> argumentis) {
    InteriorePropter interiorePropter = argumentis[0] as InteriorePropter;
    SendPort mitte = argumentis[1] as SendPort;
    String probationem = '';
    int zeros = 1;
    while (true) {
      do {
        interiorePropter.mine();
        probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interiorePropter.toJson())))
            .bytes);
      } while (!probationem.startsWith('0' * zeros));
      zeros += 1;
      mitte.send(Propter(probationem, interiorePropter));
    }
  }

  Map<String, dynamic> toJson() => {
        JSON.probationem: probationem,
        JSON.interiorePropter: interiorePropter.toJson()
      };
  Propter.fromJson(Map<String, dynamic> jsoschon)
      : probationem = jsoschon[JSON.probationem].toString(),
        interiorePropter = InteriorePropter.fromJson(
            jsoschon[JSON.interiorePropter] as Map<String, dynamic>);
  bool isProbationem() {
    if (probationem ==
        HEX.encode(sha512
            .convert(utf8.encode(json.encode(interiorePropter.toJson())))
            .bytes)) {
      return true;
    }
    return false;
  }
}

class GladiatorInput {
  final bool primis;
  final String signature;
  final String gladiatorIdentitatis;
  GladiatorInput(this.primis, this.signature, this.gladiatorIdentitatis);
  Map<String, dynamic> toJson() => {
        JSON.primis: primis,
        JSON.signature: signature,
        JSON.gladiatorIdentitatis: gladiatorIdentitatis
      };
  GladiatorInput.fromJson(Map jsoschon)
      : primis = bool.parse(jsoschon[JSON.primis].toString()),
        signature = jsoschon[JSON.signature].toString(),
        gladiatorIdentitatis = jsoschon[JSON.gladiatorIdentitatis].toString();
}

class GladiatorOutput {
  final List<Propter> rationibus;
  final String defensio;
  final String impetum;
  GladiatorOutput(this.rationibus)
      : impetum = Utils.randomHex(1),
        defensio = Utils.randomHex(1);
  GladiatorOutput.incipio(String producentis)
      : rationibus = [
          Propter.incipio(InteriorePropter.incipio(producentis)),
        ],
        defensio = Utils.randomHex(1),
        impetum = Utils.randomHex(1);
  Map<String, dynamic> toJson() => {
        JSON.rationibus: rationibus.map((r) => r.toJson()).toList(),
        JSON.defensio: defensio,
        JSON.impetum: impetum
      };
  GladiatorOutput.fromJson(Map<String, dynamic> jsoschon)
      : rationibus = List<Propter>.from(jsoschon[JSON.rationibus]
                .map((r) => Propter.fromJson(r as Map<String, dynamic>))
            as Iterable<dynamic>),
        defensio = jsoschon[JSON.defensio].toString(),
        impetum = jsoschon[JSON.impetum].toString();
}

class InterioreGladiator {
  GladiatorInput? input;
  final List<GladiatorOutput> outputs;
  final String identitatis;
  InterioreGladiator({required this.input, required this.outputs})
      : identitatis = Utils.randomHex(64);
  InterioreGladiator.efectus({required this.outputs})
      : input = null,
        identitatis = Utils.randomHex(64);
  InterioreGladiator.ce({required this.input})
      : outputs = [],
        identitatis = Utils.randomHex(64);
  InterioreGladiator.incipio(String producentis)
      : outputs = [GladiatorOutput.incipio(producentis)],
        identitatis = Utils.randomHex(64);
  static List<GladiatorOutput> egos(List<Propter> propters) {
    return [
      GladiatorOutput(propters.take((propters.length / 2).round()).toList()),
      GladiatorOutput(propters.skip((propters.length / 2).round()).toList())
    ];
  }

  static Future<GladiatorInput> cegi(bool primis, String privatusClavis,
      String gladiatorIdentitatis, List<Obstructionum> lo) async {
    Gladiator? g = await Obstructionum.grabGladiator(gladiatorIdentitatis, lo);
    if (g == null) {
      throw BadRequest(
          code: 1,
          nuntius: 'Gladiator iam victus aut non inveni',
          message: 'Gladiator already defeaten or not found');
    }
    return GladiatorInput(
        primis,
        Utils.signum(PrivateKey.fromHex(Pera.curve(), privatusClavis),
            g.interioreGladiator.outputs[primis ? 0 : 1]),
        gladiatorIdentitatis);
  }

  Map<String, dynamic> toJson() => {
        JSON.input: input?.toJson(),
        JSON.outputs: outputs.map((o) => o.toJson()).toList(),
        JSON.identitatis: identitatis
      }..removeWhere((key, value) => value == null);
  InterioreGladiator.fromJson(Map<String, dynamic> jsoschon)
      : input = jsoschon[JSON.input] != null
            ? GladiatorInput.fromJson(jsoschon[JSON.input] as Map)
            : null,
        outputs = List<GladiatorOutput>.from(jsoschon[JSON.outputs]
                .map((o) => GladiatorOutput.fromJson(o as Map<String, dynamic>))
            as Iterable<dynamic>),
        identitatis = jsoschon[JSON.identitatis].toString();

  static List<Propter> grab(List<Propter> propters) {
    List<Propter> reditus = [];
    for (int i = 64; i > 0; i--) {
      if (propters.any((p) => p.probationem.startsWith('0' * i))) {
        if (reditus.length < Constantes.perRationesObstructionum) {
          reditus.addAll(propters.where((p) =>
              p.probationem.startsWith('0' * i) && !reditus.contains(p)));
        } else {
          break;
        }
      }
    }
    return reditus;
  }
}

class Gladiator {
  String probationem;
  InterioreGladiator interioreGladiator;
  Gladiator(this.probationem, this.interioreGladiator);
  Gladiator.nullam(this.interioreGladiator)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreGladiator.toJson())))
            .bytes);
  Map<String, dynamic> toJson() => {
        JSON.probationem: probationem,
        JSON.interioreGladiator: interioreGladiator.toJson()
      };
  Gladiator.fromJson(Map<String, dynamic> jsoschon)
      : probationem = jsoschon[JSON.probationem],
        interioreGladiator = InterioreGladiator.fromJson(
            jsoschon[JSON.interioreGladiator] as Map<String, dynamic>);
}
