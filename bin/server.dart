import 'dart:io';
import 'dart:convert';
import 'dart:isolate';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:args/args.dart';
import 'package:elliptic/elliptic.dart';
import 'connect/par_ad_rimor.dart';
import 'exempla/constantes.dart';
import 'exempla/pera.dart';
import 'exempla/petitio/clavis_par.dart';
import 'itineribus/furca_iter.dart';
import 'itineribus/obstructionum_iter.dart';
import 'itineribus/fossor_efectus_iter.dart';
import 'itineribus/fossor_confussus_iter.dart';
import 'exempla/obstructionum.dart';
import 'itineribus/profundum_iter.dart';
import 'itineribus/propter_iter.dart';
import 'itineribus/si_remotiones_iter.dart';
import 'itineribus/solucionis_iter.dart';
import 'itineribus/submittere_transactio_liber_iter.dart';
import 'itineribus/submittere_transactio_fixum_iter.dart';
import 'itineribus/transactio_iter.dart';
import 'itineribus/statera_iter.dart';
import 'auxiliatores/print.dart';
import 'itineribus/fossor_expressi_iter.dart';
import 'itineribus/gladiator_iter.dart';
import 'itineribus/network_iter.dart';
import 'itineribus/download_iter.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_plus/shelf_plus.dart';
import 'itineribus/bases_steals_ins_iter.dart';

class PoschosTesches {
  String? vaschal;
  PoschosTesches();
  Map<String, dynamic> toJson() => {'vaschal': vaschal};
  PoschosTesches.fromJson(Map<String, dynamic> map) : vaschal = map['vaschal'];
}

