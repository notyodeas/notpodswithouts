
import '../constantes.dart';

class SubmittereInritaTransactio {
  String ex;
  String identitatis;
  SubmittereInritaTransactio.fromJson(Map<String, dynamic> map): 
  ex = map[JSON.ex],
  identitatis = map[JSON.identitatis];
}