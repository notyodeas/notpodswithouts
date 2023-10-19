import 'package:elliptic/elliptic.dart';

class ClavisPar {
  late String privatusClavis;
  late String publicaClavis;
  ClavisPar() {
    final ec = getP256();
    final key = ec.generatePrivateKey();
    privatusClavis = key.toHex();
    publicaClavis = key.publicKey.toHex();
  }
}
