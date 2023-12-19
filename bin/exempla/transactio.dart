import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:isolate';
import 'package:hex/hex.dart';
import 'package:tuple/tuple.dart';
import '../auxiliatores/print.dart';
import '../server.dart';
import './utils.dart';
import './obstructionum.dart';
import 'package:elliptic/elliptic.dart';
import 'package:ecdsa/ecdsa.dart';
import './pera.dart';
import './constantes.dart';
import 'package:collection/collection.dart';

import 'solucionis_propter.dart';


enum TransactioSignificatio {
  regularis,
  ardeat,
  transform,
  praemium,
  expressi,
  refugium,
  perdita,
  solucionis
}

extension TransactioSignificatioFromJson on TransactioSignificatio {
  static fromJson(String name) {
    switch (name) {
      case 'regularis':
        return TransactioSignificatio.regularis;
      case 'ardeat':
        return TransactioSignificatio.ardeat;
      case 'transform':
        return TransactioSignificatio.transform;
      case 'praemium':
        return TransactioSignificatio.praemium;
      case 'expressi':
        return TransactioSignificatio.expressi;
      case 'refugium':
        return TransactioSignificatio.refugium;
      case 'perdita': return TransactioSignificatio.perdita;
      case 'solucionis': return TransactioSignificatio.solucionis;
    }
  }
}

enum TransactioGenus { liber, fixum, expressi }

extension TransactioGenusFromJson on TransactioGenus {
  static fromJson(String name) {
    switch (name) {
      case 'liber': return TransactioGenus.liber;
      case 'fixum': return TransactioGenus.fixum;
      case 'expressi': return TransactioGenus.expressi;
      // case 'profundum': return TransactioGenus.profundum;
    }
  }
}

class TransactioInput {
  final int index;
  final String signature;
  final String transactioIdentitatis;
  TransactioInput(this.index, this.signature, this.transactioIdentitatis);
  Map<String, dynamic> toJson() => {
        JSON.index: index,
        JSON.signature: signature,
        JSON.transactioIdentitatis: transactioIdentitatis
      };
  TransactioInput.fromJson(Map<String, dynamic> jsoschon)
      : index = int.parse(jsoschon[JSON.index].toString()),
        signature = jsoschon[JSON.signature].toString(),
        transactioIdentitatis = jsoschon[JSON.transactioIdentitatis].toString();
}

class TransactioOutput {
  final String publicaClavis;
  final BigInt pod;
  TransactioOutput(this.publicaClavis, this.pod);
  TransactioOutput.praemium(this.publicaClavis)
      : pod = Constantes.obstructionumPraemium;

  Map<String, dynamic> toJson() => {
        JSON.publicaClavis: publicaClavis,
        JSON.pod: pod.toString(),
      }..removeWhere((key, value) => value == null);
  TransactioOutput.fromJson(Map<String, dynamic> jsoschon)
      : publicaClavis = jsoschon[JSON.publicaClavis].toString(),
        pod = BigInt.parse(jsoschon[JSON.pod].toString());
}

