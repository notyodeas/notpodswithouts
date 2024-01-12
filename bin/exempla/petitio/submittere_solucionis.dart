
import '../constantes.dart';
import '../solucionis_propter.dart';

class SubmittereSolucionisPropter {
  String solucionis;
  String accipientis; 
  SubmittereSolucionisPropter.fromJson(Map<String, dynamic> map): solucionis = map[JSON.solucionis], accipientis = map[JSON.accipientis];
}
class SubmittereFissileSolucionisPropter {
  String solucionis;
  String reliquiae;
  List<Fixus> fixs;
  SubmittereFissileSolucionisPropter.fromJson(Map<String, dynamic> map): 
    solucionis = map[JSON.solucionis],
    reliquiae = map[JSON.reliquiae],
    fixs = List<Fixus>.from((map[JSON.fixs] as List<dynamic>).map((mf) => Fixus.fromJson(mf as Map<String, dynamic>)));
}