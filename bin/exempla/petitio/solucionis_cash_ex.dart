
import '../constantes.dart';

class SolucionisCashEx {
  bool liber;
  String ex;
  SolucionisCashEx.fromJson(Map<String, dynamic> map): liber = map[JSON.liber], ex = map[JSON.ex];
}