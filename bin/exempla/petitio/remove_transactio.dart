import '../constantes.dart';

class RemoveTransaction {
  final bool liber;
  final String transactionIdentitatis;
  final String publicaClavis;
  RemoveTransaction(
      this.liber, this.transactionIdentitatis, this.publicaClavis);
  RemoveTransaction.fromJson(Map<String, dynamic> jsoschon)
      : liber = jsoschon[JSON.liber] as bool,
        transactionIdentitatis =
            jsoschon[JSON.transactioIdentitatis].toString(),
        publicaClavis = jsoschon[JSON.publicaClavis].toString();
}
