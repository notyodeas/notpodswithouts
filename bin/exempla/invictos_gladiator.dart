import 'constantes.dart';
import 'gladiator.dart';

class InvictosGladiator {
  String identitatis;
  GladiatorOutput output;
  bool primis;
  InvictosGladiator(this.identitatis, this.output, this.primis);

  Map<String, dynamic> toJson() => {
        JSON.identitatis: identitatis,
        JSON.output: output.toJson(),
        JSON.primis: primis
      };
}

// maby index should be bool