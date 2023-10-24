import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ecdsa/ecdsa.dart';
import '../auxiliatores/print.dart';
import '../connect/par_ad_rimor.dart';
import './constantes.dart';
import 'connexa_liber_expressi.dart';
import 'errors.dart';
import 'gladiator.dart';
import './transactio.dart';
import './utils.dart';
import 'package:hex/hex.dart';
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';
import 'package:elliptic/elliptic.dart';

import 'pera.dart';
import 'telum.dart';

enum Generare { incipio, efectus, confussus, expressi }

extension GenerareFromJson on Generare {
  static fromJson(String name) {
    switch (name) {
      case 'incipio':
        return Generare.incipio;
      case 'efectus':
        return Generare.efectus;
      case 'confussus':
        return Generare.confussus;
      case 'expressi':
        return Generare.expressi;
    }
  }
}

enum Corrumpo { forumCap, summaDifficultas, numerus, divisa, legalis }

enum QuidFacere { solitum, subter, corrupt }

class InterioreObstructionum {
  final Generare generare;
  final bool estFurca;
  int? numeruCuneosMaximumsOrdinata;
  int obstructionumDifficultas;
  int indicatione;
  BigInt nonce;
  final double divisa;
  final BigInt summaObstructionumDifficultas;
  final BigInt forumCap;
  final BigInt liberForumCap;
  final BigInt fixumForumCap;
  BigInt? obstructionumPraemium;
  final List<int> obstructionumNumerus;
  String? defensio;
  String? impetum;
  final String producentis;
  final String priorProbationem;
  final Gladiator gladiator;
  final List<Transactio> liberTransactions;
  final List<Transactio> fixumTransactions;
  final List<Transactio> expressiTransactions;
  final List<ConnexaLiberExpressi> connexaLiberExpressis;
  final List<SiRemotionem> siRemotiones;

  InterioreObstructionum(
      {required this.generare,
      required this.estFurca,
      required this.obstructionumDifficultas,
      required this.divisa,
      required this.summaObstructionumDifficultas,
      required this.forumCap,
      required this.liberForumCap,
      required this.fixumForumCap,
      required this.obstructionumNumerus,
      required this.defensio,
      required this.impetum,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones})
      : indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero;

  InterioreObstructionum.incipio({required this.producentis})
      : generare = Generare.incipio,
        estFurca = false,
        numeruCuneosMaximumsOrdinata = 7637637637637637637,
        obstructionumDifficultas = 0,
        divisa = 0,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero,
        summaObstructionumDifficultas = BigInt.zero,
        forumCap = BigInt.zero,
        liberForumCap = BigInt.zero,
        fixumForumCap = BigInt.zero,
        obstructionumNumerus = [0],
        defensio = Utils.randomHex(1),
        impetum = Utils.randomHex(1),
        priorProbationem = '',
        gladiator = Gladiator.nullam(InterioreGladiator.incipio(producentis)),
        liberTransactions = List<Transactio>.from(
            [Transactio.nullam(InterioreTransactio.praemium(producentis))]),
        fixumTransactions = [],
        expressiTransactions = [],
        connexaLiberExpressis = [],
        siRemotiones = [];

  InterioreObstructionum.efectus(
      {required this.estFurca,
      required this.obstructionumDifficultas,
      required this.summaObstructionumDifficultas,
      required this.divisa,
      required this.forumCap,
      required this.liberForumCap,
      required this.fixumForumCap,
      required this.obstructionumNumerus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required Obstructionum prior})
      : generare = Generare.efectus,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero,
        defensio = Utils.randomHex(1),
        impetum = Utils.randomHex(1);

  InterioreObstructionum.confussus(
      {required this.estFurca,
      required this.obstructionumDifficultas,
      required this.summaObstructionumDifficultas,
      required this.divisa,
      required this.forumCap,
      required this.fixumForumCap,
      required this.liberForumCap,
      required this.obstructionumNumerus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required Obstructionum prior})
      : generare = Generare.confussus,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero;
  InterioreObstructionum.expressi(
      {required this.estFurca,
      required this.obstructionumDifficultas,
      required this.summaObstructionumDifficultas,
      required this.forumCap,
      required this.liberForumCap,
      required this.fixumForumCap,
      required this.divisa,
      required this.obstructionumNumerus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required Obstructionum prior})
      : generare = Generare.expressi,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero;