class SiRemotionemInput {
  String signatureInput;
  String siRemotionemIdentiatis;
  String transactioIdentitatis;
  InterioreTransactio? interioreTransactio;
  SiRemotionemInput(this.signatureInput, this.siRemotionemIdentiatis,
      this.interioreTransactio): transactioIdentitatis = interioreTransactio!.interioreInterioreTransactio.identitatis;
  Map<String, dynamic> toJson() => {
        JSON.signatureInput: signatureInput,
        JSON.siRemotionemIdentitatis: siRemotionemIdentiatis,
        JSON.transactioIdentitatis: transactioIdentitatis,
        JSON.interioreTransactio: interioreTransactio?.toJson(),
      };
  SiRemotionemInput.fromJson(Map<String, dynamic> map)
      : signatureInput = map[JSON.signatureInput],
        siRemotionemIdentiatis = map[JSON.siRemotionemIdentitatis],
        transactioIdentitatis = map[JSON.transactioIdentitatis],
        interioreTransactio = map[JSON.interioreTransactio] != null ? InterioreTransactio.fromJson(
            map[JSON.interioreTransactio] as Map<String, dynamic>) : null;
  bool cognoscere(List<Obstructionum> lo) {
    SiRemotionem sr = SiRemotionem.exInitus(siRemotionemIdentiatis, lo);
    return Utils.cognoscereInterioreSiRemotionem(PublicKey.fromHex(Pera.curve(), sr.interioreSiRemotionem.siRemotionemOutput!.debetur), Signature.fromASN1Hex(signatureInput), sr.interioreSiRemotionem);
  }
  bool solvit(Obstructionum o, List<Obstructionum> lo) {
    SiRemotionem sr = SiRemotionem.exInitus(siRemotionemIdentiatis, lo);
    Transactio t = sr.interioreSiRemotionem.siRemotionemOutput!.liber ? o.interioreObstructionum.liberTransactions.singleWhere((swlt) => swlt.interioreTransactio.identitatis == transactioIdentitatis) : o.interioreObstructionum.fixumTransactions.singleWhere((swft) => swft.interioreTransactio.identitatis == transactioIdentitatis);
    List<TransactioOutput> lto = [];
    for (TransactioInput ti in t.interioreTransactio.interioreInterioreTransactio.inputs) {
      List<Transactio> lt = [];
      lo.where((wo) => sr.interioreSiRemotionem.siRemotionemOutput!.liber ? wo.interioreObstructionum.liberTransactions.any((alt) => alt.interioreTransactio.identitatis == ti.transactioIdentitatis) : wo.interioreObstructionum.fixumTransactions.any((aft) => aft.interioreTransactio.identitatis == ti.transactioIdentitatis)).map((mo) => sr.interioreSiRemotionem.siRemotionemOutput!.liber ? mo.interioreObstructionum.liberTransactions : mo.interioreObstructionum.fixumTransactions).forEach(lt.addAll);
      for (Transactio ft in lt) {
        lto.add(ft.interioreTransactio.interioreInterioreTransactio.outputs[ti.index]);
      }
    }
    if (!lto.every((eto) => eto.publicaClavis == sr.interioreSiRemotionem.siRemotionemOutput!.debetur)) {
      Print.nota(nuntius: 'profundum negotium non solvit verbo clavis publici', message: 'depth transaction is not payed with the owed public key');
      return false;
    }
    if (!t.interioreTransactio.outputs.any((ao) => ao.publicaClavis == sr.interioreSiRemotionem.siRemotionemOutput!.habereIus)) {
      Print.nota(nuntius: 'profundum non solvit propriis clavis publici', message: 'depth is not payed to the proper public key');
      return false;
    }
    BigInt pretiumRetro = BigInt.zero;
    for (TransactioOutput to in t.interioreTransactio.outputs.where((wo) => wo.publicaClavis == sr.interioreSiRemotionem.siRemotionemOutput!.habereIus)) {
      pretiumRetro += to.pod;
    }
    if (pretiumRetro != sr.interioreSiRemotionem.siRemotionemOutput!.pod) {
      Print.nota(nuntius: 'nullum conatus vasculum reddere', message: 'invalid attempt of pod to pay back');
      return false;
    }
    return true;
  }
  bool solvitStagnum(InterioreTransactio it, List<Obstructionum> lo) {
    SiRemotionem sr = SiRemotionem.exInitus(siRemotionemIdentiatis, lo);
    List<TransactioOutput> lto = [];
    for (TransactioInput ti in  it.inputs) {
      List<Transactio> lt = [];
      lo.where((wo) => sr.interioreSiRemotionem.siRemotionemOutput!.liber ? wo.interioreObstructionum.liberTransactions.any((alt) => alt.interioreTransactio.identitatis == ti.transactioIdentitatis) : wo.interioreObstructionum.fixumTransactions.any((aft) => aft.interioreTransactio.identitatis == ti.transactioIdentitatis)).map((mo) => sr.interioreSiRemotionem.siRemotionemOutput!.liber ? mo.interioreObstructionum.liberTransactions : mo.interioreObstructionum.fixumTransactions).forEach(lt.addAll);
      for (Transactio ft in lt) {
        lto.add(ft.interioreTransactio.outputs[ti.index]);
      }
    }
    if (!lto.every((eto) => eto.publicaClavis == sr.interioreSiRemotionem.siRemotionemOutput!.debetur)) {
      Print.nota(nuntius: 'profundum negotium non solvit verbo clavis publici', message: 'depth transaction is not payed with the owed public key');
      return false;
    }
    if (!it.outputs.any((ao) => ao.publicaClavis == sr.interioreSiRemotionem.siRemotionemOutput!.habereIus)) {
      Print.nota(nuntius: 'profundum non solvit propriis clavis publici', message: 'depth is not payed to the proper public key');
      return false;
    }
    BigInt pretiumRetro = BigInt.zero;
    for (TransactioOutput to in it.outputs.where((wo) => wo.publicaClavis == sr.interioreSiRemotionem.siRemotionemOutput!.habereIus)) {
      pretiumRetro += to.pod;
    }
    if (pretiumRetro != sr.interioreSiRemotionem.siRemotionemOutput!.pod) {
      Print.nota(nuntius: 'nullum conatus vasculum reddere', message: 'invalid attempt of pod to pay back');
      return false;
    }
    return true;
  }
}

class SiRemotionemOutput {
  bool liber;
  String habereIus;
  String debetur;
  String transactioIdentitatis;
  BigInt pod;
  SiRemotionemOutput(this.liber, this.habereIus, this.debetur,
      this.transactioIdentitatis, this.pod);

  SiRemotionemOutput.fromJson(Map<String, dynamic> map)
      : liber = bool.parse(map[JSON.liber].toString()),
        habereIus = map[JSON.habereIus],
        debetur = map[JSON.debetur],
        transactioIdentitatis = map[JSON.transactioIdentitatis],
        pod = BigInt.parse(map[JSON.pod].toString());

  Map<String, dynamic> toJson() => {
        JSON.liber: liber,
        JSON.habereIus: habereIus,
        JSON.debetur: debetur,
        JSON.transactioIdentitatis: transactioIdentitatis,
        JSON.pod: pod.toString()
      };
}

class InterioreSiRemotionem {
  SiRemotionemOutput? siRemotionemOutput;
  SiRemotionemInput? siRemotionemInput;
  String identitatisInterioreSiRemotionem;
  String? signatureInterioreSiRemotionem;
  BigInt nonce;
  mine() {
    nonce += BigInt.one;
  }

