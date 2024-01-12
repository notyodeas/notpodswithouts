import 'constantes.dart';
import 'telum_exemplar.dart';

class Telum {
  final TelumExemplar exemplar;
  final List<String> telum;
  final String probationem;
  final BigInt bigas;
  final BigInt? vos;
  Telum({ required this.telum, required this.probationem, required this.exemplar, required this.bigas, this.vos });
  Map<String, dynamic> toJson() => {
        JSON.exemplar: exemplar.name.toString(),
        JSON.telum: telum,
        JSON.probationem: probationem,
        JSON.bigas: bigas.toString(),
        JSON.vos: vos?.toString()
      };
}
