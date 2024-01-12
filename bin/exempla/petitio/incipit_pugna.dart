import '../constantes.dart';

class Victima {
  bool primis;
  String identitatis;
  Victima.fromJson(Map<String, dynamic> map)
      : primis = bool.parse(map[JSON.primis].toString()),
        identitatis = map[JSON.identitatis];
}

class IncipitPugna {
  String ex;
  Victima victima;
  IncipitPugna.fromJson(Map<String, dynamic> map)
      : ex = map[JSON.ex],
        victima = Victima.fromJson(
            map[JSON.victima] as Map<String, dynamic>);
}
