import 'constantes.dart';
import 'telum_exemplar.dart';

class Telum {
  final TelumExemplar exemplar;
  final String telum;
  final String probationem;
  final BigInt persoluta;
  Telum(this.telum, this.probationem, this.exemplar, this.persoluta);
  Map<String, dynamic> toJson() => {
        JSON.exemplar: exemplar.name.toString(),
        JSON.telum: telum,
        JSON.probationem: probationem,
        JSON.persoluta: persoluta.toString()
      };
}
