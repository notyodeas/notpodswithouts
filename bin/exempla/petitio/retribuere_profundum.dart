import '../constantes.dart';

class RetribuereProfundum {
  String? ex;
  String? identitatis;

  Map<String, dynamic> toJson() => {JSON.ex: ex, JSON.identitatis: identitatis};

  RetribuereProfundum.fromJson(Map<String, dynamic> map)
      : ex = map[JSON.ex],
        identitatis = map[JSON.identitatis];
}
