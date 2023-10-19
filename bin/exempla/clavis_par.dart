import 'package:elliptic/elliptic.dart';

class KeyPair {
  late String privatusClavis;
  late String publicaClavis;
  KeyPair() {
    final ec = getP256();
    final key = ec.generatePrivateKey();
    privatusClavis = key.toHex();
    publicaClavis = key.publicKey.toHex();
  }
}
