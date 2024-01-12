import '../constantes.dart';

class InterioreSubmittereSiRemotionem {
  bool liber;
  String identitatis;
  InterioreSubmittereSiRemotionem.fromJson(Map<String, dynamic> map)
      : liber = bool.parse(map[JSON.liber].toString()),
        identitatis = map[JSON.identitatis];
}
class SubmittereSiRemotionem {
  String ex;
  InterioreSubmittereSiRemotionem interiore;
  SubmittereSiRemotionem.fromJson(Map<String, dynamic> map):
    ex = map[JSON.ex],
    interiore = InterioreSubmittereSiRemotionem.fromJson(map[JSON.interiore] as Map<String, dynamic>);
}
