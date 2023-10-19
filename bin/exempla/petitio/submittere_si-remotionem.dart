import '../constantes.dart';

class SubmittereSiRemotionem {
  bool? liber;
  String? identitatis;

  SubmittereSiRemotionem.fromJson(Map<String, dynamic> map)
      : liber = bool.parse(map[JSON.liber].toString()),
        identitatis = map[JSON.identitatis];
}
