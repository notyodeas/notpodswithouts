import '../constantes.dart';

class InimicusVelVictima {
  bool? primis;
  String? gladiatorIdentitatis;
  InimicusVelVictima.fromJson(Map<String, dynamic> map)
      : primis = bool.parse(map[JSON.primis].toString()),
        gladiatorIdentitatis = map[JSON.gladiatorIdentitatis];
}

class IncipitPugna {
  InimicusVelVictima? inimicus;
  InimicusVelVictima? victima;
  String? privatusClavis;
  IncipitPugna.fromJson(Map<String, dynamic> map)
      : inimicus = InimicusVelVictima.fromJson(
            map[JSON.inimicus] as Map<String, dynamic>),
        victima = InimicusVelVictima.fromJson(
            map[JSON.victima] as Map<String, dynamic>),
        privatusClavis = map[JSON.privatusClavis];
}
