import 'package:tuple/tuple.dart';
import '../exempla/transactio.dart';
import '../exempla/utils.dart';
import 'dart:io';
import '../exempla/obstructionum.dart';
import 'dart:convert';
import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
import '../exempla/constantes.dart';
import '../exempla/gladiator.dart';
import '../exempla/errors.dart';
import 'obstructionum_arma.dart';
import 'responsio/gladiator_arma.dart';
import 'solucionis_propter.dart';
import 'telum.dart';
import 'package:collection/collection.dart';

import 'telum_exemplar.dart';

class Pera {
  static EllipticCurve curve() => getP256();

  static BigInt habetBid(bool liber, String publica, List<Obstructionum> lo) {
    List<String> probationems = lo.map((mo) => mo.probationem).toList();
    List<Transactio> lt = [];
    lo.map((mo) => liber ? mo.interioreObstructionum.liberTransactions.where((wlt) => wlt.interioreTransactio.outputs.any((ao) => probationems.contains(ao.publicaClavis))) : mo.interioreObstructionum.fixumTransactions.where((wlt) => wlt.interioreTransactio.outputs.any((ao) => probationems.contains(ao.publicaClavis)))).forEach(lt.addAll);
    List<TransactioInput> lti = [];
    lt.map((mlt) => mlt.interioreTransactio.inputs).forEach(lti.addAll);
    // List<TransactioOutput> lto = [];
    List<Transactio> ltp = [];
    for (TransactioInput ti in lti) {
      List<Transactio> flt = [];
      lo.map((mo) => liber ? mo.interioreObstructionum.liberTransactions.where((wo) => wo.interioreTransactio.identitatis == ti.transactioIdentitatis) : mo.interioreObstructionum.fixumTransactions.where((wo) => wo.interioreTransactio.identitatis == ti.transactioIdentitatis)).forEach(flt.addAll); 
      for (Transactio t in flt) {
        if (Utils.cognoscere(PublicKey.fromHex(Pera.curve(), publica), Signature.fromASN1Hex(ti.signature), t.interioreTransactio.outputs[ti.index])) {          
          ltp.add(lt.singleWhere((swt) => swt.interioreTransactio.inputs.contains(ti)));
        }
      }
    }
    BigInt persoluta = BigInt.zero;
    for (Transactio t in ltp) {
      for (TransactioOutput to in t.interioreTransactio.outputs.where((wo) => probationems.contains(wo.publicaClavis))) {
        persoluta += to.pod;
      } 
    }
    return persoluta;
  }
  static Future<String> turpiaGladiatoriaTelum(bool primis, bool impetum,
      String gladiatorIdentitatis, List<Obstructionum> lo) async {
    List<Gladiator> lg = [];
    lo.map((mo) => mo.interioreObstructionum.gladiator).forEach(lg.add);
    Gladiator g = lg.singleWhere(
        (swg) => swg.interioreGladiator.identitatis == gladiatorIdentitatis);
    GladiatorOutput go = g.interioreGladiator.outputs[primis ? 0 : 1];
    return impetum ? go.impetum : go.defensio;
  }

  static Future<bool> isProbationum(
      String probationum, List<Obstructionum> lo) async {
    List<String> obs = [];
    lo.map((mo) => mo.probationem).forEach(obs.add);
    if (obs.contains(probationum)) return true;
    return false;
  }

  static Future<bool> isPublicaClavisDefended(
      String publicaClavis, List<Obstructionum> lo) async {
    List<GladiatorOutput> gladiatorOutputs =
        await Obstructionum.utDifficultas(lo);
    for (List<Propter> propters in gladiatorOutputs.map((g) => g.rationibus)) {
      for (Propter propter in propters) {
        if (propter.interiorePropter.publicaClavis == publicaClavis) {
          return true;
        }
      }
    }
    return false;
  }

  static Future<ObstructionumArma> obstructionumArma(
      String probationem, List<Obstructionum> lo) async {
    for (Obstructionum o in lo) {
      if (o.probationem == probationem) {
        return ObstructionumArma(o.interioreObstructionum.defensio!,
            o.interioreObstructionum.impetum!);
      }
    }
    throw BadRequest(
        code: 0, nuntius: 'probationem non inveni', message: 'proof not found');
  }

