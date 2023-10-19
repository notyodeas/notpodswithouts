import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:elliptic/elliptic.dart';
import 'package:hex/hex.dart';
import 'constantes.dart';
import 'pera.dart';
import 'utils.dart';

class InterioreConnexaLiberExpressi {
  String liberIdentitatis;
  String expressiIdentitatis;
  String identitatis;
  InterioreConnexaLiberExpressi(
      {required this.liberIdentitatis, required this.expressiIdentitatis})
      : identitatis = Utils.randomHex(64);
  Map<String, dynamic> toJson() => {
        JSON.liberIdentitatis: liberIdentitatis,
        JSON.expressiIdentitatis: expressiIdentitatis,
        JSON.identitatis: identitatis,
      };
  InterioreConnexaLiberExpressi.fromJson(Map<String, dynamic> map)
      : liberIdentitatis = map[JSON.liberIdentitatis],
        expressiIdentitatis = map[JSON.expressiIdentitatis],
        identitatis = map[JSON.identitatis];
}

class ConnexaLiberExpressi {
  String signature;
  String dominus;
  InterioreConnexaLiberExpressi interioreConnexaLiberExpressi;
  ConnexaLiberExpressi(
      this.dominus, this.interioreConnexaLiberExpressi, String privatus)
      : signature = Utils.signum(PrivateKey.fromHex(Pera.curve(), privatus),
            interioreConnexaLiberExpressi);
  ConnexaLiberExpressi.fromJson(Map<String, dynamic> map)
      : signature = map[JSON.signature],
        dominus = map[JSON.dominus],
        interioreConnexaLiberExpressi = InterioreConnexaLiberExpressi.fromJson(
            map[JSON.interioreConnexaLiberExpressi] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => {
        JSON.signature: signature,
        JSON.dominus: dominus,
        JSON.interioreConnexaLiberExpressi:
            interioreConnexaLiberExpressi.toJson()
      };
}
