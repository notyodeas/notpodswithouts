import '../constantes.dart';
import '../telum_exemplar.dart';
import 'gladiator_arma.dart';

class GladiatorSummaBid {
  TelumExemplar exemplar;
  String probationem;
  BigInt iubeo;
  GladiatorArma gladiatorArma;
  GladiatorSummaBid(
      this.exemplar, this.probationem, this.iubeo, this.gladiatorArma);
  Map<String, dynamic> toJson() => {
        JSON.exemplar: exemplar,
        JSON.probationem: probationem,
        JSON.iubeo: iubeo,
        JSON.gladiatorArma: gladiatorArma.toJson()
      };
}
