import '../constantes.dart';

class ProbationemJugum {
  List<int>? indexPrimis;
  List<int>? indexNovissime;
  ProbationemJugum.fromJson(Map<String, dynamic> map)
      : indexPrimis = map[JSON.indexPrimis],
        indexNovissime = map[JSON.indexNovissime];
}
