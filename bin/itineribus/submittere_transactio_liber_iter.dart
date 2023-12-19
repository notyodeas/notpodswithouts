import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/submittere_transactio.dart';
import '../exempla/responsio/transactio_submittere_responsionis.dart';
import '../exempla/transactio.dart';
import '../exempla/errors.dart';
import '../server.dart';
import 'package:collection/collection.dart';

Future<Response> submittereTransactioLiber(Request req) async {
  SubmittereTransaction st =
      SubmittereTransaction.fromJson(json.decode(await req.readAsString()));
  Directory directorium =
      Directory('vincula/${argumentis!.obstructionumDirectorium}');
  try {
    PrivateKey pk = PrivateKey.fromHex(Pera.curve(), st.ex!);
    String publica = pk.publicKey.toHex();
    if (publica == st.to) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 0,
                  message: "potest mittere pecuniam publicam clavem",
                  nuntius: "can not send money to the same public key")
              .toJson()));
    }
    if (st.pod == BigInt.zero) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 1,
                  nuntius: "non potest mittere 0",
                  message: "can not send 0")
              .toJson()));
    }
    if (st.pod! < BigInt.zero) {
      return Response.badRequest(body: BadRequest(code: 2, nuntius: 'non minus pecuniam furtum rem', message: 'can not steal money with a minus transaction'));
    }
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    bool isProbationum = await Pera.isProbationum(st.to!, lo);
    BigInt limit = Pera.habetBid(true, publica, lo);
    if (st.pod! > limit && !isProbationum) {
      return Response.badRequest(body: json.encode(BadRequest(code: 2, nuntius: 'non plus pecuniae tum modus $limit POD', message: 'can not spend more money then your limit of $limit POD')));
    }
    if (!await Pera.isPublicaClavisDefended(st.to!, lo) &&
        !isProbationum) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 3,
                  nuntius: 'accipientis non defenditur',
                  message: 'public key is not defended')
              .toJson()));
    }
    if (SiRemotionem.habetProfundum(true, pk.publicKey.toHex(), lo)) {
      return Response.badRequest(
        body: json.encode(BadRequest(code: 4, nuntius: 'mittens pecuniam penitus', message: 'sender of money is in depth').toJson())
      );
    }
    final bool isp = await Pera.isProbationum(st.to!, lo);
    List<Transactio> stagnum = par!.liberTransactions;
    // print('stagnumotherloctobeprinted\n ${par!.liberTransactions.map((e) => e.toJson())}');
    if (isp) {
      final Transactio liber = Transactio.nullam(await Pera.novamRem(
          necessitudo: false,
          liber: true,
          twice: true,
          ts: TransactioSignificatio.ardeat,
          ex: st.ex!,
          value: st.pod!,
          to: st.to!,
          transactioStagnum: stagnum,
          lo: lo));
      ReceivePort rp = ReceivePort();
      liber.interioreTransactio.probatur = true;
      isolates.liberTxIsolates[liber.interioreTransactio.identitatis] = await Isolate.spawn(Transactio.quaestum, List<dynamic>.from([liber.interioreTransactio, rp.sendPort]));
      rp.listen((transactio) {
        par!.syncLiberTransaction(transactio as Transactio);
      });     
      return Response.ok(json.encode(TransactioSubmittereResponsionis(
              true, liber.interioreTransactio.identitatis)
          .toJson()));
    } else {
      print('okeytimeforregular');
      final Transactio liber = Transactio.nullam(await Pera.novamRem(
          necessitudo: true,
          liber: true,
          twice: true,
          ts: TransactioSignificatio.regularis,
          ex: st.ex!,
          value: st.pod!,
          to: st.to!,
          transactioStagnum: stagnum,
          lo: lo));      
      List<Transactio> letc = List<Transactio>.from(par!.expressiTransactions.map((e) => Transactio.fromJson(e.toJson())));
      Transactio? ltttip = par!.liberTransactions.singleWhereOrNull((swonlt) => liber.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interioreTransactio.identitatis));
      List<Transactio> llttip = [];
      List<String> letitr = [];
      List<String> lclei = [];
      if (ltttip != null) {
        while (ltttip != null) {
          par!.connexiaLiberExpressis.where((wcle) => wcle.interioreConnexaLiberExpressi.liberIdentitatis == ltttip!.interioreTransactio.identitatis).map((mcle) => mcle.interioreConnexaLiberExpressi.identitatis) .forEach(lclei.add);
          llttip.add(ltttip);
          ltttip = par!.liberTransactions.singleWhereOrNull((swonlt) => ltttip!.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interioreTransactio.identitatis));
        }
        Transactio etflt = letc.singleWhere((swet) => swet.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == llttip.first.interioreTransactio.identitatis));
        List<String> lioettr = [];
        List<Transactio> lttr = [];
        lttr.add(etflt);
        par!.expressiTransactions.remove(etflt);
        lioettr.add(etflt.interioreTransactio.identitatis);
        Transactio? etfet = letc.singleWhereOrNull((swonet) => swonet.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == etflt.interioreTransactio.identitatis));
        while (etfet != null) {
          lttr.add(etfet);
          lioettr.add(etfet.interioreTransactio.identitatis);
          letc.remove(etfet);
          etfet = letc.singleWhereOrNull((swonet) => swonet.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == etfet?.interioreTransactio.identitatis));
        }
        List<Transactio> flet = [];
        flet.add(Transactio.nullam(await Pera.novamExpressi(ex: st.ex!, to: st.to!, value: st.pod!, regularis: liber)));
        for (int i = 0; i < lttr.length; i++) {
          BigInt value = BigInt.zero;
          for (TransactioOutput to in lttr[i].interioreTransactio.outputs.where((wo) => wo.publicaClavis != PrivateKey.fromHex(Pera.curve(), st.ex!).publicKey.toHex())) {
            value += to.pod;
          }
          flet.add(Transactio.nullam(await Pera.novamExpressi(ex: st.ex!, to: st.to!, value: value, regularis: flet.last)));
        }
        // par!.connexiaLiberExpressis.where((wcle) => liber.interioreTransactio.identitatis == wcle.interioreConnexaLiberExpressi.liberIdentitatis).map((mcle) => mcle.interioreConnexaLiberExpressi.identitatis).forEach(lclei.add);
        // par!.connexiaLiberExpressis.removeWhere((rwcle) => stagnum.any((as) => as.interioreTransactio.identitatis == rwcle.interioreConnexaLiberExpressi.liberIdentitatis));
        final InterioreConnexaLiberExpressi icle = InterioreConnexaLiberExpressi(
          liberIdentitatis: liber.interioreTransactio.identitatis,
          expressiIdentitatum: flet.map((mlt) => mlt.interioreTransactio.identitatis).toList());
        final ConnexaLiberExpressi cle = ConnexaLiberExpressi(
          PrivateKey.fromHex(Pera.curve(), st.ex!).publicKey.toHex(), icle, st.ex!);
        await par!.removeExpressiTransactions(lioettr);
        await par!.removeConnexaLiberExpressis(lclei);
        await par!.syncConnexaLiberExpressi(cle);
        await par!.syncLiberTransaction(liber);
        for (Transactio t in flet) {
          await par!.syncExpressiTransaction(t);
        }
        print('okey');
      } else {
        print('eschelsesche');
        final Transactio expressi = Transactio.nullam(await Pera.novamExpressi(
            ex: st.ex!,
            to: st.to!,
            value: st.pod!,
            regularis: liber,
        ));
        final InterioreConnexaLiberExpressi icle = InterioreConnexaLiberExpressi(
            liberIdentitatis: liber.interioreTransactio.identitatis,
            expressiIdentitatum: [expressi.interioreTransactio.identitatis]);
        final ConnexaLiberExpressi cle = ConnexaLiberExpressi(
            PrivateKey.fromHex(Pera.curve(), st.ex!).publicKey.toHex(), icle, st.ex!);
        await par!.syncConnexaLiberExpressi(cle);
        await par!.syncLiberTransaction(liber);
        await par!.syncExpressiTransaction(expressi);        
      }
      return Response.ok(json.encode(TransactioSubmittereResponsionis(
              true, liber.interioreTransactio.identitatis)
          .toJson()));
    }
  } on BadRequest catch (br) {
    return Response.badRequest(body: json.encode(br.toJson()));
  }
}

Future<Response> removereTransactioStagnumLiber(Request req) async {
  par!.liberTransactions = [];
  return Response.ok(json.encode({
    "nuntius": "Liber transactios remota sunt a stagnum",
    "message": "Liber transactions are removed from the pool"
  }));
}