  InterioreSiRemotionem.output(String ex, this.siRemotionemOutput)
      : identitatisInterioreSiRemotionem = Utils.randomHex(64),
        nonce = BigInt.zero,
        signatureInterioreSiRemotionem = Utils.signum(
            PrivateKey.fromHex(Pera.curve(), ex), siRemotionemOutput);

  InterioreSiRemotionem.input(this.siRemotionemInput)
      : identitatisInterioreSiRemotionem = Utils.randomHex(64),
        nonce = BigInt.zero;

  InterioreSiRemotionem.fromJson(Map<String, dynamic> map)
      : siRemotionemInput = map[JSON.siRemotionemInput] != null
            ? SiRemotionemInput.fromJson(
                map[JSON.siRemotionemInput] as Map<String, dynamic>)
            : null,
        siRemotionemOutput = map[JSON.siRemotionemOutput] != null
            ? SiRemotionemOutput.fromJson(
                map[JSON.siRemotionemOutput] as Map<String, dynamic>)
            : null,
        identitatisInterioreSiRemotionem =
            map[JSON.identitatisInterioreSiRemotionem],
        nonce = BigInt.parse(map[JSON.nonce].toString()),
        signatureInterioreSiRemotionem =
            map[JSON.signatureInterioreSiRemotionem];
  Map<String, dynamic> toJson() => {
        JSON.siRemotionemInput: siRemotionemInput?.toJson(),
        JSON.siRemotionemOutput: siRemotionemOutput?.toJson(),
        JSON.identitatisInterioreSiRemotionem: identitatisInterioreSiRemotionem,
        JSON.signatureInterioreSiRemotionem: signatureInterioreSiRemotionem,
        JSON.nonce: nonce.toString()
      };

  bool cognoscereOutput() {
    return Utils.cognoscereSiRemotionemOutput(
        PublicKey.fromHex(Pera.curve(), siRemotionemOutput!.debetur),
        Signature.fromASN1Hex(signatureInterioreSiRemotionem!),
        siRemotionemOutput!);
  }
}

class SiRemotionem {
  String probationem;
  InterioreSiRemotionem interioreSiRemotionem;
  SiRemotionem(this.probationem, this.interioreSiRemotionem);
  SiRemotionem.summitto(this.interioreSiRemotionem)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreSiRemotionem.toJson())))
            .bytes);

  SiRemotionem.fromJson(Map<String, dynamic> map)
      : probationem = map[JSON.probationem],
        interioreSiRemotionem = InterioreSiRemotionem.fromJson(
            map[JSON.interioreSiRemotionem] as Map<String, dynamic>);
  Map<String, dynamic> toJson() => {
        JSON.probationem: probationem,
        JSON.interioreSiRemotionem: interioreSiRemotionem.toJson(),
      };

  bool validateProbationem() {
    if (probationem !=
        HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreSiRemotionem.toJson())))
            .bytes)) {
      return false;
    }
    return true;
  }

  Future<bool> remotumEst() async {
    Directory directorium = Directory(
        '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}');
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    List<Transactio> ltlt = [];
    lo
        .map((mo) => mo.interioreObstructionum.liberTransactions)
        .forEach(ltlt.addAll);
    if (!ltlt.any((alt) =>
        alt.interioreTransactio.identitatis ==
        interioreSiRemotionem.siRemotionemOutput?.transactioIdentitatis)) {
      print('f');
      return false;
    }
    List<Transactio> ltft = [];
    lo
        .map((mo) => mo.interioreObstructionum.fixumTransactions)
        .forEach(ltft.addAll);
    if (ltft.any((alt) =>
        alt.interioreTransactio.identitatis ==
        interioreSiRemotionem.siRemotionemOutput?.transactioIdentitatis)) {
      print('ff');
      return false;
    }
    List<SiRemotionem> lsr = [];
    lo.map((mo) => mo.interioreObstructionum.siRemotiones).forEach(lsr.addAll);
    if (lsr.any((asr) =>
        asr.interioreSiRemotionem.identitatisInterioreSiRemotionem ==
        interioreSiRemotionem.identitatisInterioreSiRemotionem)) {
      print('fff');
      return false;
    }
    return true;
  }

  Future<bool> nonHabetInitus() async {
    Directory directorium = Directory(
        '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}');
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    List<SiRemotionem> lsr = [];
    lo
        .map((mo) => mo.interioreObstructionum.siRemotiones.where(
            (wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null))
        .forEach(lsr.addAll);
    List<SiRemotionemInput> lsri =
        lsr.map((msr) => msr.interioreSiRemotionem.siRemotionemInput!).toList();

    List<String> inputIdentitatum = [];
    lsri.map((sri) => sri.siRemotionemIdentiatis).forEach(inputIdentitatum.add);
    return !inputIdentitatum
        .contains(interioreSiRemotionem.identitatisInterioreSiRemotionem);
  }

  Future<bool> valetInitus() async {
    if (interioreSiRemotionem.siRemotionemInput == null) {
      return true;
    }
    return false;
  }
  static bool habetProfundum(bool liber, String publica, List<Obstructionum> lo) {
    List<SiRemotionem> lsr = [];
    lo.map((mo) => mo.interioreObstructionum.siRemotiones.where((wsr) => wsr.interioreSiRemotionem.siRemotionemOutput != null && wsr.interioreSiRemotionem.siRemotionemOutput?.liber == liber)).forEach(lsr.addAll);
    return lsr.any((asr) => asr.interioreSiRemotionem.siRemotionemOutput!.debetur == publica);
  }
  static SiRemotionem exInitus(String identitatis, List<Obstructionum> lo) {
    List<SiRemotionem> lsr = [];
    lo.map((mo) => mo.interioreObstructionum.siRemotiones).forEach(lsr.addAll);
    return lsr.singleWhere((wsr) => wsr.interioreSiRemotionem.identitatisInterioreSiRemotionem == identitatis && wsr.interioreSiRemotionem.siRemotionemOutput != null);
  }

  static void quaestum(List<dynamic> argumentis) {
    InterioreSiRemotionem interiore = argumentis[0] as InterioreSiRemotionem;
    SendPort mitte = argumentis[1] as SendPort;
    String probationem = '';
    int zeros = 1;
    while (true) {
      do {
        interiore.mine();
        probationem = HEX.encode(
            sha512.convert(utf8.encode(json.encode(interiore.toJson()))).bytes);
      } while (!probationem.startsWith('0' * zeros));
      zeros += 1;
      mitte.send(SiRemotionem(probationem, interiore));
    }
  }

  static List<SiRemotionem> grab(Iterable<SiRemotionem> isr) {
    List<SiRemotionem> reditus = [];
    for (int i = 128; i > 0; i--) {
      if (isr.any((aisr) => aisr.probationem.startsWith('0' * i))) {
        if (reditus.length < Constantes.txCaudice) {
          reditus.addAll(isr.where((wsr) =>
              wsr.probationem.startsWith('0' * i) && !reditus.contains(wsr)));
        } else {
          break;
        }
      }
    }
    return reditus;
  }
  // but we dont have inputs yet so these depths could be payed
  static Future<List<SiRemotionemOutput>> profundums(String publicaClavis, Directory directorium) async {
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    List<SiRemotionem> lsr = [];
    lo.map((mo) => mo.interioreObstructionum.siRemotiones).forEach(lsr.addAll);
    List<SiRemotionemOutput> lsro = [];
    lsr.where((wsr) => wsr.interioreSiRemotionem.siRemotionemOutput != null).where((wsr) => wsr.interioreSiRemotionem.siRemotionemOutput!.debetur == publicaClavis).map((msr) => msr.interioreSiRemotionem.siRemotionemOutput!).forEach(lsro.add);
    return lsro;
  }
}

