import '../constantes.dart';

class Statera {
  BigInt liber;
  BigInt fixum;
  Statera({required this.liber, required this.fixum});
  Map<String, dynamic> toJson() =>
      {JSON.liber: liber.toString(), JSON.fixum: fixum.toString()};
}