// Configure routes.
final _router = Router().plus
  ..get('/', _rootHandler)
  ..post('/poschos', _poschos)
  ..get('/echo/<message>', _echoHandler)
  ..post('/obstructionum-numerus', obstructionumPerNumerus)
  ..post('/obstructionum-probationem-jugum', obstructionumProbationemJugum)
  ..get('/obstructionum-prior', obstructionumPrior)
  ..delete('/obstructionum-removere-ultimum/<ex>', obstructionumRemovereUltimum)
  ..delete('/obstructionum-removere-ad-probationem/<probationem>', obstructionumRemovereAdProbationem)
  ..get('/obstructionum-probationems', obstructionumProbationems)
  ..post('/fossor-efectus/<furca>/<privatus>', fossorEfectus)
  ..get('/fossor-efectus-threads', efectusThreads)
  ..delete('/prohibere-efectus-fossores', prohibereEfectus)
  ..post('/fossor-confussus/<furca>', fossorConfussus)
  ..get('/fossor-confussus-threads', confussusThreads)
  ..delete('/prohibere-confussus-fossores', prohibereConfussus)
  ..post('/fossor-expressi/<furca>', fossorExpressi)
  ..get('/fossor-expressi-threads', expressiThreads)
  ..delete('/prohibere-expressi-fossores', prohibereExpressi)
  ..post('/propter-submittere', propterSubmittere)
  // ..post('/propter-submittere-multi', propterSubmittereMulti)
  ..get('/propter-status/<publica-clavis>', propterStatus)
  ..get('/propter-novus', propterNovus)
  ..get('/propter-public/<private-key>', propterPublic)
  ..get('/propter-habet-bid/<publica-clavis>', propterHabetBid)
  ..get('/propter-stagnum', propterStagnum)
  ..delete('/propter-stagnum-remove/<ex>', propterStagnumRemove)
  ..get('/gladiator-invictos', gladiatorInvictos)
  ..get('/gladiator-defenditur/<publica-clavis>', gladiatorDefenditur)
  ..get('/gladiator-arma/<publica-clavis>', gladiatorArma)
  ..get('/gladiator-summa-bid-arma/<probationem>', gladiatorSummaBidArma)
  ..post('/submittere-transactio-liber', submittereTransactioLiber)
  ..post('/submittere-transactio-fixum', submittereTransactioFixum)
  ..delete('/submittere-transactio-liber-remouens', submittereTransactioLiberRemouens)
  ..get('/transactio-stagnum-liber', transactioStagnumLiber)
  ..get('/transactio-stagnum-fixum', transactioStagnumFixum)
  ..get('/transactio-stagnum-expressi', transactioStagnumExpressi)
  ..get('/transactio-stagnum-connexa-liber-expressi', transactioStagnumConnexaLiberExpressi)
  ..get('/transactio/<identitatis>', transactioIdentitatis)
  ..get('/connexa-liber-expressi/<liber-identitatis>',
      transactioConnexaLiberExpressi)
  ..get('/statera/<publica-clavis>', statera)
  ..post('/si-remotiones-submittere-proof', siRemotionessubmittereProof)
  ..get('/si-remotiones-reprehendo-si-existat', siRemotionesreprehendoSiExistat)
  ..post('/si-remotiones-denuo-proponendam', siRemotionesdenuoProponendam)
  ..get('/si-remotiones-stagnum', siRemotionesStagnum)
  ..delete('/si-remotiones-remove',siRemotionemsRemove)
  // ..get('/profundum-profundis/<publica-clavis>', profundumProfundis)
  ..get('/profundum-debita-habereius/<debita>/<publica-clavis>', profundumDebitaHabereIus)
  ..post('/profundum-retribuere', profundumRetribuere)
  // ..get('/profundum-profundums/<publica-clavis>', profundumProfundums)
  ..post('/bases-stealsinsseconds/<privatenotkeys>', stealsinsseconds)
  ..get('/furca-foramen', furcaForamen)
  ..get('/furca-tridentes', furcaTridentes)
  ..get('/furca-quaerere', furcaQuaerere)
  ..post('/furca-sync/<probationem>', furcaSync)
  ..post('/solucionis-submittere-solocionis-propter', solucionisSubmittereSolocionisPropter)
  ..get('/solucionis-stagnum', solucionisStagnum)
  ..post('/solucionis-cash-ex', solucionisCashEx)
  ..post('/solucionis-submittere-fissile-solocionis-propter', solucionisSubmittereFissileSolocionisPropter)
  ..get('/solucionis-fissile-stagnum', solucionisFissileStagnum)
  ..post('/solucionis-fissile-cash-ex', solucionisFissileCashEx)
  ..get('/network-nodorum', networkNodorum)
  ..get('/download/<i>', downloadchain, use: download());

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Future<Response> _poschos(Request rescheq) async {
  final pt = PoschosTesches.fromJson(json.decode(await rescheq.readAsString()));
  return Response.ok(pt.vaschal);
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

class Argumentis {
  String obstructionumDirectorium;
  String publicaClavis;
  String internumIp;
  String pervideasPort;
  int maxPervideas;
  Argumentis(this.obstructionumDirectorium, this.publicaClavis, this.internumIp,
      this.pervideasPort, this.maxPervideas);
}

Argumentis? argumentis;
ParAdRimor? par;

bool isSalutaris = false;

class Stamina {
  List<Isolate> efectusThreads = [];
  List<Isolate> confussusThreads = [];
  List<Isolate> expressiThreads = [];
  Stamina();
}

Stamina stamina = Stamina();

class Isolates {
  Map<String, Isolate> propterIsolates = Map();
  Map<String, Isolate> liberTxIsolates = Map();
  Map<String, Isolate> fixumTxIsolates = Map();
  Map<String, Isolate> expressiTxIsolates = Map();
  Map<String, Isolate> basesstolein = Map();
  Map<String, Isolate> connexaLiberExpressiIsolates = Map();
  Map<String, Isolate> siRemotionemIsolates = Map();
  Map<String, Isolate> solocionisRationem = Map();
  Map<String, Isolate> fissileSolocionisRationem = Map();
  Map<String, Isolate> neTransactions = Map();
  Isolates();
}

Isolates isolates = Isolates();
void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
  var total = ArgParser();
  total.addOption('obstructionum-directorium');
  total.addOption('max-pervideas', defaultsTo: '51');
  total.addOption('internum-ip', defaultsTo: '127.0.0.1');
  total.addOption('externum-ip');
  total.addOption('pervideas-portus', defaultsTo: '8008');
  total.addOption('rpc-portus', defaultsTo: '8080');
  total.addOption('tabernus-nodi');
  total.addOption('producentis', mandatory: true);
  total.addOption('praemium', defaultsTo: '763000000000000000000');
  total.addOption('incipio-ex');
  total.addOption('furca');
  total.addFlag('partum-key-par');
  total.addFlag('novus-catena');
  total.addFlag('novus');
  total.addFlag('sync-novus');
  total.addFlag('sync-pergo');
  total.addFlag('sync-furca');
  var eventus = total.parse(args);
  if (eventus['partum-key-par']) {
    final kp = ClavisPar();
    print('\npublica-clavis: \n ${kp.publicaClavis} \n');
    print('privatus-clavis: \n ${kp.privatusClavis}');
    exit(0);
  }
  argumentis = Argumentis(
      eventus['obstructionum-directorium'],
      eventus['producentis'],
      eventus['internum-ip'],
      eventus['pervideas-portus'],
      int.parse(eventus['max-pervideas']));

  String? producentis = eventus['producentis'];
  if (eventus['obstructionum-directorium'] == null || producentis == null) {
    print(
        'Cum creando vel procedendo clausus opus est et folder clausurae et clavis publica.');
    print(
        'When creating or proceeding a blockchain we need both the folder of the blockchain and a public key.');
    exit(0);
  }
  String obstructionumDirectorium = eventus['obstructionum-directorium'];
  String internumIp = eventus['internum-ip'];
  String praemium = eventus['praemium'];
  String? tabernusNodi = eventus['tabernus-nodi'];
  String? furca = eventus['furca'];
  // String? externumIp = eventus['externum-ip'];

  bool novusCatena = eventus['novus-catena'];
  bool syncNovus = eventus['sync-novus'];
  bool syncPergo = eventus['sync-pergo'];
  bool syncFurca = eventus['sync-furca'];
  int pervideasPort = int.parse(eventus['pervideas-portus']);
  Directory directory =
      await Directory('${Constantes.vincula}/$obstructionumDirectorium/${Constantes.principalis}')
          .create(recursive: true);
  if (novusCatena && directory.listSync().isEmpty) {
    // Print.nota(nuntius: 'clavem privatam tuam nobis dare posses ut cum incipio scandalum creares?', message: 'could you give us your private key to create the incipio block with?');
    // String ex = stdin.readLineSync()!;
    Obstructionum obs = Obstructionum.incipio(
        InterioreObstructionum.incipio(ex: eventus['incipio-ex'], producentis: producentis, praemium: BigInt.parse(praemium)));
    await obs.salvareIncipio(directory);
    Print.nota(
        nuntius: 'Incipiens creatus obstructionum',
        message: 'Created Incipio block');
  }
  if (!syncNovus && directory.listSync().isEmpty) {
    Print.nota(nuntius: 'Quaeso addere novus vexillum ad imperium tuum lineam, quod tuum obstructionum directorium vacuum est', message: 'please add the novus flag to your command line because your block directory is empty');
    exit(0);
  }
  if (syncNovus && directory.listSync().isNotEmpty) {
    Print.nota(nuntius: 'novam catenam incipere non potes si tuum directorium vacuum non est, elige directorium diversum vel novum flag removere', message: 'you can not start a new chain if your directory is not empty, please choose different directory or remove the novus flag');
    exit(0);
  }
  par = ParAdRimor(
      int.parse(eventus['max-pervideas']),
      '$internumIp:$pervideasPort',
      Directory(
          '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}'));
  par!.audite();
  if ((syncNovus || syncPergo || syncFurca) && tabernusNodi != null) {
    par!.connect(tabernusNodi);
    if (syncNovus) {
      par!.sync(sync: Sync.novus);
    } else if (syncPergo) {
      par!.sync(sync: Sync.pergo);
    } 
  } else if (!novusCatena && tabernusNodi == null) {
    Print.nota(
        nuntius: 'nodi noui noui et externum ip nouis ordiri noluisti',
        message:
            'you did not want to start a new chain an either no boot node and externum ip was given');
    exit(0);
  }

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addMiddleware(corsHeaders()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(eventus['rpc-portus']);
  final server = await serve(handler, ip, port);
  Print.nota(
      message: 'Server listening on port ${server.port}',
      nuntius: 'Servo audire in portum ${server.port}');
}