  static Future<BigInt> tuusIubeoObstructionumTelum(bool liber, bool primis,
      String probationem, List<Obstructionum> lo) async {
    String gladiatorIdentitatis = lo
        .singleWhere((obs) => obs.probationem == probationem)
        .interioreObstructionum
        .gladiator
        .interioreGladiator
        .identitatis;
    Map<String, BigInt> bid =
        await arma(liber, primis, gladiatorIdentitatis, lo);
    for (String key in bid.keys) {
      if (key == probationem) {
        return bid[key] ?? BigInt.zero;
      }
    }
    return BigInt.zero;
  }

  static Future<BigInt> summaBid(
      String probationem, List<Obstructionum> lo) async {
    List<Map<String, BigInt>> maschaps = [];
    List<String> gladiatorIds = [];
    for (Obstructionum o in lo) {
      gladiatorIds.add(
          o.interioreObstructionum.gladiator.interioreGladiator.identitatis);
    }
    // we have to call arma 4 times to get rid of primis and liber
    // for (String gid in gladiatorIds) {
    //   maschaps.add(await arma(liber, primis, gid, directory));
    //   maschaps.add(await arma(liber, primis, gid, directory));
    // }
    for (String gid in gladiatorIds) {
      maschaps.add(await arma(true, true, gid, lo));
      maschaps.add(await arma(false, true, gid, lo));
      maschaps.add(await arma(true, false, gid, lo));
      maschaps.add(await arma(false, true, gid, lo));
    }
    BigInt highestBid = BigInt.zero;
    for (Map<String, BigInt> maschap in maschaps) {
      for (String key in maschap.keys.where((k) => k == probationem)) {
        if ((maschap[key] ??= BigInt.zero) >= highestBid) {
          highestBid = maschap[key] ?? BigInt.zero;
        }
      }
    }
    return highestBid;
  }

  static Future<List<Telum>> maximeArma(bool liber, bool primis, bool impetum,
      String gladiatorId, List<Obstructionum> lo) async {
    List<Telum> def = [];
    Map<String, BigInt> ours = Map();
    List<Map<String, BigInt>> others = [];
    List<Obstructionum> obss = [];
    for (Obstructionum o in lo) {
      obss.add(o);
      if (o.interioreObstructionum.gladiator.interioreGladiator.identitatis ==
          gladiatorId) {
        ours = await arma(liber, primis, gladiatorId, lo);
      } else {
        others.add(await arma(
            liber,
            primis,
            o.interioreObstructionum.gladiator.interioreGladiator.identitatis,
            lo));
      }
    }
    Map<String, bool> payedMore = Map();
    for (String key in ours.keys) {
      if (others.any((o) => o.keys.contains(key))) {
        for (Map<String, BigInt> other
            in others.where((e) => e.keys.contains(key))) {
          if ((ours[key] ??= BigInt.zero) > (other[key] ??= BigInt.zero)) {
            payedMore[key] = true;
          }
        }
      } else {
        payedMore[key] = true;
      }
    }
    for (String key in payedMore.keys) {
      def.add(Telum(
          impetum
              ? obss
                  .singleWhere((obs) => obs.probationem == key)
                  .interioreObstructionum
                  .impetum!
              : obss
                  .singleWhere((obs) => obs.probationem == key)
                  .interioreObstructionum
                  .defensio!,
          key,
          impetum ? TelumExemplar.impetum : TelumExemplar.defensio,
          await Pera.tuusIubeoObstructionumTelum(liber, primis, key, lo)));
    }
    return def;
  }

