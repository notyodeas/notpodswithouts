import '../constantes.dart';

class PropterNotitia {
  final bool includi;
  final bool? primis;
  final int? indicatione;
  final List<int>? obstructionumNumerus;
  final String? defensio;
  final String? impetum;
  PropterNotitia(this.includi, this.primis, this.indicatione,
      this.obstructionumNumerus, this.defensio, this.impetum);

  Map<String, dynamic> toJson() => {
        JSON.includi: includi,
        JSON.primis: primis,
        JSON.indicatione: indicatione,
        JSON.obstructionumNumerus: obstructionumNumerus,
        JSON.defensio: defensio,
        JSON.impetum: impetum
      };
}
