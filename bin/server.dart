import 'dart:io';
import 'dart:convert';
import 'dart:isolate';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:args/args.dart';
import 'itineribus/obstructionum_iter.dart';
import 'itineribus/fossor_efectus_iter.dart';
import 'connect/pervideas_to_pervideas.dart';
import 'exempla/exempla.dart';
import 'exempla/obstructionum.dart';
import 'exempla/utils.dart';
import 'auxiliatores/accipere_portum.dart';
import 'itineribus/rationem_iter.dart';
import 'itineribus/transactio_iter.dart';
import 'itineribus/transactio_liber_iter.dart';
import 'itineribus/statera_iter.dart';
import 'auxiliatores/print.dart';

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
  ..post('/obstructionum-numerus', obstructionum)
  ..get('/obstructionum-prior', prior)
  ..get('/obstructionum-generare/<probationem>', probationemGenerare)
  ..delete('/obstructionum-furca-unum-retro', furcaUnumRetro)
  ..post('/fossor-efectus/<loop>', fossor)
  ..get('/fossor-efectus-relatorum', relatorum)
  ..delete('/fossor-efectus-prohibere', prohibere)
  ..post('/rationem-submittere', submittere)
  ..get('/rationem/<identitatis>', rationemIdentitatis)
  ..get('/rationem-novus', novus)
  ..get('/statera/<liber>/<publica>', statera)
  ..post('/transactio-liber-submittere', submittereLiberTransactio)
  ..get('/transactio-stagnum', liberTransactioStagnum)
  ..get('/transactio/<identitatis>', transactioIdentitatis)
  ..delete(
      '/removere-liber-transactio-stagnum', removereLiberTransactioStagnum);

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
PervideasToPervideas? ptp;

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
  total.addOption('pervideas-port', defaultsTo: '8008');
  total.addOption('rpc-port', defaultsTo: '8080');
  total.addOption('tabernus-nodi');
  total.addOption('publica-clavis');
  total.addFlag('partum-key-par');
  total.addFlag('novus');

  var eventus = total.parse(args);
  if (eventus['partum-key-par']) {
    final kp = KeyPair();
    print('publica-clavis: ${kp.public}');
    print('privatus-clavis: ${kp.private}');
    exit(0);
  }
  String? producentis = eventus['publica-clavis'];
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
  Directory directory = await Directory('vincula/$obstructionumDirectorium')
      .create(recursive: true);
  if (eventus['novus'] && directory.listSync().isEmpty) {
    Obstructionum obs = Obstructionum.incipio(
        InterioreObstructionum.incipio(producentis: producentis));
    await obs.salvareIncipio(directory);
    Print.nota(
        nuntius: 'Incipiens creatus obstructionum',
        message: 'Created Incipio block');
  }

  String internumIp = eventus['internum-ip'];
  int pervideasPort = int.parse(eventus['pervideas-port']);
  ptp = PervideasToPervideas(
      int.parse(eventus['max-pervideas']),
      Utils.randomHex(64),
      '$internumIp:$pervideasPort',
      Directory('vincula/${eventus['obstructionum-directorium']}'),
      [0]);
  ptp!.listen(internumIp, pervideasPort);

  String? tabernusNodi = eventus['tabernus-nodi'];
  if (tabernusNodi != null) {
    String? externumIp = eventus['externum-ip'];
    if (externumIp == null) {
      Print.nota(
          nuntius: 'Non opus est valorem pro ip externo si data bootnode',
          message:
              'We need a value for the external ip if a bootnode is given');
      exit(0);
    }
    ptp!.connect(tabernusNodi, '$externumIp:$pervideasPort');
  }

  argumentis = Argumentis(
      eventus['obstructionum-directorium'],
      eventus['publica-clavis'],
      eventus['internum-ip'],
      eventus['pervideas-port'],
      int.parse(eventus['max-pervideas']));

  ptp!.efectusRp.listen((message) {
    AcciperePortum.efectus(
        isSalutaris,
        stamina.efectusThreads,
        isolates.propterIsolates,
        isolates.liberTxIsolates,
        isolates.fixumTxIsolates,
        ptp!,
        directory);
  });

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(eventus['rpc-port']);
  final server = await serve(handler, ip, port);
  Print.nota(
      message: 'Server listening on port ${server.port}',
      nuntius: 'Servo audire in portum ${server.port}');
}