  static Future<Map<String, BigInt>> arma(bool liber, bool primis,
      String gladiatorId, List<Obstructionum> lo) async {
    List<Obstructionum> obstructionums = [];
    List<String> publicaClavises = [];
    List<String> probationums = [];
    for (Obstructionum o in lo) {
      probationums.add(o.probationem);
      if (o.interioreObstructionum.gladiator.interioreGladiator.identitatis ==
          gladiatorId) {
        if (o.interioreObstructionum.generare == Generare.efectus) {
          publicaClavises.addAll(o.interioreObstructionum.gladiator
              .interioreGladiator.outputs[primis ? 0 : 1].rationibus
              .map((r) => r.interiorePropter.publicaClavis));
        } else if (o.interioreObstructionum.generare == Generare.incipio) {
          publicaClavises.addAll(o.interioreObstructionum.gladiator
              .interioreGladiator.outputs[0].rationibus
              .map((r) => r.interiorePropter.publicaClavis));
        }
      }
    }

    for (Obstructionum obs in obstructionums) {}
    List<TransactioInput> toDerive = [];
    List<Transactio> txsWithOutput = [];
    for (Iterable<Transactio> obs in obstructionums.map((o) => liber
        ? o.interioreObstructionum.liberTransactions
        : o.interioreObstructionum.fixumTransactions.where((e) => e
            .interioreTransactio.outputs
            .any((oschout) => probationums.contains(oschout.publicaClavis))))) {
      obs.map((e) => e.interioreTransactio.inputs).forEach(toDerive.addAll);
      txsWithOutput.addAll(obs);
    }
    List<String> transactionIds =
        toDerive.map((to) => to.transactioIdentitatis).toList();
    List<TransactioOutput> outputs = [];
    for (Iterable<Transactio> obs in obstructionums
        .map((o) => liber
            ? o.interioreObstructionum.liberTransactions
            : o.interioreObstructionum.fixumTransactions)
        .toList()) {
      obs
          .where(
              (e) => transactionIds.contains(e.interioreTransactio.identitatis))
          .map((tx) => tx.interioreTransactio.outputs)
          .forEach(outputs.addAll);
    }
    Map<String, BigInt> maschap = Map();
    for (TransactioOutput oschout in outputs
        .where((oschout) => publicaClavises.contains(oschout.publicaClavis))) {
      for (Transactio tx in txsWithOutput) {
        for (TransactioInput ischin in tx.interioreTransactio.inputs) {
          if (Utils.cognoscere(
              PublicKey.fromHex(Pera.curve(), oschout.publicaClavis),
              Signature.fromASN1Hex(ischin.signature),
              oschout)) {
            for (TransactioOutput oschoutoschout
                in tx.interioreTransactio.outputs.where((element) =>
                    probationums.contains(element.publicaClavis))) {
              BigInt prevValue =
                  maschap[oschoutoschout.publicaClavis] ?? BigInt.zero;
              maschap[oschoutoschout.publicaClavis] =
                  prevValue + oschoutoschout.pod;
            }
          }
        }
      }
    }
    return maschap;
  }

  //left off
  static Future<Tuple2<InterioreTransactio?, InterioreTransactio?>>
      transformFixum(String privatus, List<Transactio> txs,
          List<Obstructionum> lo) async {
    String publica =
        PrivateKey.fromHex(Pera.curve(), privatus).publicKey.toHex();
    List<Tuple3<int, String, TransactioOutput>> outs =
        await inconsumptusOutputs(true, publica, lo);
    for (Transactio tx
        in txs) {
      outs.removeWhere((element) => tx.interioreTransactio.inputs
          .any((ischin) => ischin.transactioIdentitatis == element.item2));
      for (int i = 0; i < tx.interioreTransactio.outputs.length; i++) {
        PrivateKey pk = PrivateKey.fromHex(Pera.curve(), privatus);
        if (tx.interioreTransactio.outputs[i].publicaClavis ==
            pk.publicKey.toHex()) {
          outs.add(Tuple3<int, String, TransactioOutput>(
              i,
              tx.interioreTransactio.identitatis,
              tx.interioreTransactio.outputs[i]));
        }
      }
    }
    if (outs.isEmpty) {
      return Tuple2(null, null);
    }
    List<TransactioOutput> outputs = [];
    List<TransactioInput> inputs = [];
    for (Tuple3<int, String, TransactioOutput> out in outs) {
      outputs.add(TransactioOutput(publica, out.item3.pod));
      inputs.add(TransactioInput(
          out.item1,
          Utils.signum(PrivateKey.fromHex(Pera.curve(), privatus), out.item3),
          out.item2));
    }
    return Tuple2<InterioreTransactio, InterioreTransactio>(
        InterioreTransactio.transform(liber: true, dominus: publica, inputs: inputs, outputs: []),
        InterioreTransactio.transform(
            liber: false, dominus: publica, inputs: [], outputs: outputs));
  }

  static Future<List<Tuple3<int, String, TransactioOutput>>>
      inconsumptusOutputs(
          bool liber, String publicKey, List<Obstructionum> lo) async {
    List<Tuple3<int, String, TransactioOutput>> outputs = [];
    List<Transactio> txs = [];
    lo.map((mo) => liber ? mo.interioreObstructionum.liberTransactions : mo.interioreObstructionum.fixumTransactions).forEach(txs.addAll);
    List<TransactioInput> lti = [];
    txs.map((tx) => tx.interioreTransactio.inputs).forEach(lti.addAll);
    for (Transactio tx in txs.where((tx) => tx.interioreTransactio.outputs.any((e) => e.publicaClavis == publicKey))) {
      for (int t = 0; t < tx.interioreTransactio.outputs.length; t++) {
        if (tx.interioreTransactio.outputs[t].publicaClavis == publicKey) {
          outputs.add(Tuple3<int, String, TransactioOutput>(
              t,
              tx.interioreTransactio.identitatis,
              tx.interioreTransactio.outputs[t]));
        }
      }
    }
    outputs.removeWhere((output) => lti.any((init) =>
        init.transactioIdentitatis == output.item2 &&
        init.index == output.item1));
    print('inconsumptus chrono ${outputs.map((e) => e.item3.toJson())}');
    return outputs;
  }

