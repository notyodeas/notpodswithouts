import 'constantes.dart';

class ObstructionumArma {
  List<String> defensio;
  List<String> impetus;
  ObstructionumArma(this.defensio, this.impetus);
  Map<String, dynamic> toJson() =>
      {JSON.defensio: defensio, JSON.impetus: impetus};
  ObstructionumArma.fromJson(Map<String, dynamic> jsoschon)
      : defensio = List<String>.from(jsoschon[JSON.defensio]),
        impetus = List<String>.from(jsoschon[JSON.impetus]);
}
