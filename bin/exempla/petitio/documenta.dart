import '../constantes.dart';

class Documenta {
  List<int>? primisIndex;
  List<int>? postremoIndex;
  Documenta();

  Map<String, dynamic> asMap() =>
      {JSON.primisIndex: primisIndex, JSON.postremoIndex: postremoIndex};
  Documenta.fromJson(Map<String, dynamic> map) {
    primisIndex = List<int>.from(JSON.primisIndex as List<dynamic>);
    postremoIndex = List<int>.from(JSON.postremoIndex as List<dynamic>);
  }
}