  static Future<BigInt> acccipereForumCap(
      bool liber, Directory directory) async {
    List<Tuple3<int, String, TransactioOutput>> outputs = [];
    List<TransactioInput> initibus = [];
    List<Transactio> txs = [];
    for (int i = 0; i < directory.listSync().length; i++) {
      await for (var line in Utils.fileAmnis(
          File('${directory.path}${Constantes.caudices}$i.txt'))) {
        txs.addAll(liber
            ? Obstructionum.fromJson(json.decode(line) as Map<String, dynamic>)
                .interioreObstructionum
                .liberTransactions
            : Obstructionum.fromJson(json.decode(line) as Map<String, dynamic>)
                .interioreObstructionum
                .fixumTransactions);
      }
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

  static Future<BigInt> statera(
      bool liber, String publicKey, List<Obstructionum> lo) async {
    List<Tuple3<int, String, TransactioOutput>> outputs =
        await inconsumptusOutputs(liber, publicKey, lo);
    BigInt balance = BigInt.zero;
    for (Tuple3<int, String, TransactioOutput> inOut in outputs) {
      print(inOut.item3.pod);
      balance += inOut.item3.pod;
    }
    return balance;
  }

  static Future<InterioreTransactio?> perdita(PrivateKey privatus, String publica,
      String probationum, List<Transactio> lt, List<Obstructionum> lo) async {
    print('ispublicathesameasprivate $publica and ${privatus.publicKey.toHex()}');
    List<Tuple3<int, String, TransactioOutput>> outs =
        await inconsumptusOutputs(true, publica, lo);
    for (Transactio tx in lt
        .where((t) => t.interioreTransactio.liber)) {
      outs.removeWhere((element) => tx.interioreTransactio.inputs
          .any((ischin) => ischin.transactioIdentitatis == element.item2));
      for (int i = 0; i < tx.interioreTransactio.outputs.length; i++) {
        if (tx.interioreTransactio.outputs[i].publicaClavis == publica) {
         outs.add(Tuple3<int, String, TransactioOutput>(
              i,
              tx.interioreTransactio.identitatis,
              tx.interioreTransactio.outputs[i]));
        }
      }
    }
    BigInt value = BigInt.zero;
    for (Tuple3<int, String, TransactioOutput> out in outs) {
      value += out.item3.pod;
    }
    if (value == BigInt.zero) {
      return null;
    }
    return calculateTransaction(
        necessitudo: false,
        liber: true,
        twice: false,
        ts: TransactioSignificatio.perdita,
        privatus: privatus,
        to: probationum,
        value: value,
        outs: outs);
  }

  static Future<InterioreTransactio> novamExpressi({ required String ex, required String to, required BigInt value, required Transactio regularis}) async {
    List<Tuple3<int, String, TransactioOutput>> tissto = [];
    for (int i = 0; i < regularis.interioreTransactio.outputs.length; i++) {
      if (regularis.interioreTransactio.outputs[i].publicaClavis == PrivateKey.fromHex(Pera.curve(), ex).publicKey.toHex()) {
        tissto.add(Tuple3(i, regularis.interioreTransactio.identitatis, regularis.interioreTransactio.outputs[i]));
      }
    } 
    return calculateTransaction(necessitudo: false, liber: true, twice: false, ts: TransactioSignificatio.expressi, privatus: PrivateKey.fromHex(Pera.curve(), ex), to: to, value: value, outs: tissto);
  }
  static Future<InterioreTransactio> novamRem(
      {required bool necessitudo,
      required bool liber,
      required bool twice,
      required TransactioSignificatio ts,
      required String ex,
      required BigInt value,
      required String to,
      required List<Transactio> transactioStagnum,
      required List<Obstructionum> lo}) async {
    PrivateKey privatusClavis = PrivateKey.fromHex(Pera.curve(), ex);
    List<Tuple3<int, String, TransactioOutput>> inOuts =
        await inconsumptusOutputs(liber, privatusClavis.publicKey.toHex(), lo);
    for (Transactio tx in transactioStagnum
        .where((t) => t.interioreTransactio.liber == liber)) {
      inOuts.removeWhere((element) => tx.interioreTransactio.inputs
          .any((ischin) => ischin.transactioIdentitatis == element.item2));
      for (int i = 0; i < tx.interioreTransactio.outputs.length; i++) {
        if (tx.interioreTransactio.outputs[i].publicaClavis ==
            privatusClavis.publicKey.toHex()) {
          inOuts.add(Tuple3<int, String, TransactioOutput>(
              i,
              tx.interioreTransactio.identitatis,
              tx.interioreTransactio.outputs[i]));
        }
      }
    }
    return calculateTransaction(
        necessitudo: necessitudo,
        liber: liber,
        twice: twice,
        ts: ts,
        privatus: privatusClavis,
        to: to,
        value: value,
        outs: inOuts);
  }

  static InterioreTransactio calculateTransaction(
      {required bool necessitudo,
      required bool liber,
      required bool twice,
      required TransactioSignificatio ts,
      required PrivateKey privatus,
      required String to,
      required BigInt value,
      required List<Tuple3<int, String, TransactioOutput>> outs}) {
    BigInt balance = BigInt.zero;
    for (Tuple3<int, String, TransactioOutput> inOut in outs) {
      balance += inOut.item3.pod;
    }
    if (twice ? (balance < (value * BigInt.two)) : (balance < value)) {
      throw BadRequest(
          code: 1, nuntius: "Satis pecunia", message: "Insufficient funds");
    }
    BigInt implere = value;
    List<TransactioInput> inputs = [];
    List<TransactioOutput> outputs = [];
    for (Tuple3<int, String, TransactioOutput> inOut in outs) {
      inputs.add(TransactioInput(
          inOut.item1, Utils.signum(privatus, inOut.item3), inOut.item2));
      if (inOut.item3.pod < implere) {
        outputs.add(TransactioOutput(to, inOut.item3.pod));
        implere -= inOut.item3.pod;
      } else if (inOut.item3.pod > implere) {
        outputs.add(TransactioOutput(to, implere));
        outputs.add(TransactioOutput(
            privatus.publicKey.toHex(), inOut.item3.pod - implere));
        break;
      } else {
        outputs.add(TransactioOutput(to, implere));
        break;
      }
    }
    String identitatis = Utils.randomHex(64);
    String ex = privatus.toHex();
    return InterioreTransactio(
        ex: ex,
        liber: liber,
        identitatis: identitatis,
        dominus: PrivateKey.fromHex(Pera.curve(), ex).publicKey.toHex(),
        transactioSignificatio: ts,
        inputs: inputs,
        outputs: outputs,
        sr: necessitudo
            ? SiRemotionem.summitto(InterioreSiRemotionem.output(
                ex,
                SiRemotionemOutput(
                    liber, to, privatus.publicKey.toHex(), identitatis, value)))
            : null);
  }

  static Future<bool> isPrimis(
      String propterIdentitatis, Directory directory) async {
    List<Obstructionum> obs = await Obstructionum.getBlocks(directory);
    List<GladiatorOutput> gos = [];
    obs
        .map((ob) =>
            ob.interioreObstructionum.gladiator.interioreGladiator.outputs)
        .forEach(gos.addAll);
    List<Propter> ps = [];
    gos.map((go) => go.rationibus).forEach(ps.addAll);
    GladiatorOutput go = gos.singleWhere((go) => go.rationibus.any((propter) =>
        propter.interiorePropter.identitatis == propterIdentitatis));
    Obstructionum tobs = obs.singleWhere((tob) => tob
        .interioreObstructionum.gladiator.interioreGladiator.outputs
        .contains(go));
    return tobs.interioreObstructionum.gladiator.interioreGladiator.outputs
        .contains(go);
  }

  static Future<String> accipereGladiatorIdentitatis(
      String propterIdentitatis, Directory directorium) async {
    List<Obstructionum> os = await Obstructionum.getBlocks(directorium);
    List<Gladiator> gs = [];
    os.map((o) => o.interioreObstructionum.gladiator).forEach(gs.add);
    List<GladiatorOutput> gos = [];
    gs.map((mg) => mg.interioreGladiator.outputs).forEach(gos.addAll);
    List<Propter> ps = [];
    gos.map((mgo) => mgo.rationibus).forEach(ps.addAll);
    Propter p = ps.singleWhere(
        (swp) => swp.interiorePropter.identitatis == propterIdentitatis);
    Gladiator g = gs.singleWhere((swg) => swg.interioreGladiator.outputs
        .any((swgo) => swgo.rationibus.contains(p)));
    return g.interioreGladiator.identitatis;
  }

}
