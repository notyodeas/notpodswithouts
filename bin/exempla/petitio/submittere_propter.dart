
import '../constantes.dart';

class SubmitterePropter {
    String ex;
    List<String>? publicaClaves;
    SubmitterePropter.fromJson(Map<String, dynamic> map):
      ex = map[JSON.ex], 
      publicaClaves = map[JSON.publicaClaves].toString() == 'null' ? null : List<String>.from(map[JSON.publicaClaves] as List<dynamic>);
}