class InterioreInterioreTransactio {
  final bool liber;
  final TransactioSignificatio transactioSignificatio;
  SiRemotionem? siRemotionem;
  final List<TransactioInput> inputs;
  final List<TransactioOutput> outputs;
  final String identitatis;
  final String dominus;
  InterioreInterioreTransactio(
      {required String ex,
      required this.liber,
      required this.identitatis,
      required this.dominus,
      required this.transactioSignificatio,
      required this.inputs,
      required this.outputs,
      SiRemotionem? sr})
      : siRemotionem = sr;

  InterioreInterioreTransactio.praemium(String producentis)
      : liber = true,
        transactioSignificatio = TransactioSignificatio.praemium,
        siRemotionem = null,
        inputs = [],
        outputs = [TransactioOutput.praemium(producentis)],
        identitatis = Utils.randomHex(64),
        dominus = producentis;

  InterioreInterioreTransactio.transform({
    required bool liber,
    required this.dominus,
    required this.inputs,
    required this.outputs,
  })  : liber = liber,
        transactioSignificatio = TransactioSignificatio.transform,
        siRemotionem = null,
        identitatis = Utils.randomHex(64);


  Map<String, dynamic> toJson() => {
        JSON.liber: liber,
        JSON.probatur: probatur,
        JSON.transactioSignificatio: transactioSignificatio.name.toString(),
        JSON.inputs: inputs.map((i) => i.toJson()).toList(),
        JSON.outputs: outputs.map((o) => o.toJson()).toList(),
        JSON.identitatis: identitatis,
        JSON.dominus: dominus,
        JSON.nonce: nonce.toString(),
        JSON.siRemotionem: siRemotionem?.toJson()
      }..removeWhere((key, value) => value == null);
  InterioreInterioreTransactio.fromJson(Map<String, dynamic> jsoschon)
      : liber = jsoschon[JSON.liber],
        probatur = jsoschon[JSON.probatur],
        transactioSignificatio = TransactioSignificatioFromJson.fromJson(
                jsoschon[JSON.transactioSignificatio].toString())
            as TransactioSignificatio,
        siRemotionem = jsoschon[JSON.siRemotionem] == null
            ? null
            : SiRemotionem.fromJson(
                jsoschon[JSON.siRemotionem] as Map<String, dynamic>),
        inputs = List<TransactioInput>.from((jsoschon[JSON.inputs]
                as List<dynamic>)
            .map((i) => TransactioInput.fromJson(i as Map<String, dynamic>))),
        outputs = List<TransactioOutput>.from(jsoschon[JSON.outputs]
            .map((o) => TransactioOutput.fromJson(o as Map<String, dynamic>))),
        identitatis = jsoschon[JSON.identitatis].toString(),
        dominus = jsoschon[JSON.dominus].toString(),
        nonce = BigInt.parse(jsoschon[JSON.nonce].toString());
}
class InterioreTransactio {
  String? signature;
  BigInt nonce;
  InterioreInterioreTransactio interioreInterioreTransactio;
  InterioreTransactio(this.signature, this.interioreInterioreTransactio): nonce = BigInt.zero;
  InterioreTransactio.fromJson(Map<String, dynamic> jsoschon):
    signature = jsoschon[JSON.signature].toString() == 'null' ? null : jsoschon[JSON.signature],
    nonce = BigInt.parse(jsoschon[JSON.nonce].toString()),
    interioreInterioreTransactio = InterioreInterioreTransactio.fromJson(jsoschon[JSON.interioreInterioreTransactio] as Map<String, dynamic>);
  Map<String, dynamic> toJson() => {
    JSON.signature: signature,
    JSON.interioreInterioreTransactio: interioreInterioreTransactio.toJson()
  };
  InterioreTransactio.praemium(String producentis): 
    nonce = BigInt.zero, 
    interioreInterioreTransactio = InterioreInterioreTransactio.praemium(producentis);
  InterioreTransactio.transform({required bool liber, required String dominus, required List<TransactioInput> inputs, required List<TransactioOutput> outputs }): 
  nonce = BigInt.zero,
  interioreInterioreTransactio = InterioreInterioreTransactio.transform(liber: liber, dominus: dominus, inputs: inputs, outputs:  outputs);

