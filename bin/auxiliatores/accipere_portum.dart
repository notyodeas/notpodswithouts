import 'dart:io';
import 'dart:isolate';

import 'package:elliptic/elliptic.dart';
import '../connect/par_ad_rimor.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/telum.dart';
import '../exempla/transactio.dart';
import '../exempla/utils.dart';
import '../connect/pervideas_to_pervideas.dart';
import 'package:tuple/tuple.dart';

import '../exempla/constantes.dart';
import 'package:collection/collection.dart';
import '../itineribus/obstructionum_iter.dart';
import '../server.dart';

class AcciperePortum {
  static Future efectus(ParAdRimor par) async {
    Directory directory =
        Directory('vincula/${argumentis!.obstructionumDirectorium}');
    List<Obstructionum> lo = await Obstructionum.getBlocks(directory)
    ReceivePort acciperePortus = ReceivePort();
    List<Propter> propters = [];
    propters.addAll(InterioreGladiator.grab(par.rationibus));
    List<Transactio> liberTxs = [];
    liberTxs.add(Transactio.praemium(argumentis!.publicaClavis));
    liberTxs.addAll(Transactio.grab(par.liberTransactions
        .where((lt) => lt.interioreTransactio. == true)));
    List<Transactio> fixumTxs = [];
    fixumTxs.addAll(Transactio.grab(par.fixumTransactions));
    List<String> ltum = [];
    liberTxs.map((lt) => lt.interioreTransactio.identitatis).forEach(ltum.add);
    List<ConnexaLiberExpressi> cles = par.invenireConnexaLiberExpressis(ltum);
    List<Transactio> expressiTxs = [];
    for (ConnexaLiberExpressi cle in cles) {
      expressiTxs.add(par.expressiTransactions.singleWhere((et) =>
          et.interioreTransactio.isCle == true &&
          cle.interioreConnexaLiberExpressi.expressiIdentitatis ==
              et.interioreTransactio.identitatis));
    }
    final obstructionumDifficultas =
        await Obstructionum.utDifficultas(directory);
    BigInt numerus = await Obstructionum.numeruo(
        await Obstructionum.utObstructionumNumerus(directory));
    InterioreObstructionum interiore = InterioreObstructionum.efectus(
        obstructionumDifficultas: obstructionumDifficultas.length,
        divisa: (numerus / await Obstructionum.utSummaDifficultas(directory)),
        forumCap: await Obstructionum.accipereForumCap(directory),
        liberForumCap:
            await Obstructionum.accipereForumCapLiberFixum(true, directory),
        fixumForumCap:
            await Obstructionum.accipereForumCapLiberFixum(false, directory),
        summaObstructionumDifficultas:
            await Obstructionum.utSummaDifficultas(directory),
        obstructionumNumerus:
            await Obstructionum.utObstructionumNumerus(directory),
        producentis: argumentis!.publicaClavis,
        priorProbationem: priorObstructionum.probationem,
        gladiator: Gladiator.nullam(InterioreGladiator.efectus(
            outputs: InterioreGladiator.egos(propters))),
        liberTransactions: liberTxs,
        fixumTransactions: fixumTxs,
        expressiTransactions: expressiTxs,
        adRemovendumConnexaLiberExpressis: cles,
        prior: priorObstructionum);
    stamina.efectusThreads.add(await Isolate.spawn(Obstructionum.efectus,
        List<dynamic>.from([interiore, acciperePortus.sendPort])));
    acciperePortus.listen((nuntius) async {
      Obstructionum obstructionum = nuntius as Obstructionum;
      InFieriObstructionum ifo = obstructionum.inFieriObstructionum();
      ifo.gladiatorIdentitatum.forEach((gi) =>
          isolates.propterIsolates[gi]?.kill(priority: Isolate.immediate));
      ifo.liberTransactions.forEach((lt) =>
          isolates.liberTxIsolates[lt]?.kill(priority: Isolate.immediate));
      ifo.fixumTransactions.forEach((ft) =>
          isolates.fixumTxIsolates[ft]?.kill(priority: Isolate.immediate));
      ifo.expressiTransactions.forEach((et) =>
          isolates.expressiTxIsolates[et]?.kill(priority: Isolate.immediate));
      par.removePropters(ifo.gladiatorIdentitatum);
      par.removeLiberTransactions(ifo.liberTransactions);
      par.removeFixumTransactions(ifo.fixumTransactions);
      par.removeExpressiTransactions(ifo.liberTransactions);
      par.removeConnexaLiberExpressis(ifo.connexaLiberExpressis);
      // par.syncBlocks.forEach((e) => e.kill(priority: Isolate.immediate));
      par.syncBlocks.add(await Isolate.spawn(
          ParAdRimor.syncBlock,
          List<dynamic>.from([
            obstructionum,
            par.bases,
            directory,
            '${argumentis!.internumIp}:${argumentis!.pervideasPort}'
          ])));
    });
  }

