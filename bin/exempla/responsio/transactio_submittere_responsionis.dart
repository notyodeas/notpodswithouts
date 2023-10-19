import '../constantes.dart';

class TransactioSubmittereResponsionis {
  bool liber;
  String identitatis;
  TransactioSubmittereResponsionis(this.liber, this.identitatis);

  Map<String, dynamic> toJson() =>
      {JSON.liber: liber, JSON.identitatis: identitatis};
}
