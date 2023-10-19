import '../constantes.dart';
import '../transactio.dart';

class SubmittereTransaction {
  String? ex;
  String? to;
  BigInt? pod;

  // SubmittereTransaction(this.from, this.to, this.gla, this.unit);
  SubmittereTransaction.fromJson(Map<String, dynamic> map) {
    ex = map[JSON.ex];
    to = map[JSON.to];
    pod = BigInt.parse(map[JSON.pod]);
  }
  Map<String, dynamic> toJson() => {
        JSON.ex: ex,
        JSON.to: to,
        JSON.pod: pod,
      };
}
