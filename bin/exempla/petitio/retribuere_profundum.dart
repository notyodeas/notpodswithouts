import '../constantes.dart';

class RetribuereProfundum {
  String ex;
  String signature;
  Map<String, dynamic> toJson() => {JSON.ex: ex, JSON.signature: signature };
  RetribuereProfundum.fromJson(Map<String, dynamic> map)
      : ex = map[JSON.ex],
        signature = map[JSON.signature];
}