  static Future confussus(bool primis, String privatusClavis,
      String gladiatorIdentitatis, ParAdRimor par, Directory directory) async {
    Obstructionum priorObstructionum =
        await Utils.priorObstructionum(directory);
    ReceivePort acciperePortus = ReceivePort();
    Gladiator? gladiatorOppugnare =
        await Obstructionum.grabGladiator(gladiatorIdentitatis, directory);
    if (gladiatorOppugnare == null) {
      Isolate.current.kill();
    }
    List<Transactio> fixumTxs = [];
    List<Transactio> liberTxs = [];
    liberTxs = Transactio.grab(par.liberTransactions
        .where((lt) => lt.interioreTransactio.isCle == true));
    for (String acc in gladiatorOppugnare!
        .interioreGladiator.outputs[primis ? 0 : 1].rationibus
        .map((e) => e.interiorePropter.publicaClavis)) {
      final balance = await Pera.statera(true, acc, directory);
      if (balance > BigInt.zero) {
        liberTxs.add(Transactio.burn(await Pera.ardeat(
            PrivateKey.fromHex(Pera.curve(), privatusClavis),
            acc,
            priorObstructionum.probationem,
            balance,
            directory)));
      }
    }
    Tuple2<InterioreTransactio?, InterioreTransactio?> transform =
        await Pera.transformFixum(
            privatusClavis, par.liberTransactions, directory);
    if (transform.item1 != null) {
      liberTxs.add(Transactio.nullam(transform.item1!));
    }
    if (transform.item2 != null) {
      fixumTxs.add(Transactio.nullam(transform.item2!));
    }
    fixumTxs = Transactio.grab(par.fixumTransactions);
    List<String> ltum = [];
    liberTxs.map((lt) => lt.interioreTransactio.identitatis).forEach(ltum.add);
    List<ConnexaLiberExpressi> cles = par.invenireConnexaLiberExpressis(ltum);
    List<Transactio> expressiTxs = [];
    for (ConnexaLiberExpressi cle in cles) {
      expressiTxs.add(par.expressiTransactions.singleWhere((et) =>
          et.interioreTransactio.isCle == true &&
          cle.interioreConnexaLiberExpressi.expressiIdentitatis ==
              et.interioreTransactio.identitatis));
    }
    List<Telum> impetus = [];
    impetus.addAll(await Pera.maximeArma(true, primis, true,
        gladiatorOppugnare.interioreGladiator.identitatis, directory));
    impetus.addAll(await Pera.maximeArma(false, primis, false,
        gladiatorOppugnare.interioreGladiator.identitatis, directory));
    List<Telum> defensiones = [];
    defensiones.addAll(await Pera.maximeArma(true, primis, false,
        gladiatorOppugnare.interioreGladiator.identitatis, directory));
    defensiones.addAll(await Pera.maximeArma(false, primis, false,
        gladiatorOppugnare.interioreGladiator.identitatis, directory));
    List<String> gladii = impetus.map((e) => e.telum).toList();
    List<String> scuta = defensiones.map((e) => e.telum).toList();
    final baseImpetum = await Pera.turpiaGladiatoriaTelum(true, primis,
        gladiatorOppugnare.interioreGladiator.identitatis, directory);
    final baseDefensio = await Pera.turpiaGladiatoriaTelum(false, primis,
        gladiatorOppugnare.interioreGladiator.identitatis, directory);
    gladii.add(baseImpetum.telum);
    scuta.add(baseDefensio.telum);
    scuta.removeWhere((defensio) => gladii.contains(defensio));
    BigInt numerus = await Obstructionum.numeruo(
        await Obstructionum.utObstructionumNumerus(directory));
    final obstructionumDifficultas =
        await Obstructionum.utDifficultas(directory);
    InterioreObstructionum interiore = InterioreObstructionum.confussus(
        obstructionumDifficultas: obstructionumDifficultas.length,
        divisa: (numerus / await Obstructionum.utSummaDifficultas(directory)),
        forumCap: await Obstructionum.accipereForumCap(directory),
        summaObstructionumDifficultas:
            await Obstructionum.utSummaDifficultas(directory),
        obstructionumNumerus:
            await Obstructionum.utObstructionumNumerus(directory),
        liberForumCap:
            await Obstructionum.accipereForumCapLiberFixum(true, directory),
        fixumForumCap:
            await Obstructionum.accipereForumCapLiberFixum(false, directory),
        producentis: argumentis!.publicaClavis,
        priorProbationem: priorObstructionum.probationem,
        gladiator: Gladiator.nullam(InterioreGladiator.ce(
            input: await InterioreGladiator.cegi(
                primis, privatusClavis, gladiatorIdentitatis, directory))),
        liberTransactions: liberTxs,
        fixumTransactions: fixumTxs,
        expressiTransactions: [],
        adRemovendumConnexaLiberExpressis: cles,
        prior: priorObstructionum);
    stamina.confussusThreads.add(await Isolate.spawn(
        Obstructionum.confussus,
        List<dynamic>.from(
            [interiore, gladii, scuta, acciperePortus.sendPort])));
    acciperePortus.listen((nuntius) async {
      Obstructionum obstructionum = nuntius as Obstructionum;
      InFieriObstructionum ifo = obstructionum.inFieriObstructionum();
      ifo.gladiatorIdentitatum.forEach((gi) =>
          isolates.propterIsolates[gi]?.kill(priority: Isolate.immediate));
      ifo.liberTransactions.forEach((lt) =>
          isolates.liberTxIsolates[lt]?.kill(priority: Isolate.immediate));
      ifo.fixumTransactions.forEach((ft) =>
          isolates.fixumTxIsolates[ft]?.kill(priority: Isolate.immediate));
      par.removePropters(ifo.gladiatorIdentitatum);
      par.removeLiberTransactions(ifo.liberTransactions);
      par.removeFixumTransactions(ifo.fixumTransactions);
      par.removeConnexaLiberExpressis(ifo.connexaLiberExpressis);
      par.syncBlocks.forEach((e) => e.kill(priority: Isolate.immediate));
      par.syncBlocks.add(await Isolate.spawn(
          ParAdRimor.syncBlock,
          List<dynamic>.from([
            obstructionum,
            par.bases,
            directory,
            '${argumentis!.internumIp}:${argumentis!.pervideasPort}'
          ])));
    });
  }

