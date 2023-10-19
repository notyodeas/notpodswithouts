import '../constantes.dart';

class IncipitPugna {
  bool? primis;
  String? gladiatorIdentitatis;
  String? privatusClavis;
  Map<String, dynamic> asMap() => {
        JSON.primis: primis,
        JSON.gladiatorIdentitatis: gladiatorIdentitatis,
        JSON.privatusClavis: privatusClavis
      };
  IncipitPugna.fromJson(Map<String, dynamic> map) {
    primis = bool.parse(map[JSON.primis].toString());
    gladiatorIdentitatis = map[JSON.gladiatorIdentitatis].toString();
    privatusClavis = map[JSON.privatusClavis].toString();
  }
}
