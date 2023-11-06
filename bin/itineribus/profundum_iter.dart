import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart';

import '../exempla/errors.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/retribuere_profundum.dart';
import '../exempla/transactio.dart';
import '../exempla/utils.dart';
import 'package:elliptic/elliptic.dart';
import '../server.dart';

Future<Response> profundumRetribuere(Request req) async {
  try {
    RetribuereProfundum rp =
        RetribuereProfundum.fromJson(json.decode(await req.readAsString()));
    List<Obstructionum> lo = await Obstructionum.getBlocks(
        Directory('vincula/${argumentis!.obstructionumDirectorium}'));
    List<SiRemotionem> lsr = [];
    lo.map((mo) => mo.interioreObstructionum.siRemotiones).forEach(lsr.addAll);
    SiRemotionem sr = lsr.singleWhere((swsr) =>
        swsr.interioreSiRemotionem.identitatisInterioreSiRemotionem ==
        rp.identitatis);
    List<Transactio> stagnum = par!.liberTransactions;
    SiRemotionemInput sri = SiRemotionemInput(
        Utils.signum(PrivateKey.fromHex(Pera.curve(), rp.ex!), sr),
        rp.identitatis!,
        await Pera.novamRem(
            necessitudo: false,
            liber: sr.interioreSiRemotionem.siRemotionemOutput!.liber,
            twice: true,
            ts: TransactioSignificatio.refugium,
            ex: rp.ex!,
            value: sr.interioreSiRemotionem.siRemotionemOutput!.pod,
            to: sr.interioreSiRemotionem.siRemotionemOutput!.habereIus,
            transactioStagnum: stagnum,
            lo: lo));
    ReceivePort receivePort = ReceivePort();
    isolates.siRemotionemIsolates[
            sr.interioreSiRemotionem.identitatisInterioreSiRemotionem] =
        await Isolate.spawn(
            SiRemotionem.quaestum,
            List<dynamic>.from(
                [InterioreSiRemotionem.input(sri), receivePort.sendPort]));
    receivePort.listen((message) {
      par!.syncSiRemotiones(message as SiRemotionem);
    });
    return Response.ok(json.encode({
      "nuntius": "tuum debth negotium exspectat in stagnum",
      "message": "your debth transaction is waiting in the pool"
    }));
  } on BadRequest catch (br) {
    return Response.badRequest(body: json.encode(br.toJson()));
  }
}

Future<Response> profundumDebita(Request req) async {
  return Response.ok({});
}
