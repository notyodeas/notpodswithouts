import 'package:elliptic/elliptic.dart';
import 'constantes.dart';
import 'pera.dart';
import 'utils.dart';

class InterioreConnexaLiberExpressi {
  String identitatis;
  List<String> identitatum;
  // String identitatis;
  InterioreConnexaLiberExpressi(
      {required this.identitatis, required this.identitatum});
  Map<String, dynamic> toJson() => {
        JSON.identitatis: identitatis,
        JSON.identitatum: identitatum,
      };
  InterioreConnexaLiberExpressi.fromJson(Map<String, dynamic> map)
      : identitatis = map[JSON.identitatis],
        identitatum = List<String>.from(map[JSON.identitatum] as List<dynamic>);
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
