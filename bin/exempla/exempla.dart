// import 'dart:convert';
// import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
import './gladiator.dart';

class ObstructionumNumerus {
  List<int>? numerus;
  Map<String, dynamic> toJson() => {'numerus': numerus};
  ObstructionumNumerus.fromJson(Map<String, dynamic> map) {
    numerus = List<int>.from(map['numerus'] as List<dynamic>);
  }
}

class KeyPair {
  late String private;
  late String public;
  KeyPair() {
    final ec = getP256();
    final key = ec.generatePrivateKey();
    private = key.toHex();
    public = key.publicKey.toHex();
  }
}

class SubmittereRationem {
  String? publicaClavis;
  Map<String, dynamic> toJson() => {'publicaClavis': publicaClavis};
  SubmittereRationem.fromJson(Map<String, dynamic> map) {
    publicaClavis = map['publicaClavis'].toString();
  }
  // SubmittereRationem.fromJson(Map<String, dynamic> jsoschon):
  // publicaClavis = jsoschon['publicaClavis'].toString();

  // APISchemaObject documentSchema(APIDocumentContext context) {
  //   return APISchemaObject.object({"publicaClavis": APISchemaObject.string()});
  // }
}

class SubmittereTransaction {
  String? from;
  String? to;
  BigInt? app;

  Map<String, dynamic> asMap() => {
        'from': from,
        'to': to,
        'app': app,
      };
  // SubmittereTransaction(this.from, this.to, this.gla, this.unit);
  SubmittereTransaction.fromJson(Map<String, dynamic> map) {
    to = map['to'].toString();
    from = map['from'].toString();
    app = BigInt.from(num.parse(map['app'].toStringAsExponential() as String));
  }

  // APISchemaObject documentSchema(APIDocumentContext context) {
  //   return APISchemaObject.object({
  //     "to": APISchemaObject.string(),
  //     "from": APISchemaObject.string(),
  //     "app": APISchemaObject.number(),
  //   });
  // }
}

class RemoveTransaction {
  final bool liber;
  final String transactionId;
  final String publicaClavis;
  RemoveTransaction(this.liber, this.transactionId, this.publicaClavis);
  RemoveTransaction.fromJson(Map<String, dynamic> jsoschon)
      : liber = jsoschon['liber'] as bool,
        transactionId = jsoschon['transactionId'].toString(),
        publicaClavis = jsoschon['publicaClavis'].toString();
}

class Confussus {
  int? index;
  String? gladiatorId;
  String? privateKey;
  Map<String, dynamic> toJson() =>
      {'index': index, 'gladiatorId': gladiatorId, 'privateKey': privateKey};
  Confussus.fromJson(Map<String, dynamic> map) {
    index = int.parse(map['index'].toString());
    gladiatorId = map['gladiatorId'].toString();
    privateKey = map['privateKey'].toString();
  }

  // APISchemaObject documentSchema(APIDocumentContext context) {
  //   return APISchemaObject.object({
  //     "index": APISchemaObject.string(),
  //     "gladiatorId": APISchemaObject.string(),
  //     "privateKey": APISchemaObject.string()
  //   });
  // }
  // Confussus.fromJson(Map<String, dynamic> jsoschon):
  // index = int.parse(jsoschon['index'].toString()),
  // gladiatorId = jsoschon['gladiatorId'].toString(),
  // privateKey = jsoschon['privateKey'].toString();
}

// class FurcaConfussus extends Confussus {
//   List<int> numerus;
//   FurcaConfussus.fromJson(Map<String, dynamic> jsoschon):
//     numerus = List<int>.from(jsoschon['numerus'] as List<int>), super.fromJson(jsoschon);
// }
class TransactionInfo {
  final bool includi;
  final List<String> priorTxIds;
  final int? indicatione;
  final List<int>? obstructionumNumerus;
  final BigInt? confirmationes;
  TransactionInfo(this.includi, this.priorTxIds, this.indicatione,
      this.obstructionumNumerus, this.confirmationes);

  Map<String, dynamic> toJson() => {
        'includi': includi,
        'confirmationes': confirmationes.toString(),
        'priorTxIds': priorTxIds,
        'indicatione': indicatione,
        'obstructionumNumerus': obstructionumNumerus,
      };
}

class PropterInfo {
  final bool includi;
  final int index;
  final int? indicatione;
  final List<int>? obstructionumNumerus;
  final String? defensio;
  PropterInfo(this.includi, this.index, this.indicatione,
      this.obstructionumNumerus, this.defensio);

  Map<String, dynamic> toJson() => {
        'includi': includi,
        'index': index,
        'indicatione': indicatione,
        'obstructionumNumerus': obstructionumNumerus,
        'defensio': defensio,
      };
}

class Probationems {
  List<int>? firstIndex;
  List<int>? lastIndex;
  Probationems();

  Map<String, dynamic> toJson() =>
      {'firstIndex': firstIndex, 'lastIndex': lastIndex};
  void fromJson(Map<String, dynamic> map) {
    firstIndex = List<int>.from(map['firstIndex'] as List<dynamic>);
    lastIndex = List<int>.from(map['lastIndex'] as List<dynamic>);
  }
}

class InvictosGladiator {
  String id;
  GladiatorOutput output;
  int index;
  InvictosGladiator(this.id, this.output, this.index);

  Map<String, dynamic> toJson() =>
      {'id': id, 'output': output.toJson(), 'index': index};
}

class SubmittereScan {
  String? priorSignum;
  String? privatusIter;
  String? publicaSignum;

  SubmittereScan();

  Map<String, dynamic> asMap() => {
        'priorSignum': priorSignum,
        'privatusIter': privatusIter,
        'publicaSignum': publicaSignum
      };
  SubmittereScan.fromJson(Map<String, dynamic> map) {
    priorSignum = map['priorSignum'].toString();
    privatusIter = map['privatusIter'].toString();
    publicaSignum = map['publicaSignum'].toString();
  }
}

class HumanifyIn {
  String? dominus;
  String? quaestio;
  String? respondere;
  HumanifyIn();

  Map<String, dynamic> toJson() => {
        'dominus': dominus,
        'quaestio': quaestio,
        'respondere': respondere,
      };

  void readFromMap(Map<String, dynamic> map) {
    dominus = map['dominus'].toString();
    quaestio = map['quaestio'].toString();
    respondere = map['respondere'].toString();
  }
}