  static Future expressi(
    bool primis,
    String privatusClavis,
    String gladiatorIdentitatis,
    Directory directory,
  ) async {
    Directory directory =
        Directory('vincula/${argumentis!.obstructionumDirectorium}');
    if (!File('${directory.path}/${Constantes.caudices}0.txt').existsSync()) {
      Isolate.current.kill();
    }
    List<Transactio> liberTxs = [];
    List<Transactio> fixumTxs = [];
    Obstructionum priorObstructionum =
        await Utils.priorObstructionum(directory);
    ReceivePort acciperePortus = ReceivePort();
    fixumTxs.addAll(Transactio.grab(par!.fixumTransactions));
    liberTxs.addAll(Transactio.grab(par!.liberTransactions
        .where((lt) => lt.interioreTransactio.isCle == true)));
    // liberTxs
    //     .addAll(priorObstructionum.interioreObstructionum.expressiTransactions);
    Gladiator? gladiatorOppugnare =
        await Obstructionum.grabGladiator(gladiatorIdentitatis, directory);
    if (gladiatorOppugnare == null) {
      Isolate.current.kill();
    }
    PrivateKey pk = PrivateKey.fromHex(Pera.curve(), privatusClavis);
    if (await Obstructionum.gladiatorConfodiantur(
        gladiatorIdentitatis, pk.publicKey.toHex(), directory)) {
      Isolate.current.kill();
    }
    String gladiatorExpressiPrivateKey = privatusClavis;
    for (String acc in gladiatorOppugnare!
        .interioreGladiator.outputs[(primis ? 0 : 1)].rationibus
        .map((e) => e.interiorePropter.publicaClavis)) {
      final balance = await Pera.statera(true, acc, directory);
      if (balance > BigInt.zero) {
        liberTxs.add(Transactio.burn(await Pera.ardeat(
            PrivateKey.fromHex(Pera.curve(), privatusClavis),
            acc,
            priorObstructionum.probationem,
            balance,
            directory)));
      }
    }
    Tuple2<InterioreTransactio?, InterioreTransactio?> transform =
        await Pera.transformFixum(
            gladiatorExpressiPrivateKey, par!.liberTransactions, directory);
    if (transform.item1 != null) {
      liberTxs.add(Transactio.nullam(transform.item1!));
    }
    if (transform.item2 != null) {
      fixumTxs.add(Transactio.nullam(transform.item2!));
    }
    List<String> ltum = [];
    liberTxs.map((lt) => lt.interioreTransactio.identitatis).forEach(ltum.add);
    List<ConnexaLiberExpressi> cles = par!.invenireConnexaLiberExpressis(ltum);
    List<Transactio> expressiTxs = [];
    for (ConnexaLiberExpressi cle in cles) {
      expressiTxs.add(par!.expressiTransactions.singleWhere((et) =>
          et.interioreTransactio.isCle == true &&
          cle.interioreConnexaLiberExpressi.expressiIdentitatis ==
              et.interioreTransactio.identitatis));
    }

    List<Telum> impetus = [];
    impetus.addAll(await Pera.maximeArma(true, primis, true,
        gladiatorOppugnare.interioreGladiator.identitatis, directory));
    impetus.addAll(await Pera.maximeArma(false, primis, true,
        gladiatorOppugnare.interioreGladiator.identitatis, directory));
    List<Telum> defensiones = [];
    defensiones.addAll(await Pera.maximeArma(true, primis, false,
        gladiatorOppugnare.interioreGladiator.identitatis, directory));
    defensiones.addAll(await Pera.maximeArma(false, primis, false,
        gladiatorOppugnare.interioreGladiator.identitatis, directory));
    List<String> gladii = impetus.map((e) => e.telum).toList();
    List<String> scuta = defensiones.map((e) => e.telum).toList();
    final baseDefensio = await Pera.turpiaGladiatoriaTelum(false, primis,
        gladiatorOppugnare.interioreGladiator.identitatis, directory);
    final baseImpetus = await Pera.turpiaGladiatoriaTelum(true, primis,
        gladiatorOppugnare.interioreGladiator.identitatis, directory);
    gladii.add(baseDefensio.telum);
    scuta.add(baseImpetus.telum);
    scuta.removeWhere((defensio) => gladii.contains(defensio));
    BigInt numerus = await Obstructionum.numeruo(
        await Obstructionum.utObstructionumNumerus(directory));
    acciperePortus.listen((nuntius) async {});
  }
}