  mine() {
    indicatione = DateTime.now().microsecondsSinceEpoch;
    nonce += BigInt.one;
  }

  Map<String, dynamic> toJson() => {
        JSON.estFurca: estFurca,
        JSON.generare: generare.name.toString(),
        JSON.obstructionumDifficultas: obstructionumDifficultas,
        JSON.divisa: divisa.toString(),
        JSON.indicatione: indicatione,
        JSON.nonce: nonce.toString(),
        JSON.summaObstructionumDifficultas:
            summaObstructionumDifficultas.toString(),
        JSON.forumCap: forumCap.toString(),
        JSON.liberForumCap: liberForumCap.toString(),
        JSON.fixumForumCap: fixumForumCap.toString(),
        JSON.obstructionumNumerus: obstructionumNumerus.toList(),
        JSON.defensio: defensio,
        JSON.impetum: impetum,
        JSON.producentis: producentis,
        JSON.priorProbationem: priorProbationem,
        JSON.gladiator: gladiator.toJson(),
        JSON.liberTransactions:
            liberTransactions.map((e) => e.toJson()).toList(),
        JSON.fixumTransactions:
            fixumTransactions.map((e) => e.toJson()).toList(),
        JSON.expressiTransactions:
            expressiTransactions.map((e) => e.toJson()).toList(),
        JSON.adRemovendumConnexaLiberExpressis:
            connexaLiberExpressis.map((e) => e.toJson()).toList(),
        JSON.siRemotiones: siRemotiones.map((e) => e.toJson()).toList()
      }..removeWhere((key, value) => value == null);
  InterioreObstructionum.fromJson(Map jsoschon)
      : estFurca = bool.parse(jsoschon[JSON.estFurca].toString()),
        generare = GenerareFromJson.fromJson(jsoschon[JSON.generare].toString())
            as Generare,
        obstructionumDifficultas =
            int.parse(jsoschon[JSON.obstructionumDifficultas].toString()),
        divisa = double.parse(jsoschon[JSON.divisa].toString()),
        indicatione = int.parse(jsoschon[JSON.indicatione].toString()),
        nonce = BigInt.parse(jsoschon[JSON.nonce].toString()),
        summaObstructionumDifficultas = BigInt.parse(
            jsoschon[JSON.summaObstructionumDifficultas].toString()),
        forumCap = BigInt.parse(jsoschon[JSON.forumCap].toString()),
        liberForumCap = BigInt.parse(jsoschon[JSON.liberForumCap].toString()),
        fixumForumCap = BigInt.parse(jsoschon[JSON.fixumForumCap]),
        obstructionumNumerus = List<int>.from(
            jsoschon[JSON.obstructionumNumerus] as List<dynamic>),
        defensio = jsoschon[JSON.defensio].toString() == 'null'
            ? null
            : jsoschon[JSON.defensio].toString(),
        impetum = jsoschon[JSON.impetum].toString() == 'null'
            ? null
            : jsoschon[JSON.impetum].toString(),
        producentis = jsoschon[JSON.producentis].toString(),
        priorProbationem = jsoschon[JSON.priorProbationem].toString(),
        gladiator = Gladiator.fromJson(
            jsoschon[JSON.gladiator] as Map<String, dynamic>),
        liberTransactions = List<Transactio>.from(
            jsoschon[JSON.liberTransactions]
                    .map((l) => Transactio.fromJson(l as Map<String, dynamic>))
                as Iterable<dynamic>),
        fixumTransactions = List<Transactio>.from(
            jsoschon[JSON.fixumTransactions]
                    .map((f) => Transactio.fromJson(f as Map<String, dynamic>))
                as Iterable<dynamic>),
        expressiTransactions = List<Transactio>.from(
            jsoschon[JSON.expressiTransactions]
                    .map((e) => Transactio.fromJson(e as Map<String, dynamic>))
                as Iterable<dynamic>),
        connexaLiberExpressis = List<ConnexaLiberExpressi>.from(
            (jsoschon[JSON.adRemovendumConnexaLiberExpressis] as List<dynamic>)
                .map((cle) => ConnexaLiberExpressi.fromJson(
                    cle as Map<String, dynamic>))),
        siRemotiones = List<SiRemotionem>.from((jsoschon[JSON.siRemotiones]
                as List<dynamic>)
            .map((sr) => SiRemotionem.fromJson(sr as Map<String, dynamic>)));

