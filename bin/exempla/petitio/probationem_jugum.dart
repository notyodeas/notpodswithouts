import '../constantes.dart';

class ProbationemJugum {
  List<int> primis;
  List<int> novissime;
  ProbationemJugum.fromJson(Map<String, dynamic> map)
      : primis = map[JSON.primis],
        novissime = map[JSON.indexNovissime];
}