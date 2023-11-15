import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../auxiliatores/print.dart';
import '../connect/par_ad_rimor.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/errors.dart';
import '../exempla/petitio/incipit_pugna.dart';
import '../exempla/scan.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/telum.dart';
import '../exempla/transactio.dart';
import '../connect/pervideas_to_pervideas.dart';
import 'package:tuple/tuple.dart';
import '../exempla/constantes.dart';
import '../exempla/utils.dart';
import 'package:collection/collection.dart';
import '../server.dart';
import 'obstructionum_iter.dart';

Future<Response> fossorExpressi(Request req) async {

  bool estFurca = bool.parse(req.params['furca']!);
  print('recievedcommandtofossor');
  try {
      IncipitPugna ip =
      IncipitPugna.fromJson(json.decode(await req.readAsString()));
      Directory directory =
          Directory('vincula/${argumentis!.obstructionumDirectorium}');
      List<Obstructionum> lo = await Obstructionum.getBlocks(directory);

      List<Isolate> syncExpressiBlocks = [];
      if (!File('${directory.path}/${Constantes.caudices}0.txt').existsSync()) {
        return Response.badRequest(
            body: json.encode({
          "code": 0,
          "nuntius": "adhuc expectans incipio obstructionum",
          "message": "Still waiting on incipio block"
        }));
      }
      List<Transactio> liberTxs = [];
      List<Transactio> fixumTxs = [];
      Obstructionum priorObstructionum =
          await Obstructionum.acciperePrior(directory);
      ReceivePort acciperePortus = ReceivePort();
      liberTxs.addAll(priorObstructionum.interioreObstructionum.expressiTransactions);
      fixumTxs.addAll(Transactio.grab(par!.fixumTransactions
          .where((wft) => wft.interioreTransactio.probatur == true && !wft.capta)));
      liberTxs.addAll(Transactio.grab(par!.liberTransactions
          .where((wlt) => wlt.interioreTransactio.probatur == true && !wlt.capta)));
        // maby we need capta too to validate upon a youngerblock on a different node but lets see that would occur auto
      List<SiRemotionem> lsr = SiRemotionem.grab(par!.siRemotiones);
      final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
      // liberTxs
      //     .addAll(priorObstructionum.interioreObstructionum.expressiTransactions);
      Gladiator? gladiatorOppugnare =
          await Obstructionum.grabGladiator(ip.victima!.gladiatorIdentitatis!, lo);
      if (gladiatorOppugnare == null) {
        return Response.badRequest(
            body: json.encode({
          "code": 1,
          "nuntius": "Gladiator non inveni",
          "message": "Gladiator not found"
        }));
      }
      PrivateKey pk = PrivateKey.fromHex(Pera.curve(), ip.privatusClavis!);
      if (await Obstructionum.gladiatorConfodiantur(
          ip.victima!.gladiatorIdentitatis!, pk.publicKey.toHex(), lo)) {
        return Response.badRequest(
            body: json.encode({
          "code": 2,
          "message": "Non te oppugnare",
          "english": "Can not attack yourself"
        }));
      }
      String gladiatorExpressiPrivateKey = ip.privatusClavis!;
      for (String acc in gladiatorOppugnare
          .interioreGladiator.outputs[(ip.victima!.primis! ? 0 : 1)].rationibus
          .map((e) => e.interiorePropter.publicaClavis)) {
        final balance = await Pera.statera(true, acc, lo);
        if (balance > BigInt.zero) {
          liberTxs.add(Transactio.burn(await Pera.ardeat(
              PrivateKey.fromHex(Pera.curve(), ip.privatusClavis!),
              acc,
              priorObstructionum.probationem,
              balance,
              lo)));
        }
      }
      liberTxs.addAll(lsr.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null).map((msr) => Transactio.nullam(msr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio)));
      Tuple2<InterioreTransactio?, InterioreTransactio?> transform =
          await Pera.transformFixum(
              gladiatorExpressiPrivateKey, liberTxs, lo);
      if (transform.item1 != null) {
        liberTxs.add(Transactio.nullam(transform.item1!));
      }
      if (transform.item2 != null) {
        fixumTxs.add(Transactio.nullam(transform.item2!));
      }
      // liberTxs.addAll(Transactio.grab(par!.liberTransactions.where((lt) => lt.interioreTransactio.probatur == true)));
      // fixumTxs.addAll(Transactio.grab(par!.fixumTransactions.where((ft) => ft.interioreTransactio.probatur == true)));
      List<String> ltum = [];
      liberTxs.map((lt) => lt.interioreTransactio.identitatis).forEach(ltum.add);
      List<Telum> impetus = [];
      impetus.addAll(await Pera.maximeArma(true, ip.inimicus!.primis!, true,
          ip.inimicus!.gladiatorIdentitatis!, lo));
      impetus.addAll(await Pera.maximeArma(false, ip.inimicus!.primis!, true,
          ip.inimicus!.gladiatorIdentitatis!, lo));
      List<Telum> defensiones = [];
      defensiones.addAll(await Pera.maximeArma(
          true, ip.victima!.primis!, false, ip.victima!.gladiatorIdentitatis!, lo));
      defensiones.addAll(await Pera.maximeArma(false, ip.victima!.primis!, false,
          ip.victima!.gladiatorIdentitatis!, lo));
      List<String> gladii = impetus.map((e) => e.telum).toList();
      List<String> scuta = defensiones.map((e) => e.telum).toList();
      final baseDefensio = await Pera.turpiaGladiatoriaTelum(
          ip.victima!.primis!, false, ip.victima!.gladiatorIdentitatis!, lo);
      final baseImpetus = await Pera.turpiaGladiatoriaTelum(
          ip.inimicus!.primis!, true, ip.inimicus!.gladiatorIdentitatis!, lo);
      gladii.add(baseImpetus);
      scuta.add(baseDefensio);
      scuta.removeWhere((impetus) => gladii.any((ag) => ag == impetus));
      List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
      BigInt numerus = await Obstructionum.numeruo(on);
      InterioreObstructionum interiore = InterioreObstructionum.expressi(
          estFurca: estFurca,
          obstructionumDifficultas: obstructionumDifficultas.length,
          divisa: (numerus / await Obstructionum.utSummaDifficultas(lo)),
          forumCap: await Obstructionum.accipereForumCap(lo),
          liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
          fixumForumCap: await Obstructionum.accipereForumCapLiberFixum(false, lo),
          summaObstructionumDifficultas: await Obstructionum.utSummaDifficultas(lo),
          obstructionumNumerus: on,
          producentis: argumentis!.publicaClavis,
          priorProbationem: priorObstructionum.probationem,
          gladiator: Gladiator.nullam(InterioreGladiator.ce(input: await InterioreGladiator.cegi(privatusClavis: ip.privatusClavis!, inimicus: GladiatorInputPar(ip.inimicus!.primis!, ip.inimicus!.gladiatorIdentitatis!), victima: GladiatorInputPar(ip.victima!.primis!, ip.victima!.gladiatorIdentitatis!), lo: lo))),
          liberTransactions: liberTxs,
          fixumTransactions: fixumTxs,
          expressiTransactions: [],
          connexaLiberExpressis: [],
          siRemotiones: lsr,
          prior: priorObstructionum);
      stamina.expressiThreads.add(await Isolate.spawn(Obstructionum.expressi,
          List<dynamic>.from([interiore, scuta, acciperePortus.sendPort])));
      acciperePortus.listen((nuntius) async {
        print('whydoyouhitthistwice?');
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
        ifo.connexaLiberExpressis.forEach((cle) {
          isolates.connexaLiberExpressiIsolates[cle]
              ?.kill(priority: Isolate.immediate);
        });
        ifo.siRemotionems.forEach((sr) =>
            isolates.siRemotionemIsolates[sr]?.kill(priority: Isolate.immediate));
        stamina.expressiThreads.forEach((et) => et.kill(priority: Isolate.immediate));
        await par!.removeLiberTransactions(ifo.liberTransactions);
        await par!.removeFixumTransactions(ifo.fixumTransactions);
        await par!.removeExpressiTransactions(ifo.expressiTransactions);
        await par!.removePropters(ifo.fixumTransactions);
        await par!.removeConnexaLiberExpressis(ifo.connexaLiberExpressis);
        await par!.removeSiRemotionems(ifo.siRemotionems);
        await par!.sumoLiberTransactions(ifo.liberTransactions);
        await par!.sumoFixumTransactions(ifo.fixumTransactions);
        await par!.sumoExpressiTransactions(ifo.expressiTransactions);
        await par!.syncBlock(obstructionum);
      });
      return Response.ok(json.encode({
        "nuntius": "coepi expressi miner",
        "message": "started expressi miner",
        "threads": stamina.expressiThreads.length
      }));    
  } on BadRequest catch (e) {
    return Response.badRequest(body: json.encode(e.toJson()));
  }

}

Future<Response> expressiThreads(Request req) async {
  return Response.ok({"threads": stamina.expressiThreads.length});
}

Future<Response> prohibereExpressi() async {
  stamina.expressiThreads.forEach((e) => e.kill(priority: Isolate.immediate));
  return Response.ok({
    "message": "bene substitit expressi miner",
    "english": "succesfully stopped expressi miner",
  });
}
