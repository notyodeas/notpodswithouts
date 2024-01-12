import '../constantes.dart';
import '../obstructionum_arma.dart';

class SummaBidArma {
  String probationem;
  BigInt summaBid;
  ObstructionumArma obstructionumArma;
  SummaBidArma(this.probationem, this.summaBid, this.obstructionumArma);
  Map<String, dynamic> toJson() => {
        JSON.probationem: probationem,
        JSON.summaBid: summaBid.toString(),
        JSON.obstructionumArma: obstructionumArma.toJson()
      };
}