  mine() {
    nonce += BigInt.one;
  }

}

class Transactio {
  // bool capta;
  late String probationem;
  final InterioreTransactio interioreTransactio;
  Transactio(this.probationem, this.interioreTransactio);
  Transactio.fromJson(Map<String, dynamic> jsoschon)
      : probationem = jsoschon[JSON.probationem].toString(),
        interioreTransactio = InterioreTransactio.fromJson(
            jsoschon[JSON.interioreTransactio] as Map<String, dynamic>);
  Transactio.nullam(this.interioreTransactio)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreTransactio.toJson())))
            .bytes);
  Transactio.praemium(String producentis)
      : interioreTransactio = InterioreTransactio.praemium(producentis) {
    probationem = HEX.encode(sha512
        .convert(utf8.encode(json.encode(interioreTransactio.toJson())))
        .bytes);
  }
  static void quaestum(List<dynamic> argumentis) {
    InterioreTransactio interiore = argumentis[0] as InterioreTransactio;
    SendPort mitte = argumentis[1] as SendPort;
    String probationem = '';
    int zeros = 1;
    while (true) {
      do {
        interiore.mine();
        probationem = HEX.encode(
            sha512.convert(utf8.encode(json.encode(interiore.toJson()))).bytes);
      } while (!probationem.startsWith('0' * zeros));
      zeros += 1;
      mitte.send(Transactio(probationem, interiore));
    }
  }
  bool validateBlockreward() {
    if (interioreTransactio.outputs.length != 1) {
      return false;
    }
    if (interioreTransactio.outputs[0].pod !=
        Constantes.obstructionumPraemium) {
      return false;
    }
    if (interioreTransactio.inputs.isNotEmpty) {
      return false;
    }
    return true;
  }

  Future<bool> validateBurn(Directory dir) async {
    List<Obstructionum> obs = await Obstructionum.getBlocks(dir);
    BigInt spendable = BigInt.zero;
    for (TransactioInput input in interioreTransactio.inputs) {
      Obstructionum prevObs = obs.singleWhere((ob) =>
          ob.interioreObstructionum.liberTransactions.any((liber) =>
              liber.interioreTransactio.identitatis ==
              input.transactioIdentitatis));
      TransactioOutput output = prevObs.interioreObstructionum.liberTransactions
          .singleWhere((liber) =>
              liber.interioreTransactio.identitatis ==
              input.transactioIdentitatis)
          .interioreTransactio
          .outputs[input.index];
      spendable = output.pod;
    }
    BigInt spended = BigInt.zero;
    for (TransactioOutput output in interioreTransactio.outputs) {
      spended += output.pod;
    }
    if (spendable > spended) {
      return false;
    }
    return true;
  }

  static Future<bool> validateArdeat(
      List<TransactioInput> tins, List<Obstructionum> lo) async {
    List<List<TransactioOutput>> toss = [];
    lo
        .map((obs) => obs.interioreObstructionum.liberTransactions
            .where((lt) =>
                lt.interioreTransactio.transactioSignificatio ==
                    TransactioSignificatio.ardeat &&
                tins
                    .map((ti) => ti.transactioIdentitatis)
                    .contains(lt.interioreTransactio.identitatis))
            .map((lt) => lt.interioreTransactio.outputs))
        .forEach(toss.addAll);
    List<int> tii = tins.map((ti) => ti.index).toList();
    List<String> publicaClavises = [];
    for (List<TransactioOutput> tos in toss) {
      for (int i = 0; i < tii.length; i++) {
        publicaClavises.add(tos[tii[i]].publicaClavis);
      }
    }
    List<Tuple2<String, BigInt>> ssb = [];
    for (List<TransactioOutput> tos in toss) {
      for (int i = 0; i < tii.length; i++) {
        ssb.add(Tuple2(tos[tii[i]].publicaClavis, tos[tii[i]].pod));
      }
    }
    List<String> pcs = [];
    List<Tuple2<String, BigInt>> lsssb = [];
    for (int i = 0; i < lsssb.length; i++) {
      if (!pcs.contains(lsssb[i].item1)) {
        pcs.add(lsssb[i].item1);
        lsssb.add(Tuple2(lsssb[i].item1, lsssb[i].item2));
      } else {
        BigInt sta =
            lsssb.singleWhere((pc) => pc.item1 == lsssb[i].item1).item2 +
                lsssb[i].item2;
        lsssb.removeAt(i);
        lsssb.add(Tuple2(lsssb[i].item1, sta));
      }
    }
    for (Tuple2<String, BigInt> sssb in lsssb) {
      if (sssb.item2 == await Pera.statera(true, sssb.item1, lo)) {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }

  bool isFurantur() {
    return interioreTransactio.outputs
        .any((element) => element.pod < BigInt.zero);
  }
  // bool habetProfundum(List<Obstructionum> lo) {
  //   List<TransactioInput> lti = interioreTransactio.inputs;
  //   List<String> tiidentitatum = [];
  //   lti.map((mti) => mti.transactioIdentitatis).forEach(tiidentitatum.add);
  //   List<Transactio> lt = [];
  //   lo.map((mo) => interioreTransactio.liber ? mo.interioreObstructionum.liberTransactions.where((wlt) => tiidentitatum.any((ai) => ai == wlt.interioreTransactio.identitatis)) : mo.interioreObstructionum.fixumTransactions.where((wft) => tiidentitatum.any((ai) => ai == wft.interioreTransactio.identitatis))).forEach(lt.addAll);
  //   List<TransactioOutput> lto = [];
  //   lt.map((mt) => mt.interioreTransactio.outputs).forEach(lto.addAll);
  //   List<SiRemotionem> lsr = [];
  //   lo.map((mo) => mo.interioreObstructionum.siRemotiones).forEach(lsr.addAll);
  //   List<SiRemotionemInput?> lsri = [];
  //   lsr.map((msr) => msr.interioreSiRemotionem.siRemotionemInput).forEach(lsri.add);
  //   List<String?> sriidentitatum = [];
  //   lsri.map((msri) => msri?.siRemotionemIdentiatis).forEach(sriidentitatum.add);
  // }

  // Future<bool> convalidandumTransaction(
  //     String? victor, TransactioGenus tg, List<Transactio> stagnum, List<Obstructionum> lo) async {
  //   print('timetoconvtx hereis stagnum\n');
  //   print(stagnum.map((e) => e.toJson()));
  //   BigInt spendable = BigInt.zero;
  //   for (TransactioInput input in interioreTransactio.inputs) {
  //     switch (tg) {
  //       case TransactioGenus.liber:
  //         {
  //           Obstructionum? o = lo
  //               .singleWhereOrNull((obs) => obs
  //                   .interioreObstructionum.liberTransactions
  //                   .any((transactions) =>
  //                       transactions.interioreTransactio.identitatis ==
  //                       input.transactioIdentitatis));
  //           if (o == null) {
  //             Transactio transactio = stagnum.singleWhere((sws) => sws.interioreTransactio.identitatis == input.transactioIdentitatis);
  //             spendable +=
  //               transactio.interioreTransactio.outputs[input.index].pod;
  //             if(!transactio.validateLiber(victor, input)) {
  //               Print.nota(nuntius: 'Invalidum liber transactio', message: 'Invalid liber transaction');
  //               return false;
  //             }
  //           } else {
  //             Transactio transactio = o.interioreObstructionum.liberTransactions.singleWhere((swlt) => swlt.interioreTransactio.identitatis == input.transactioIdentitatis);
  //             spendable +=
  //               transactio.interioreTransactio.outputs[input.index].pod;
  //             if(!transactio.validateLiber(victor, input)) {
  //               Print.nota(nuntius: 'Invalidum liber transactio', message: 'Invalid liber transaction');
  //               return false;
  //             }
  //           }
  //         }
  //       case TransactioGenus.expressi:
  //         {
  //           Obstructionum? o = lo.singleWhereOrNull((swono) => swono.interioreObstructionum.liberTransactions.any((transactio) => transactio.interioreTransactio.identitatis == input.transactioIdentitatis));
  //           if (o == null) {
  //               print('inputsid\n');
  //               print(input.transactioIdentitatis);
  //               Transactio transactio = stagnum.singleWhere((sws) => sws.interioreTransactio.identitatis == input.transactioIdentitatis);
  //               spendable +=
  //               transactio.interioreTransactio.outputs[input.index].pod;
  //               if (!estSominusPecuniae(input, transactio)) {
  //                 Print.nota(
  //                     nuntius: 'non est dominus pecuniae',
  //                     message: 'is not the owner of money');
  //                 return false;
  //               } else {
  //                 return true;
  //               }
  //           } else {
  //               Transactio transactio = o.interioreObstructionum.liberTransactions.singleWhere((swlt) => swlt.interioreTransactio.identitatis == input.transactioIdentitatis);
  //               spendable +=
  //               transactio.interioreTransactio.outputs[input.index].pod;
  //               if (!estSominusPecuniae(input, transactio)) {
  //                 Print.nota(
  //                     nuntius: 'non est dominus pecuniae',
  //                     message: 'is not the owner of money');
  //                 return false;
  //               } else {
  //                 return true;
  //               }
  //           }
  //         }
  //       case TransactioGenus.fixum:
  //         {
  //           Obstructionum? o = lo
  //               .singleWhereOrNull((obs) => obs
  //                   .interioreObstructionum.fixumTransactions
  //                   .any((transactions) =>
  //                       transactions.interioreTransactio.identitatis ==
  //                       input.transactioIdentitatis));
  //           if (o == null) {
  //             Transactio transactio = stagnum.singleWhere((sws) => sws.interioreTransactio.identitatis == input.transactioIdentitatis);
  //             spendable +=
  //               transactio.interioreTransactio.outputs[input.index].pod;
  //             if (!estSominusPecuniae(input, transactio) &&
  //                 interioreTransactio.transactioSignificatio !=
  //                     TransactioSignificatio.transform) {
  //               Print.nota(
  //                   nuntius: 'non est dominus pecuniae',
  //                   message: 'is not the owner of money');
  //               return false;
  //             } else {
  //               return true;
  //             }
  //           } else {
  //             Transactio transactio = o.interioreObstructionum.fixumTransactions.singleWhere((swft) => swft.interioreTransactio.identitatis == input.transactioIdentitatis);
  //             spendable +=
  //                 transactio.interioreTransactio.outputs[input.index].pod;
  //             if (!estSominusPecuniae(input, transactio) &&
  //                 interioreTransactio.transactioSignificatio !=
  //                     TransactioSignificatio.transform) {
  //               Print.nota(
  //                   nuntius: 'non est dominus pecuniae',
  //                   message: 'is not the owner of money');
  //               return false;
  //             } else {
  //               return true;
  //             }
  //           }
            
  //         }
  //     }
  //   }
  //   if (interioreTransactio.transactioSignificatio ==
  //       TransactioSignificatio.transform) {
  //     return true;
  //   }
  //   BigInt spended = BigInt.zero;
  //   for (TransactioOutput output in interioreTransactio.outputs) {
  //     spended += output.pod;
  //   }
  //   return spendable == spended;
  // }

  // bool estSominusPecuniae(TransactioInput input, Transactio transactio) {
  //   return Utils.cognoscere(
  //       PublicKey.fromHex(Pera.curve(),
  //           transactio.interioreTransactio.outputs[input.index].publicaClavis),
  //       Signature.fromASN1Hex(input.signature),
  //       transactio.interioreTransactio.outputs[input.index]);
  // }

  // bool estSubscriptioneVictor(
  //     String victor, TransactioInput ti, Transactio transactio) {
  //   return Utils.cognoscere(
  //       PublicKey.fromHex(Pera.curve(), victor),
  //       Signature.fromASN1Hex(ti.signature),
  //       transactio.interioreTransactio.outputs[ti.index]);
  // }

  bool estDominus(Iterable<Transactio> llt, List<Obstructionum> lo) {
    List<Transactio> lltc = List<Transactio>.from(llt.map((mo) => Transactio.fromJson(mo.toJson())));
    lo.map((mo) => interioreTransactio.liber ? mo.interioreObstructionum.liberTransactions.where((wlt) => interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == wlt.interioreTransactio.identitatis)) : mo.interioreObstructionum.fixumTransactions.where((wft) => interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis ==  wft.interioreTransactio.identitatis))).forEach(lltc.addAll); 
    print('lltcshoudlhaveitbutdidnot \n ${lltc.map((e) => e.toJson())}');
    return interioreTransactio.inputs.every((ei) => Utils.cognoscere(PublicKey.fromHex(Pera.curve(), interioreTransactio.dominus), Signature.fromASN1Hex(ei.signature), lltc.singleWhere((swlt) => swlt.interioreTransactio.identitatis == ei.transactioIdentitatis).interioreTransactio.outputs[ei.index]));
  }
  bool minusQuamBidInProbationibus(Iterable<Transactio> lt, List<Obstructionum> lo) {
    if (interioreTransactio.transactioSignificatio == TransactioSignificatio.regularis || interioreTransactio.transactioSignificatio == TransactioSignificatio.refugium) {
        BigInt impendio = BigInt.zero;
        for (TransactioOutput to in interioreTransactio.outputs.where((wo) => wo.publicaClavis != interioreTransactio.dominus)) {
          impendio += to.pod;
        }
        return impendio <= Pera.habetBid(interioreTransactio.liber, interioreTransactio.dominus, lo);
    }
    return true;
  }
  bool verumMoles(Iterable<Transactio> llt, List<Obstructionum> lo) {
    List<Transactio> lltc = List<Transactio>.from(llt.map((mo) => Transactio.fromJson(mo.toJson())));
    lo.map((mo) => interioreTransactio.liber ? mo.interioreObstructionum.liberTransactions.where((wlt) => interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == wlt.interioreTransactio.identitatis)) : mo.interioreObstructionum.fixumTransactions.where((wft) => interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis ==  wft.interioreTransactio.identitatis))).forEach(lltc.addAll);   
    BigInt licet = BigInt.zero;
    for (TransactioInput ti in interioreTransactio.inputs) {
      licet += lltc.singleWhere((swlt) => swlt.interioreTransactio.identitatis == ti.transactioIdentitatis).interioreTransactio.outputs[ti.index].pod;
    }
    BigInt impendio = BigInt.zero;
    for (TransactioOutput to in interioreTransactio.outputs) {
      impendio += to.pod;
    }
    return impendio == licet;
  }
  bool solucionis(List<Obstructionum> lo) {
    List<SolucionisPropter> lsp = [];
    lo.map((mo) => mo.interioreObstructionum.solucionisRationibus).forEach(lsp.addAll);
    List<FissileSolucionisPropter> lfsp = [];
    lo.map((mo) => mo.interioreObstructionum.fissileSolucionisRationibus).forEach(lfsp.addAll);
    if (lsp.any((asp) => asp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == interioreTransactio.dominus) || lfsp.any((afsp) => afsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == interioreTransactio.dominus)) {
      return true;
    }
    return false;
  }


  Map<String, dynamic> toJson() => {
        JSON.probationem: probationem,
        JSON.interioreTransactio: interioreTransactio.toJson()
      };
  static List<Transactio> grab(Iterable<Transactio> txs) {
    List<Transactio> reditus = [];
    for (int i = 128; i > 0; i--) {
      if (txs.any((tx) => tx.probationem.startsWith('0' * i))) {
        if (reditus.length < Constantes.txCaudice) {
          reditus.addAll(txs.where((tx) =>
              tx.probationem.startsWith('0' * i) && !reditus.contains(tx)));
        } else {
          break;
        }
      }
    }
    return reditus;
  }

  bool validateProbationem() {
    if (probationem !=
        HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreTransactio.toJson())))
            .bytes)) {
      return false;
    }
    return true;
  }

  // bool validateLiber(String? victor, TransactioInput ti) {
  //     switch (interioreTransactio.transactioSignificatio) {
  //             case TransactioSignificatio.ardeat:
  //             case TransactioSignificatio.expressi:
  //             case TransactioSignificatio.regularis:
  //               {
  //                 if (!estSominusPecuniae(ti, this)) {
  //                   return false;
  //                 }
  //                 break;
  //               }
  //             case TransactioSignificatio.transform:
  //               {
  //                 if (!estSubscriptioneVictor(victor!, ti, this)) {
  //                   return false;
  //                 }
  //                 break;
  //               }
  //             default: 
  //               break;
  //           }
  //     return true;
  // }

  bool habetProfundum(List<Obstructionum> lo) {
    List<SiRemotionem> lsr = [];
    lo.map((mlo) => mlo.interioreObstructionum.siRemotiones).forEach(lsr.addAll);
    List<SiRemotionemInput> lsri = [];
    lsr.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null).map((msr) => msr.interioreSiRemotionem.siRemotionemInput!).forEach(lsri.add);
    List<SiRemotionemOutput> lsro = [];
    lsr.where((wsr) => !lsri.any((asri) => asri.siRemotionemIdentiatis == wsr.interioreSiRemotionem.identitatisInterioreSiRemotionem) && wsr.interioreSiRemotionem.siRemotionemOutput != null).map((msr) => msr.interioreSiRemotionem.siRemotionemOutput!).forEach(lsro.add);
    List<TransactioOutput> lto = [];
    for (TransactioInput ti in interioreTransactio.inputs) {
      print('imsearching for a tx with identitatis\n ${ti.transactioIdentitatis}');
      print('and my index is\n ${ti.index}');
      print('and the full json is ${ti.toJson()}');
      List<Transactio> lt = [];
        lo.where((wlo) => interioreTransactio.liber ? wlo.interioreObstructionum.liberTransactions.any((alt) => alt.interioreTransactio.identitatis == ti.transactioIdentitatis) : wlo.interioreObstructionum.fixumTransactions.any((aft) => aft.interioreTransactio.identitatis == ti.transactioIdentitatis)).map((mo) => interioreTransactio.liber ? mo.interioreObstructionum.liberTransactions.singleWhere((wlt) => wlt.interioreTransactio.identitatis == ti.transactioIdentitatis) : mo.interioreObstructionum.fixumTransactions.singleWhere((swft) => swft.interioreTransactio.identitatis == ti.transactioIdentitatis)).forEach(lt.add);
      for (Transactio t in lt) {
        print('thetxweregoeswrong\\n ${t.toJson()}');
        lto.add(t.interioreTransactio.outputs[ti.index]);
      }
    }
    return !lto.every((eto) => !lsro.map((msro) => msro.debetur).contains(eto.publicaClavis));
  }

  
  static Future<bool> omnesClavesPublicasDefendi(
      List<TransactioOutput> outputs, List<Obstructionum> lo) async {
    for (TransactioOutput output in outputs) {
      if (!await Pera.isPublicaClavisDefended(output.publicaClavis, lo)) {
        return false;
      }
    }
    return true;
  }

  static Future<bool> inObstructionumCatenae(TransactioGenus tg,
      List<String> identitatump, List<Obstructionum> lo) async {
    List<String> identitatum = [];
    switch (tg) {
      case TransactioGenus.liber:
        {
          lo
              .map((ob) => ob.interioreObstructionum.liberTransactions
                  .map((lt) => lt.interioreTransactio.identitatis))
              .forEach(identitatum.addAll);
          return identitatump
              .every((identitatis) => identitatum.contains(identitatis));
        }
      case TransactioGenus.fixum:
        {
          lo
              .map((ob) => ob.interioreObstructionum.fixumTransactions
                  .map((ft) => ft.interioreTransactio.identitatis))
              .forEach(identitatum.addAll);
          return identitatump
              .every((identitatis) => identitatum.contains(identitatis));
        }
      case TransactioGenus.expressi:
        {
          lo
              .map((ob) => ob.interioreObstructionum.expressiTransactions
                  .map((et) => et.interioreTransactio.identitatis))
              .forEach(identitatum.addAll);
          return identitatump
              .every((identitatis) => identitatum.contains(identitatis));
        }
    }
  }


}
