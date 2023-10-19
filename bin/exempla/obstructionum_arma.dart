import 'constantes.dart';

class ObstructionumArma {
  String defensio;
  String impetum;
  ObstructionumArma(this.defensio, this.impetum);
  Map<String, dynamic> toJson() =>
      {JSON.defensio: defensio, JSON.impetum: impetum};
  ObstructionumArma.fromJson(Map<String, dynamic> jsoschon)
      : defensio = jsoschon[JSON.defensio],
        impetum = jsoschon[JSON.impetum];
}
