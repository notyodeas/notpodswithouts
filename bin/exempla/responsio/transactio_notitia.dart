import '../constantes.dart';

class TransactioNotitia {
  final bool includi;
  final List<String> priorTransactioIdentitatum;
  final int? indicatione;
  final List<int>? obstructionumNumerus;
  final BigInt? confirmationes;
  TransactioNotitia(this.includi, this.priorTransactioIdentitatum,
      this.indicatione, this.obstructionumNumerus, this.confirmationes);

  Map<String, dynamic> toJson() => {
        JSON.includi: includi,
        JSON.confirmationes: confirmationes.toString(),
        JSON.priorTransactioIdentitatum: priorTransactioIdentitatum,
        JSON.indicatione: indicatione,
        JSON.obstructionumNumerus: obstructionumNumerus,
      };
}
