import 'dart:math';
import 'dart:io';
import 'package:hex/hex.dart';
import 'dart:convert';
import './gladiator.dart';
import 'package:elliptic/elliptic.dart';
import './transactio.dart';
import 'package:ecdsa/ecdsa.dart';
import './constantes.dart';
import './obstructionum.dart';
import './errors.dart';
import 'connexa_liber_expressi.dart';

class Utils {
  static final Random _random = Random.secure();

  static String randomHex(int length) {
    var values = List<int>.generate(length, (index) => _random.nextInt(256));
    return HEX.encode(values);
  }

  static Stream<String> fileAmnis(File file) =>
      file.openRead().transform(utf8.decoder).transform(LineSplitter());

  static String signum(PrivateKey privateKey, dynamic output) =>
      signature(privateKey, utf8.encode(json.encode(output.toJson())))
          .toASN1Hex();

  static bool cognoscereVictusGladiator(PublicKey publicaClavis,
          Signature signature, GladiatorOutput gladiatorOutput) =>
      verify(publicaClavis, utf8.encode(json.encode(gladiatorOutput.toJson())),
          signature);
  static bool cognoscere(PublicKey publicaClavis, Signature signature,
          TransactioOutput txOutput) =>
      verify(publicaClavis, utf8.encode(json.encode(txOutput.toJson())),
          signature);

  static bool cognoscereConnexaLiberExpressi(PublicKey publicaClavis,
          Signature signature, InterioreConnexaLiberExpressi icle) =>
      verify(publicaClavis, utf8.encode(json.encode(icle.toJson())), signature);
  static bool cognoscereTransform(
          PublicKey publicaClavis, Signature signature, TransactioInput ti) =>
      verify(publicaClavis, utf8.encode(json.encode(ti.toJson())), signature);

  static bool cognoscereSiRemotionem(PublicKey publicaClavis,
          Signature signature, SiRemotionemOutput sro) =>
      verify(publicaClavis, utf8.encode(json.encode(sro.toJson())), signature);
}
