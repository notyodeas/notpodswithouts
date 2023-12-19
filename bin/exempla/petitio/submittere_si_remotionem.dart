import '../constantes.dart';

class InterioreSubmittereSiRemotionem {
  bool liber;
  String identitatis;
  InterioreSubmittereSiRemotionem.fromJson(Map<String, dynamic> map)
      : liber = bool.parse(map[JSON.liber].toString()),
        identitatis = map[JSON.identitatis];
}
class SubmittereSiRemotionem {
  String privatusClavis;
  InterioreSubmittereSiRemotionem interioreSubmittereSiRemotionem;
  SubmittereSiRemotionem.fromJson(Map<String, dynamic> map):
    privatusClavis = map[JSON.privatusClavis],
    interioreSubmittereSiRemotionem = InterioreSubmittereSiRemotionem.fromJson(map[JSON.interioreSubmittereSiRemotionem] as Map<String, dynamic>);
}