  BigInt numero() {
    BigInt n = BigInt.zero;
    for (int i in obstructionumNumerus) {
      n += BigInt.parse(i.toString());
    }
    return n;
  }

  double divisone() {
    return numero() / BigInt.parse(obstructionumDifficultas.toString());
  }
}

class InFieriObstructionum {
  List<String> gladiatorIdentitatum = [];
  List<String> liberTransactions = [];
  List<String> fixumTransactions = [];
  List<String> expressiTransactions = [];
  List<String> connexaLiberExpressis = [];
  InFieriObstructionum(
      this.gladiatorIdentitatum,
      this.liberTransactions,
      this.fixumTransactions,
      this.expressiTransactions,
      this.connexaLiberExpressis);
}

class Obstructionum {
  final InterioreObstructionum interioreObstructionum;
  late String probationem;
  Obstructionum(this.interioreObstructionum, this.probationem);
  Obstructionum.incipio(this.interioreObstructionum)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreObstructionum.toJson())))
            .bytes);
  static Future efectus(List<dynamic> args) async {
    InterioreObstructionum interioreObstructionum =
        args[0] as InterioreObstructionum;
    SendPort mitte = args[1] as SendPort;
    String probationem = '';
    do {
      interioreObstructionum.mine();
      probationem = HEX.encode(sha512
          .convert(utf8.encode(json.encode(interioreObstructionum.toJson())))
          .bytes);
        print(probationem);
    } while (!probationem
        .startsWith('0' * interioreObstructionum.obstructionumDifficultas));
    mitte.send(Obstructionum(interioreObstructionum, probationem));
  }

  static Future confussus(List<dynamic> args) async {
    InterioreObstructionum interioreObstructionum =
        args[0] as InterioreObstructionum;
    List<String> toCrack = args[1] as List<String>;
    SendPort mitte = args[2] as SendPort;
    String probationem = '';
    bool doschoes = false;
    while (true) {
      do {
        interioreObstructionum.mine();
        probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreObstructionum.toJson())))
            .bytes);
      } while (!probationem
          .startsWith('0' * interioreObstructionum.obstructionumDifficultas));
      for (int i = 0; i < toCrack.length; i++) {
        if (probationem.contains(toCrack[i])) {
          doschoes = true;
        } else {
          doschoes = false;
          break;
        }
      }
      if (doschoes) {
        break;
      } else {
        continue;
      }
    }
    mitte.send(Obstructionum(interioreObstructionum, probationem));
  }

  static Future expressi(List<dynamic> args) async {
    InterioreObstructionum interioreObstructionum =
        args[0] as InterioreObstructionum;
    List<String> toCrack = args[1] as List<String>;
    SendPort mitte = args[2] as SendPort;
    String probationem = '';
    bool doschoes = false;
    while (true) {
      do {
        interioreObstructionum.mine();
        probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreObstructionum.toJson())))
            .bytes);
      } while (!probationem.startsWith('0' *
              (interioreObstructionum.obstructionumDifficultas / 2).floor()) ||
          !probationem.endsWith('0' *
              (interioreObstructionum.obstructionumDifficultas / 2).floor()));
      for (int i = 0; i < toCrack.length; i++) {
        if (probationem.contains(toCrack[i])) {
          doschoes = true;
        } else {
          doschoes = false;
          break;
        }
      }
      if (doschoes) {
        break;
      } else {
        continue;
      }
    }
    mitte.send(Obstructionum(interioreObstructionum, probationem));
  }

  Map<String, dynamic> toJson() => {
        JSON.interioreObstructionum: interioreObstructionum.toJson(),
        JSON.probationem: probationem
      };
  Obstructionum.fromJson(Map<String, dynamic> jsoschon)
      : interioreObstructionum = InterioreObstructionum.fromJson(
            jsoschon[JSON.interioreObstructionum] as Map<String, dynamic>),
        probationem = jsoschon[JSON.probationem].toString();

  bool isProbationem() {
    if (probationem ==
        HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreObstructionum.toJson())))
            .bytes)) {
      return true;
    }
    return false;
  }

  Future salvareIncipio(Directory dir) async {
    File file = await File('${dir.path}${Constantes.caudices}0.txt')
        .create(recursive: true);
    await interioreSalvare(file);
  }

  Future salvare(Directory dir) async {
    File file = await File(
            '${dir.path}${Constantes.caudices}${(dir.listSync().length - 1)}.txt')
        .create(recursive: true);
    if (await Utils.fileAmnis(file).length > Constantes.maximeCaudicesFile) {
      file = await File(
              '${dir.path}${Constantes.caudices}${(dir.listSync().length)}.txt')
          .create(recursive: true);
      await interioreSalvare(file);
    } else {
      await interioreSalvare(file);
    }
  }

  Future interioreSalvare(File file) async {
    var sink = file.openWrite(mode: FileMode.append);
    sink.write('${json.encode(toJson())}\n');
    sink.close();
  }

  static Future<Obstructionum> accipereIncipio(Directory directorium) async {
    return Obstructionum.fromJson(json.decode(await Utils.fileAmnis(
            File('${directorium.path}${Constantes.caudices}0.txt'))
        .first) as Map<String, dynamic>);
  }

  static Future<Obstructionum> acciperePrior(Directory directorium) async =>
      Obstructionum.fromJson(json.decode(await Utils.fileAmnis(File(
              '${directorium.path}${Constantes.caudices}${(directorium.listSync().isNotEmpty ? directorium.listSync().length - 1 : 0)}.txt'))
          .last) as Map<String, dynamic>);

  static Future<Obstructionum> accipereObstructionNumerus(
      List<int> numerus, Directory directory) async {
    File file =
        File('${directory.path}/${Constantes.caudices}${numerus.length - 1}');
    List<String> lines = await Utils.fileAmnis(file).toList();
    return Obstructionum.fromJson(
        json.decode(lines[numerus.last]) as Map<String, dynamic>);
  }

  static Future<List<GladiatorOutput>> utDifficultas(
      List<Obstructionum> lo) async {
    List<GladiatorInput?> lgi = [];
    lo.map((mo) => mo.interioreObstructionum.gladiator.interioreGladiator.input).forEach(lgi.add);
    List<String?> identitatum = [];
    lgi.map((mgi) => mgi?.gladiatorIdentitatis).forEach(identitatum.add);
    // List<Tuple3<String, GladiatorOutput, bool>> gladiatorOutputs = [];
    List<InterioreGladiator> lig = [];
    lo.map((mo) => mo.interioreObstructionum.gladiator.interioreGladiator).forEach(lig.add);
    List<GladiatorOutput> lgo = [];
    for (InterioreGladiator ig in lig) {
      if (!identitatum.contains(ig.identitatis)) {
        lgo.addAll(ig.outputs);
      } else {
        for(GladiatorInput? gi in lgi.where((swgi) => swgi?.gladiatorIdentitatis == ig.identitatis)) {
          if (gi != null) {
            lgo.add(ig.outputs[gi.primis ? 0 : 1]);
          }
        }
  
      }
    }
    return lgo;
  }

  static Future<List<Tuple3<String, GladiatorOutput, bool>>>
      invictosGladiatores(Directory directory) async {
    List<Obstructionum> caudices = [];
    List<GladiatorInput?> gladiatorInitibus = [];
    List<Tuple3<String, GladiatorOutput, bool>> gladiatorOutputs = [];
    for (int i = 0; i < directory.listSync().length; i++) {
      caudices.addAll(await Utils.fileAmnis(
              File('${directory.path}${Constantes.caudices}$i.txt'))
          .map((b) =>
              Obstructionum.fromJson(json.decode(b) as Map<String, dynamic>))
          .toList());
    }
    caudices.forEach((obstructionum) {
      gladiatorInitibus.add(obstructionum
          .interioreObstructionum.gladiator.interioreGladiator.input);
    });
    caudices.forEach((obstructionum) {
      for (int i = 0;
          i <
              obstructionum.interioreObstructionum.gladiator.interioreGladiator
                  .outputs.length;
          i++) {
        gladiatorOutputs.add(Tuple3<String, GladiatorOutput, bool>(
            obstructionum.interioreObstructionum.gladiator.interioreGladiator
                .identitatis,
            obstructionum
                .interioreObstructionum.gladiator.interioreGladiator.outputs[i],
            i == 0 ? true : false));
      }
    });
    gladiatorOutputs.removeWhere((element) => gladiatorInitibus.any((init) =>
        init?.gladiatorIdentitatis == element.item1 &&
        init?.primis == element.item3));
    return gladiatorOutputs;
  }

  static Future<BigInt> utSummaDifficultas(List<Obstructionum> lo) async {
    List<GladiatorOutput> lgo = await Obstructionum.utDifficultas([lo.first]);
    BigInt total = BigInt.from(lgo.length);
    for (Obstructionum o in lo) {
      total += BigInt.from(o.interioreObstructionum.obstructionumDifficultas);
    }
    return total;
  }

  static Future<List<int>> utObstructionumNumerus(
      Obstructionum obstructionum) async {
    List<int> dif = obstructionum.interioreObstructionum.obstructionumNumerus;

    final int priorObstructionumNumerus = dif[dif.length - 1];
    if (priorObstructionumNumerus < Constantes.maximeCaudicesFile) {
      dif[dif.length - 1]++;
    } else if (priorObstructionumNumerus == Constantes.maximeCaudicesFile) {
      dif.add(0);
    }
    return dif;
  }

  static Future<BigInt> numeruo(List<int> numerus) async {
    BigInt n = BigInt.zero;
    for (int i in numerus) {
      n += BigInt.parse(i.toString());
    }
    return n;
  }

  static Future<List<Obstructionum>> getBlocks(Directory directory) async {
    List<Obstructionum> obs = [];
    for (int i = 0; i < directory.listSync().length; i++) {
      await for (String line in Utils.fileAmnis(
          File('${directory.path}${Constantes.caudices}$i.txt'))) {
        obs.add(
            Obstructionum.fromJson(json.decode(line) as Map<String, dynamic>));
      }
    }
    return obs;
  }

  static Future<bool> gladiatorSpiritus(
      bool primis, String gladiatorId, Directory dir) async {
    List<Obstructionum> obs = await getBlocks(dir);
    List<GladiatorInput?> gis = obs
        .map((o) => o.interioreObstructionum.gladiator.interioreGladiator.input)
        .toList();
    if (gis.any(
        (g) => g?.gladiatorIdentitatis == gladiatorId && g?.primis == primis)) {
      return false;
    }
    return true;
  }

  static Future<bool> gladiatorConfodiantur(
      String gladiatorId, String publicaClavis, List<Obstructionum> lo) async {
    Obstructionum obsGladiator = lo.singleWhere((swo) =>
        swo.interioreObstructionum.gladiator.interioreGladiator.identitatis ==
        gladiatorId);
    Gladiator gladiator = obsGladiator.interioreObstructionum.gladiator;
    return gladiator.interioreGladiator.outputs.any((o) => o.rationibus
        .any((r) => r.interiorePropter.publicaClavis == publicaClavis));
  }

  static Future<Gladiator?> grabGladiator(
      String gladiatorIdentitatis, List<Obstructionum> lo) async {
    return lo.singleWhereOrNull((obs) =>
                obs.interioreObstructionum.gladiator.interioreGladiator
                    .identitatis ==
                gladiatorIdentitatis) !=
            null
        ? lo
            .singleWhere((obs) =>
                obs.interioreObstructionum.gladiator.interioreGladiator
                    .identitatis ==
                gladiatorIdentitatis)
            .interioreObstructionum
            .gladiator
        : null;
  }

  static Future<BigInt> accipereForumCap(List<Obstructionum> lo) async {
    final obstructionumPraemium = lo
        .where((obs) =>
            obs.interioreObstructionum.generare == Generare.incipio ||
            obs.interioreObstructionum.generare == Generare.efectus)
        .length;
    return (BigInt.parse(obstructionumPraemium.toString()) *
        Constantes.obstructionumPraemium);
  }

  static Future<BigInt> accipereForumCapLiberFixum(
      bool liber, List<Obstructionum> lo) async {
    List<Tuple3<int, String, TransactioOutput>> outputs = [];
    List<TransactioInput> initibus = [];
    List<Transactio> txs = [];
    for (Obstructionum o in lo) {
      txs.addAll(liber
          ? o.interioreObstructionum.liberTransactions
          : o.interioreObstructionum.fixumTransactions);
    }
    Iterable<List<TransactioInput>> initibuses =
        txs.map((tx) => tx.interioreTransactio.inputs);
    for (List<TransactioInput> init in initibuses) {
      initibus.addAll(init);
    }
    for (Transactio tx in txs) {
      for (int t = 0; t < tx.interioreTransactio.outputs.length; t++) {
        outputs.add(Tuple3<int, String, TransactioOutput>(
            t,
            tx.interioreTransactio.identitatis,
            tx.interioreTransactio.outputs[t]));
      }
    }
    outputs.removeWhere((output) => initibus.any((init) =>
        init.transactioIdentitatis == output.item2 &&
        init.index == output.item1));
    BigInt forumCap = BigInt.zero;
    for (TransactioOutput output in outputs.map((output) => output.item3)) {
      forumCap += output.pod;
    }
    return forumCap;
  }

  static bool estNovamNodi(Directory directorium, Obstructionum obs) {
    return directorium.listSync().isEmpty &&
        obs.interioreObstructionum.generare == Generare.incipio;
  }

  static QuidFacere fortiorEst(
      InterioreObstructionum advenientis, Obstructionum nostrum) {
    print(advenientis.summaObstructionumDifficultas);
    print(nostrum.interioreObstructionum.summaObstructionumDifficultas);
    if (advenientis.priorProbationem == nostrum.probationem) {
      if (advenientis.summaObstructionumDifficultas >
          nostrum.interioreObstructionum.summaObstructionumDifficultas) {
        return QuidFacere.solitum;
      } else {
        return QuidFacere.corrupt;
      }
    }
    if (advenientis.divisa < nostrum.interioreObstructionum.divisa) {
      return QuidFacere.subter;
    }
    return QuidFacere.solitum;
    // todo je kan ook achterlopen
  }

  static Future<Corrumpo> estVerum(
      InterioreObstructionum adventientis, List<Obstructionum> lo) async {
    if (adventientis.forumCap != await Obstructionum.accipereForumCap(lo)) {
      return Corrumpo.forumCap;
    } else if (adventientis.summaObstructionumDifficultas !=
        await Obstructionum.utSummaDifficultas(lo)) {
      return Corrumpo.summaDifficultas;
    } else if (adventientis.obstructionumNumerus !=
        await Obstructionum.utObstructionumNumerus(lo.last)) {
    } else {
      BigInt nuschum = await Obstructionum.numeruo(
          await Obstructionum.utObstructionumNumerus(lo.last));
      if (adventientis.divisa !=
          (nuschum / await Obstructionum.utSummaDifficultas(lo))) {
        return Corrumpo.divisa;
      }
    }
    return Corrumpo.legalis;
  }

  static bool nonFortum(List<Transactio> transactions) {
    for (Transactio transactio in transactions) {
      if (!transactio.isFurantur() && !transactio.validateProbationem()) {
        return false;
      }
    }
    return true;
  }

  Future<bool> validatePraemium(Obstructionum incipio) async {
    if (interioreObstructionum.fixumTransactions.any((ft) =>
        ft.interioreTransactio.transactioSignificatio ==
        TransactioSignificatio.praemium)) {
      print('idkone');
      return false;
    }
    if (interioreObstructionum.liberTransactions
            .where((wlt) =>
                wlt.interioreTransactio.transactioSignificatio ==
                TransactioSignificatio.praemium)
            .length >
        1) {
      print('idktwo');
      return false;
    }
    Transactio t = interioreObstructionum.liberTransactions.singleWhere(
        (swlt) =>
            swlt.interioreTransactio.transactioSignificatio ==
            TransactioSignificatio.praemium);
    if (t.interioreTransactio.outputs.length > 1) {
      print('idkthree');
      return false;
    }
    return t.interioreTransactio.outputs[0].pod ==
        incipio.interioreObstructionum.liberTransactions
            .singleWhere((swlt) =>
                swlt.interioreTransactio.transactioSignificatio ==
                TransactioSignificatio.praemium)
            .interioreTransactio
            .outputs[0]
            .pod;
  }

  static Future removereUsqueAd(String donec, Directory directorium) async {
    List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
    Obstructionum hNostrum = obss.last;
    Obstructionum adventientis =
        obss.singleWhere((obs) => obs.probationem == donec);
    if (hNostrum.interioreObstructionum.obstructionumNumerus.length ==
        adventientis.interioreObstructionum.obstructionumNumerus.length) {
      for (int i = 0;
          i < hNostrum.interioreObstructionum.obstructionumNumerus.last;
          i++) {
        if (i !=
            adventientis.interioreObstructionum.obstructionumNumerus.last) {
          continue;
        }
        File f = File('${directorium.path}${Constantes.caudices}$i.txt');
        List<String> ss = await Utils.fileAmnis(f).toList();
        ss.removeRange(
            i, hNostrum.interioreObstructionum.obstructionumNumerus.last);
        f.deleteSync();
        var sink = f.openWrite(mode: FileMode.append);
        for (String jobs in ss) {
          sink.write('$jobs\n');
        }
        sink.close();
      }
    } else {
      for (int i =
              adventientis.interioreObstructionum.obstructionumNumerus.length;
          i > hNostrum.interioreObstructionum.obstructionumNumerus.length;
          i--) {
        File f = File('${directorium.path}${Constantes.caudices}$i.txt');
        f.deleteSync();
        List<String> ss = await Utils.fileAmnis(f).toList();
        var sink = f.openWrite(mode: FileMode.append);
        for (String jobs in ss) {
          sink.write('$jobs\n');
        }
        sink.close();
      }
    }
  }

  InFieriObstructionum inFieriObstructionum() {
    List<String> gladiatorIdentitatum = [];
    interioreObstructionum.gladiator.interioreGladiator.outputs
        .map((go) => go.rationibus.map((gr) => gr.interiorePropter.identitatis))
        .forEach(gladiatorIdentitatum.addAll);
    List<String> lt = interioreObstructionum.liberTransactions
        .map((lt) => lt.interioreTransactio.identitatis)
        .toList();
    List<String> ft = interioreObstructionum.fixumTransactions
        .map((ft) => ft.interioreTransactio.identitatis)
        .toList();
    List<String> et = interioreObstructionum.expressiTransactions
        .map((et) => et.interioreTransactio.identitatis)
        .toList();
    List<String> cles = interioreObstructionum.connexaLiberExpressis
        .map((cle) => cle.interioreConnexaLiberExpressi.identitatis)
        .toList();
    return InFieriObstructionum(gladiatorIdentitatum, lt, ft, et, cles);
  }

  Future<bool> convalidandumTransform(List<Obstructionum> lo) async {
    List<TransactioInput> lti = [];
    interioreObstructionum.liberTransactions
        .where((wlt) =>
            wlt.interioreTransactio.transactioSignificatio ==
            TransactioSignificatio.transform)
        .map((mlt) => mlt.interioreTransactio.inputs)
        .forEach(lti.addAll);
    List<TransactioOutput> lto = [];
    interioreObstructionum.fixumTransactions
        .where((wlf) =>
            wlf.interioreTransactio.transactioSignificatio ==
            TransactioSignificatio.transform)
        .map((mft) => mft.interioreTransactio.outputs)
        .forEach(lto.addAll);
    List<String> identitatum = [];
    lti.map((mlt) => mlt.transactioIdentitatis).forEach(identitatum.add);
    List<Transactio> ltop = [];
    lo.map((mlo) => mlo.interioreObstructionum.liberTransactions
        .where((wlt) => identitatum.any((identitatis) => identitatis == wlt.interioreTransactio.identitatis)))
        .forEach(ltop.addAll);
    List<TransactioOutput> rlt = [];
    ltop.map((mltop) => mltop.interioreTransactio.outputs).forEach(rlt.addAll);
    BigInt fixum = BigInt.zero;
    for (TransactioOutput to in lto) {
      fixum += to.pod;
    }
    BigInt rfixum = BigInt.zero;
    for (TransactioOutput to in rlt) {
      rfixum += to.pod;
    }
    print('fixum $fixum and $rfixum');
    return fixum == rfixum;
  }

  Future<bool> vicit(List<Obstructionum> lo) async {
    GladiatorInput? gi =
        interioreObstructionum.gladiator.interioreGladiator.input;
    if (gi == null) {
      Print.nota(
          nuntius: 'Obstructionum gladiatorem sine input',
          message:
              'Block can not have defeaten a gladiator without a gladiator input');
      return false;
    }
    Obstructionum swo = lo.singleWhere((swo) =>
        swo.interioreObstructionum.gladiator.interioreGladiator.identitatis ==
        gi.gladiatorIdentitatis);

    String victimGladiatorIdentitatis =
        swo.interioreObstructionum.gladiator.interioreGladiator.identitatis;
    String inimicusImpetumBasis = await Pera.turpiaGladiatoriaTelum(
        gi.primis, true, gi.gladiatorIdentitatis, lo);
    List<Telum> inimicusImpetusLiber = await Pera.maximeArma(
        true, gi.primis, true, gi.gladiatorIdentitatis, lo);
    List<Telum> inimicusImpetusFixum = await Pera.maximeArma(
        false, gi.primis, true, gi.gladiatorIdentitatis, lo);
    List<String> inimicusImpetus = [inimicusImpetumBasis];
    inimicusImpetusLiber.map((miil) => miil.telum).forEach(inimicusImpetus.add);
    inimicusImpetusFixum.map((miif) => miif.telum).forEach(inimicusImpetus.add);

    String victimaDefensioBasis = await Pera.turpiaGladiatoriaTelum(
        gi.primis, false, victimGladiatorIdentitatis, lo);
    List<Telum> victimaDefensioLiber = await Pera.maximeArma(
        true, gi.primis, false, victimGladiatorIdentitatis, lo);
    List<Telum> victimaDefensioFixum = await Pera.maximeArma(
        false, gi.primis, false, victimGladiatorIdentitatis, lo);
    List<String> victimaDefensiones = [victimaDefensioBasis];
    victimaDefensioLiber
        .map((mvdl) => mvdl.telum)
        .forEach(victimaDefensiones.add);
    victimaDefensioFixum
        .map((mvdf) => mvdf.telum)
        .forEach(victimaDefensiones.add);
    List<String> requiritur = victimaDefensiones;
    requiritur.removeWhere((rwr) => inimicusImpetus.any((aii) => aii == rwr));
    if (!requiritur.every((er) => probationem.contains(er))) {
      return false;
    }
    GladiatorOutput go = swo.interioreObstructionum.gladiator.interioreGladiator
        .outputs[gi.primis ? 0 : 1];
    if (!Utils.cognoscereVictusGladiator(
        PublicKey.fromHex(Pera.curve(), interioreObstructionum.producentis),
        Signature.fromASN1Hex(gi.signature),
        go)) {
      return false;
    }
    return true;
  }

  static BigInt confirmationes(List<int> from, List<int> to) {
    if (from.length == to.length) {}
    BigInt counter = BigInt.zero;
    while (to.length != from.length) {
      counter += BigInt.parse(
          ((Constantes.maximeCaudicesFile + 1) - from.last).toString());
      from.add(0);
    }
    counter += BigInt.parse((to.last - from.last).toString());
    return counter;
  }

  Future<bool> convalidandumObsturcutionumNumerus(
      Obstructionum incipio, Obstructionum prioro) async {
    for (int i = 0;
        i > prioro.interioreObstructionum.obstructionumNumerus.length;
        i++) {
      if (interioreObstructionum.obstructionumNumerus.any((eon) =>
          eon > incipio.interioreObstructionum.numeruCuneosMaximumsOrdinata!)) {
        return false;
      }
      if (!interioreObstructionum.obstructionumNumerus.every((eon) =>
          eon <=
          incipio.interioreObstructionum.numeruCuneosMaximumsOrdinata!)) {
        return false;
      }
    }
    return true;
  }

  static Future removereUltimumObstructionum(Directory directorium) async {
    Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
    if (prioro.interioreObstructionum.obstructionumNumerus
        .any((aon) => aon == 0)) {
      File('${directorium.path}/${Constantes.caudices}${prioro.interioreObstructionum.obstructionumNumerus.length - 1}.txt')
          .deleteSync();
    } else {
      File f = File(
          '${directorium.path}/${Constantes.caudices}${directorium.listSync().length - 1}.txt');
      List<String> os = await Utils.fileAmnis(f).toList();
      os.removeLast();
      f.deleteSync();
      var s = f.openWrite(mode: FileMode.append);
      for (String o in os) {
        s.write('$o\n');
      }
      s.close();
    }
  }

  // bool victusEst() {
  //   GladiatorInput? gi =
  //       interioreObstructionum.gladiator.interioreGladiator.input;
  //   if (gi == null) {
  //     throw BadRequest(
  //         code: 0,
  //         nuntius: 'Gladiator non inveni',
  //         message: 'Gladiator not found');
  //   }
  // }
}
