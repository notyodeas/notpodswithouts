import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:elliptic/elliptic.dart';

import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/solucionis_cash_ex.dart';
import '../exempla/petitio/submittere_solucionis.dart';
import '../exempla/solucionis_propter.dart';
import '../exempla/transactio.dart';
import '../server.dart';


Future<Response> solucionisSubmittereSolocionisPropter(Request req) async {
  SubmittereSolucionisPropter ssr = SubmittereSolucionisPropter.fromJson(json.decode(await req.readAsString()));
  PrivateKey privatus = PrivateKey.fromHex(Pera.curve(), ssr.solucionis);
  String publica = privatus.publicKey.toHex();
  InterioreInterioreSolucionisPropter iisp = InterioreInterioreSolucionisPropter(publica, ssr.accipientis);
  InterioreSolucionisPropter isr = InterioreSolucionisPropter(privatus, iisp);
  ReceivePort rp = ReceivePort();
  isolates.solocionisRationem[publica] = await Isolate.spawn(SolucionisPropter.quaestum, List<dynamic>.from([isr, rp.sendPort]));
  rp.listen((solucionis) { 
    par!.syncSolucionisPropter(solucionis as SolucionisPropter);
  });
  return Response.ok(json.encode({
    "nuntius": "solucionis ratio exspectat in stagnum",
    "message": "payment account is waiting in the pool"
  }));
}
Response solucionisStagnum(Request req) {
  return Response.ok(json.encode(par!.solucionisRationibus.map((msp) => msp.toJson()).toList()));
}
Future<Response> solucionisCashEx(Request req) async {
  SolucionisCashEx sce = SolucionisCashEx.fromJson(await json.decode(await req.readAsString()));
  String publica = PrivateKey.fromHex(Pera.curve(), sce.ex).publicKey.toHex();
  Directory directorium = Directory('vincula/${argumentis!.obstructionumDirectorium}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  SolucionisPropter sp = SolucionisPropter.accipere(publica, lo);
  BigInt mittere = await Pera.statera(sce.liber, publica, lo);
  InterioreTransactio it = await Pera.novamRem(necessitudo: false, liber: sce.liber, twice: false, ts: TransactioSignificatio.solucionis, ex: sce.ex, value: mittere, to: sp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.accipientis, transactioStagnum: sce.liber ? par!.liberTransactions : par!.fixumTransactions, lo: lo);
  it.probatur = true;
  ReceivePort rp = ReceivePort();
  if (sce.liber) {
    isolates.liberTxIsolates[it.identitatis] = await Isolate.spawn(Transactio.quaestum, List<dynamic>.from([it, rp.sendPort]));
  } else {
    isolates.fixumTxIsolates[it.identitatis] = await Isolate.spawn(Transactio.quaestum, List<dynamic>.from([it, rp.sendPort]));
  }
  rp.listen((transactio) {
    print('ehummmaha');
    par!.syncLiberTransaction(transactio as Transactio);
  });
  return Response.ok(json.encode({
    "nuntius": "solucionis negotium exspectat in stagnum",
    "message": "payment transaction is waiting in the pool",
    "transactioIdentitatis": it.identitatis
  }));      
}

Future<Response> solucionisSubmittereFissileSolocionisPropter(Request req) async {
  SubmittereFissileSolucionisPropter sfsr = SubmittereFissileSolucionisPropter.fromJson(json.decode(await req.readAsString()));
  PrivateKey privatus = PrivateKey.fromHex(Pera.curve(), sfsr.solucionis);
  String publica = privatus.publicKey.toHex();
  InterioreInterioreFissileSolucionisPropter iifsp = InterioreInterioreFissileSolucionisPropter(publica, sfsr.fixs);
  InterioreFissileSolucionisPropter ifsr = InterioreFissileSolucionisPropter(privatus, iifsp);
  ReceivePort rp = ReceivePort();
  isolates.fissileSolocionisRationem[publica] = await Isolate.spawn(FissileSolucionisPropter.quaestum, List<dynamic>.from([ifsr, rp.sendPort]));
  rp.listen((solucionis) { 
    par!.syncFissileSolucionisPropter(solucionis as FissileSolucionisPropter);
  });
  return Response.ok(json.encode({
    "nuntius": "splitted mercedem ratio exspectat in stagnum",
    "message": "splitted payment account is waiting in the pool"
  }));
}