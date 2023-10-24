import 'dart:io';
import 'dart:convert';
import 'dart:isolate';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:args/args.dart';
import 'connect/par_ad_rimor.dart';
import 'exempla/constantes.dart';
import 'exempla/petitio/clavis_par.dart';
import 'itineribus/obstructionum_iter.dart';
import 'itineribus/fossor_efectus_iter.dart';
import 'itineribus/fossor_confussus_iter.dart';
import 'exempla/obstructionum.dart';
import 'itineribus/propter_iter.dart';
import 'itineribus/si_remotiones_iter.dart';
import 'itineribus/submittere_transactio_liber_iter.dart';
import 'itineribus/transactio_iter.dart';
import 'itineribus/statera_iter.dart';
import 'auxiliatores/print.dart';
import 'itineribus/fossor_expressi_iter.dart';
import 'itineribus/gladiator_iter.dart';
import 'itineribus/statera_iter.dart';

class PoschosTesches {
  String? vaschal;
  PoschosTesches();
  Map<String, dynamic> toJson() => {'vaschal': vaschal};
  PoschosTesches.fromJson(Map<String, dynamic> map) : vaschal = map['vaschal'];
}

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/poschos', _poschos)
  ..get('/echo/<message>', _echoHandler)
  ..post('/obstructionum-numerus', obstructionumPerNumerus)
  ..post('/obstructionum-probationem-jugum', obstructionumProbationemJugum)
  ..get('/obstructionum-prior', obstructionumPrior)
  ..delete('/obstructionum-removere-ultimum', obstructionumRemovereUltimum)
  ..post('/fossor-efectus/<furca>', fossorEfectus)
  ..get('/fossor-efectus-threads', efectusThreads)
  ..delete('/prohibere-efectus-fossores', prohibereEfectus)
  ..post('/fossor-confussus/<furca>', fossorConfussus)
  ..get('/fossor-confussus-threads', confussusThreads)
  ..delete('/prohibere-confussus-fossores', prohibereConfussus)
  ..post('/fossor-expressi/<furca>', fossorExpressi)
  ..get('/fossor-expressi-threads', expressiThreads)
  ..delete('/prohibere-confussus-fossores', prohibereExpressi)
  ..post('/propter-submittere', propterSubmittere)
  ..get('/propter-status/<propter-identitatis>', propterStatus)
  ..get('/propter/novus', propterNovus)
  ..get('/gladiator-invictos', gladiatorInvictos)
  ..get('/gladiator-defenditur/<publica-clavis>', gladiatorDefenditur)
  ..get('/gladiator-arma/<propter-identitatis>', gladiatorArma)
  ..get('/gladiator-summa-bid-arma/<probationem>', gladiatorSummaBidArma)
  ..get('/statera/<liber>/<publica>', statera)
  ..post('/transactio-liber-submittere', submittereTransactioLiber)
  ..get('/transactio-stagnum-liber', transactioStagnumLiber)
  ..get('/transactio-stagnum-fixum', transactioStagnumFixum)
  ..get('/transactio-stagnum-expressi', transactioStagnumExpressi)
  ..get('/transactio/<identitatis>', transactioIdentitatis)
  ..get('/connexa-liber-expressi/<liber-identitatis>',transactioConnexaLiberExpressi)
  ..delete('/removere-liber-transactio-stagnum', removereTransactioStagnumLiber)
  ..get('/statera/<publica-clavis>', statera)
  ..post('/si-remotiones-submittere-proof', siRemotionessubmittereProof)
  ..get('/si-remotiones-reprehendo-si-existat', siRemotionesreprehendoSiExistat)
  ..post('/si-remotiones-denuo-proponendam', siRemotionesdenuoProponendam)
  ..get('/si-remotiones-stagnum', siRemotionesStagnum);

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
  Map<String, Isolate> connexaLiberExpressiIsolates = Map();
  Map<String, Isolate> siRemotionemIsolates = Map();
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
  total.addFlag('partum-key-par');
  total.addFlag('novus-catena');
  total.addFlag('novus');
  total.addFlag('sync');
  var eventus = total.parse(args);
  if (eventus['partum-key-par']) {
    final kp = ClavisPar();
    print('publica-clavis: ${kp.publicaClavis}');
    print('privatus-clavis: ${kp.privatusClavis}');
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
  if (!Directory('vincula').existsSync()) {
    print('nuntius: ""');
    print(
        'message: "Launch the blockchain from the root of your project with bin/server.dart"');
    exit(0);
  }
  String obstructionumDirectorium = eventus['obstructionum-directorium'];
  String internumIp = eventus['internum-ip'];
  String? tabernusNodi = eventus['tabernus-nodi'];
  String? externumIp = eventus['externum-ip'];

  bool novusCatena = eventus['novus-catena'];
  bool novus = eventus['novus'];
  bool sync = eventus['sync'];
  int pervideasPort = int.parse(eventus['pervideas-portus']);
  Directory directory =
      await Directory('${Constantes.vincula}/$obstructionumDirectorium')
          .create(recursive: true);
  if (novusCatena && directory.listSync().isEmpty) {
    Obstructionum obs = Obstructionum.incipio(
        InterioreObstructionum.incipio(producentis: producentis));
    await obs.salvareIncipio(directory);
    Print.nota(
        nuntius: 'Incipiens creatus obstructionum',
        message: 'Created Incipio block');
  }
  par = ParAdRimor(
      int.parse(eventus['max-pervideas']),
      '$internumIp:$pervideasPort',
      Directory(
          '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}'));
  par!.audite();
  if ((novus || sync) && tabernusNodi != null) {
    par!.connect(tabernusNodi);
    if (sync) {
      par!.sync(novus);
    }
  } else if (!novusCatena && tabernusNodi == null) {
    Print.nota(
        nuntius: 'nodi noui noui et externum ip nouis ordiri noluisti',
        message:
            'you did not want to start a new chain an either no boot node and externum ip was given');
    exit(0);
  }

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(eventus['rpc-portus']);
  final server = await serve(handler, ip, port);
  Print.nota(
      message: 'Server listening on port ${server.port}',
      nuntius: 'Servo audire in portum ${server.port}');
}
