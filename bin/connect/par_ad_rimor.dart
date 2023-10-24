import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:hex/hex.dart';
import '../auxiliatores/print.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/constantes.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/transactio.dart';
import '../exempla/utils.dart';
import 'package:collection/collection.dart';
import 'package:elliptic/elliptic.dart';

class PervideasNuntius {
  String titulus;
  List<String> accepit;
  PervideasNuntius(this.titulus, this.accepit);
  PervideasNuntius.ex(Map<String, dynamic> nuntius)
      : titulus = nuntius[PervideasNuntiusCasibus.titulus],
        accepit = List<String>.from(
            nuntius[PervideasNuntiusCasibus.accepit] as Iterable<dynamic>);
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class UnaBasesSingulasPervideasNuntius extends PervideasNuntius {
  String nervus;
  UnaBasesSingulasPervideasNuntius(
      this.nervus, String titulus, List<String> accepit)
      : super(titulus, accepit);

  UnaBasesSingulasPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : nervus = nuntius[PervideasNuntiusCasibus.nervus].toString(),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.nervus: nervus,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class InConnectPervideasNuntius extends PervideasNuntius {
  List<String> bases = [];
  List<Propter> rationibus = [];
  List<Transactio> liberTansactions = [];
  List<Transactio> fixumTransactions = [];
  List<Transactio> expressiTransactions = [];
  List<ConnexaLiberExpressi> connexaLiberExpressis = [];

  InConnectPervideasNuntius(
      {required this.bases,
      required this.rationibus,
      required this.liberTansactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required String titulus,
      required List<String> accepit})
      : super(titulus, accepit);

  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.bases: bases,
        PervideasNuntiusCasibus.rationibus: rationibus,
        PervideasNuntiusCasibus.liberTransactions:
            liberTansactions.map((lt) => lt.toJson()).toList(),
        PervideasNuntiusCasibus.fixumTransactions:
            fixumTransactions.map((ft) => ft.toJson()).toList(),
        PervideasNuntiusCasibus.expressiTransactions:
            expressiTransactions.map((et) => et.toJson()).toList(),
        PervideasNuntiusCasibus.connexaLiberExpressi:
            connexaLiberExpressis.map((cle) => cle.toJson()).toList(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };

  InConnectPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : bases = List<String>.from(
            nuntius[PervideasNuntiusCasibus.bases] as List<dynamic>),
        rationibus = List<Propter>.from(
            (nuntius[PervideasNuntiusCasibus.rationibus] as List<dynamic>)
                .map((p) => Propter.fromJson(p as Map<String, dynamic>))),
        liberTansactions = List<Transactio>.from(
          (nuntius[PervideasNuntiusCasibus.liberTransactions] as List<dynamic>)
              .map((lt) => Transactio.fromJson(lt as Map<String, dynamic>)),
        ),
        fixumTransactions = List<Transactio>.from(
            (nuntius[PervideasNuntiusCasibus.fixumTransactions]
                    as List<dynamic>)
                .map((ft) => Transactio.fromJson(ft as Map<String, dynamic>))),
        expressiTransactions = List<Transactio>.from(
            (nuntius[PervideasNuntiusCasibus.expressiTransactions]
                    as List<dynamic>)
                .map((et) => Transactio.fromJson(et as Map<String, dynamic>))),
        connexaLiberExpressis = List<ConnexaLiberExpressi>.from((nuntius[
                PervideasNuntiusCasibus.connexaLiberExpressi] as List<dynamic>)
            .map((cle) =>
                ConnexaLiberExpressi.fromJson(cle as Map<String, dynamic>))),
        super.ex(nuntius);
}

class TransactioPervideasNuntius extends PervideasNuntius {
  Transactio transactio;
  TransactioPervideasNuntius(
      this.transactio, String titulus, List<String> accepit)
      : super(titulus, accepit);
  TransactioPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : transactio = Transactio.fromJson(
            nuntius[PervideasNuntiusCasibus.transactio]
                as Map<String, dynamic>),
        super.ex(nuntius);

  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.transactio: transactio.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class LiberTransactioPervideasNuntius extends TransactioPervideasNuntius {
  LiberTransactioPervideasNuntius(
      Transactio transactio, String titulust, List<String> accepit)
      : super(transactio, titulust, accepit);
  LiberTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : super.ex(nuntius);
}

class FixumTransactioPervideasNuntius extends TransactioPervideasNuntius {
  FixumTransactioPervideasNuntius(
      Transactio transactio, String titulust, List<String> accepit)
      : super(transactio, titulust, accepit);
  FixumTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : super.ex(nuntius);
}

class ExpressiTransactioPervideasNuntius extends TransactioPervideasNuntius {
  Transactio transactio;
  ExpressiTransactioPervideasNuntius(
      this.transactio, String titulust, List<String> accepit)
      : super(transactio, titulust, accepit);
  ExpressiTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : transactio = Transactio.fromJson(
            nuntius[PervideasNuntiusCasibus.transactio]
                as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit,
        PervideasNuntiusCasibus.transactio: transactio.toJson()
      };
}

class ConnexaLiberExpressiPervideasNuntius extends PervideasNuntius {
  ConnexaLiberExpressi cle;
  ConnexaLiberExpressiPervideasNuntius(
      this.cle, String titulust, List<String> accepit)
      : super(titulust, accepit);
  ConnexaLiberExpressiPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : cle = ConnexaLiberExpressi.fromJson(
            nuntius[PervideasNuntiusCasibus.cle] as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.cle: cle.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class SiRemotionemPervideasNuntius extends PervideasNuntius {
  SiRemotionem siRemotionem;
  SiRemotionemPervideasNuntius(
      this.siRemotionem, String titulus, List<String> accepit)
      : super(titulus, accepit);
  SiRemotionemPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : siRemotionem = SiRemotionem.fromJson(
            nuntius[PervideasNuntiusCasibus.siRemotionem]
                as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.siRemotionem: siRemotionem,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class RemoveConnexaLiberExpressiPervideasNuntius extends PervideasNuntius {
  List<String> identitatum;
  RemoveConnexaLiberExpressiPervideasNuntius(
      this.identitatum, String titulus, List<String> accepit)
      : super(titulus, accepit);
  RemoveConnexaLiberExpressiPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : identitatum =
            List<String>.from((nuntius[PervideasNuntiusCasibus.identitatum])),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.identitatum: identitatum,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class PropterPervideasNuntius extends PervideasNuntius {
  Propter propter;
  PropterPervideasNuntius(this.propter, String titulust, List<String> accepit)
      : super(titulust, accepit);
  PropterPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : propter = Propter.fromJson(
            nuntius[PervideasNuntiusCasibus.propter] as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.propter: propter.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class PrepareObstructionumAnswerPervideasNuntius extends PervideasNuntius {
  List<String> bases;
  PrepareObstructionumAnswerPervideasNuntius(
      this.bases, String titulust, List<String> accepit)
      : super(titulust, accepit);
  PrepareObstructionumAnswerPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : bases = List<String>.from(
            nuntius[PervideasNuntiusCasibus.bases] as List<dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.bases: bases,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

enum Exemplar { liber, expressi, fixum }

extension ExemplarFromJson on Exemplar {
  static fromJson(String name) {
    switch (name) {
      case 'liber':
        return Exemplar.liber;
      case 'expressi':
        return Exemplar.expressi;
      case 'fixum':
        return Exemplar.fixum;
    }
  }
}

class RemoveProptersPervideasNuntius extends PervideasNuntius {
  List<String> identitatum;
  RemoveProptersPervideasNuntius(
      this.identitatum, String titulus, List<String> accepit)
      : super(titulus, accepit);
  RemoveProptersPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : identitatum = List<String>.from(
            nuntius[PervideasNuntiusCasibus.identitatum] as List<dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.identitatum: identitatum,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class RemoveTransactionsPervideasNuntius extends PervideasNuntius {
  Exemplar exemplar;
  List<String> identitatum;
  RemoveTransactionsPervideasNuntius(
      this.exemplar, this.identitatum, String titulust, List<String> accepit)
      : super(titulust, accepit);
  RemoveTransactionsPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : exemplar =
            ExemplarFromJson.fromJson(nuntius[PervideasNuntiusCasibus.exemplar])
                as Exemplar,
        identitatum = List<String>.from(
            nuntius[PervideasNuntiusCasibus.indexIdentitatis] as List<dynamic>),
        super.ex(nuntius);
}

class ObstructionumPervideasNuntius extends PervideasNuntius {
  Obstructionum obstructionum;
  ObstructionumPervideasNuntius(
      this.obstructionum, String titulust, List<String> accepit)
      : super(titulust, accepit);
  ObstructionumPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : obstructionum = Obstructionum.fromJson(
            nuntius['obstructionum'] as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.obstructionum: obstructionum.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class PetitioObstructionumPervideasNuntius extends PervideasNuntius {
  String probationem;
  PetitioObstructionumPervideasNuntius(
      this.probationem, String titulust, List<String> accepit)
      : super(titulust, accepit);
  PetitioObstructionumPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : probationem = nuntius[PervideasNuntiusCasibus.probationem].toString(),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.numerus: probationem,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit,
      };
}

class MatchingInvenireProbationemPervideasNuntius extends PervideasNuntius {
  String probationem;
  MatchingInvenireProbationemPervideasNuntius(
      this.probationem, String titulust, List<String> accepit)
      : super(titulust, accepit);
  MatchingInvenireProbationemPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : probationem = nuntius[PervideasNuntiusCasibus.probationem].toString(),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.probationem: probationem,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class PetitioObstructionumIncipioPervideasNuntius extends PervideasNuntius {
  PetitioObstructionumIncipioPervideasNuntius(
      String titulus, List<String> accepit)
      : super(titulus, accepit);
  PetitioObstructionumIncipioPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : super.ex(nuntius);
}

class PetitioSummumObsturctionumProbationemPervideasNuntius
    extends PervideasNuntius {
  String ip;
  List<String> documenta;
  PetitioSummumObsturctionumProbationemPervideasNuntius(
      this.ip, this.documenta, String titulus, List<String> accepit)
      : super(titulus, accepit);
  PetitioSummumObsturctionumProbationemPervideasNuntius.ex(
      Map<String, dynamic> nuntius)
      : ip = nuntius[PervideasNuntiusCasibus.ip],
        documenta =
            List<String>.from(nuntius[PervideasNuntiusCasibus.documenta]),
        super.ex(nuntius);
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class ObstructionumSalvarePervideasNuntius extends PervideasNuntius {
  Obstructionum obstructionum;
  ObstructionumSalvarePervideasNuntius(
      this.obstructionum, String titulus, List<String> accepit)
      : super(titulus, accepit);
  ObstructionumSalvarePervideasNuntius.ex(Map<String, dynamic> nuntius)
      : obstructionum = Obstructionum.fromJson(
            nuntius[PervideasNuntiusCasibus.obstructionum]
                as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.obstructionum: obstructionum,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class ObstructionumReponereUnaPervideasNuntius extends PervideasNuntius {
  Obstructionum obstructionum;
  ObstructionumReponereUnaPervideasNuntius(
      this.obstructionum, String titulus, List<String> accepit)
      : super(titulus, accepit);
  ObstructionumReponereUnaPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : obstructionum = Obstructionum.fromJson(
            nuntius[PervideasNuntiusCasibus.obstructionum]
                as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.obstructionum: obstructionum.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class ObstructionumReponerePervideasNuntius extends PervideasNuntius {
  Obstructionum postea;
  ObstructionumReponerePervideasNuntius(
      this.postea, String titulus, List<String> accepit)
      : super(titulus, accepit);
  ObstructionumReponerePervideasNuntius.ex(Map<String, dynamic> nuntius)
      : postea =
            Obstructionum.fromJson(nuntius[PervideasNuntiusCasibus.postea]),
        super.ex(nuntius);
}

class SummaScandalumExNodoPervideasNuntius extends PervideasNuntius {
  List<int> numerus;
  SummaScandalumExNodoPervideasNuntius(
      this.numerus, String titulus, List<String> accepit)
      : super(titulus, accepit);
  SummaScandalumExNodoPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : numerus = List<int>.from(nuntius[PervideasNuntiusCasibus.numerus]),
        super.ex(nuntius);

  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.numerus: numerus,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class SatusFurcaPropagationemPervideasNuntius extends PervideasNuntius {
  Obstructionum obstructionum;
  SatusFurcaPropagationemPervideasNuntius(
      this.obstructionum, String titulus, List<String> accepit)
      : super(titulus, accepit);
  SatusFurcaPropagationemPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : obstructionum = Obstructionum.fromJson(
            nuntius[PervideasNuntiusCasibus.obstructionum]
                as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit,
        PervideasNuntiusCasibus.obstructionum: obstructionum
      };
}

class ParAdRimor {
  bool isSalvare = false;
  bool isEfectusAgit = false;
  bool isConfussusAgit = false;
  bool isExpressiAgit = false;
  int maxPares;
  String ip;
  Directory directorium;
  ReceivePort efectusAcciperePortum = ReceivePort();
  ReceivePort confussusAcciperePortum = ReceivePort();
  ReceivePort expressiAcciperePortum = ReceivePort();
  List<String> bases = [];
  List<Propter> rationibus = [];
  List<Transactio> liberTransactions = [];
  List<Transactio> fixumTransactions = [];
  List<Transactio> expressiTransactions = [];
  List<SiRemotionem> siRemotiones = [];
  List<ConnexaLiberExpressi> connexiaLiberExpressis = [];
  List<Obstructionum> foramenFurca = [];
  List<Obstructionum> tridentes = [];
  List<Isolate> syncBlocks = [];
  ParAdRimor(this.maxPares, this.ip, this.directorium);

  audite() async {
    List<String> sip = ip.split(':');
    ServerSocket serverNervum =
        await ServerSocket.bind(sip[0], int.parse(sip[1]));
    serverNervum.listen((clientis) {
      utf8.decoder.bind(clientis).listen((eventus) async {
        Print.nota(
            nuntius: 'pervideas ut pari servo suscepit nuntium on $ip',
            message: 'peer to peer server recieved a message on $ip');
        PervideasNuntius pn =
            PervideasNuntius.ex(json.decode(eventus) as Map<String, dynamic>);
        print(eventus);
        print('doneprintingmsg');
        while (isSalvare) {
          await Future.delayed(Duration(milliseconds: 100));
        }
        if (pn.titulus == PervideasNuntiusCasibus.connectTaberNodi) {
          UnaBasesSingulasPervideasNuntius ubs =
              UnaBasesSingulasPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          clientis.write(json.encode(InConnectPervideasNuntius(
              bases: bases,
              rationibus: rationibus,
              liberTansactions: liberTransactions,
              fixumTransactions: fixumTransactions,
              expressiTransactions: expressiTransactions,
              connexaLiberExpressis: connexiaLiberExpressis,
              titulus: PervideasNuntiusCasibus.onConnect,
              accepit: List<String>.from([ip])).indu()));
          for (String nervuss
              in bases.where((wb) => !ubs.accepit.contains(wb))) {
            Socket nervus = await Socket.connect(
                nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write(json.encode(UnaBasesSingulasPervideasNuntius(
                nervuss,
                PervideasNuntiusCasibus.singleSocket,
                List<String>.from([ip])).indu()));
          }
          if (bases.length < maxPares &&
              !bases.contains(ubs.nervus) &&
              ip != ubs.nervus) {
            bases.add(ubs.nervus);
          }
          clientis.destroy();
          print('destroyed');
        } else if (pn.titulus == PervideasNuntiusCasibus.singleSocket) {
          UnaBasesSingulasPervideasNuntius ubs =
              UnaBasesSingulasPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          if (bases.length < maxPares && ubs.nervus != ip) {
            bases.add(ubs.nervus);
          }
          if (!ubs.accepit.contains(ip)) {
            ubs.accepit.add(ip);
          }
          for (String nervuss
              in bases.where((wb) => !ubs.accepit.contains(wb))) {
            Socket nervus = await Socket.connect(
                nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write(json.encode(UnaBasesSingulasPervideasNuntius(
                    nervuss, PervideasNuntiusCasibus.singleSocket, ubs.accepit)
                .indu()));
          }
          clientis.destroy();
          print('destroyed');
        } else if (pn.titulus ==
            PervideasNuntiusCasibus.petitioObstructionumIncipio) {
          PetitioObstructionumIncipioPervideasNuntius poipn =
              PetitioObstructionumIncipioPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
          if (!poipn.accepit.contains(ip)) {
            poipn.accepit.add(ip);
          }
          clientis.write(json.encode(ObstructionumReponereUnaPervideasNuntius(
                  obss[0],
                  PervideasNuntiusCasibus.obstructionumReponereUna,
                  poipn.accepit)
              .indu()));
          print('waitingtobedestroyed');
          //never destroy here
          // clientis.destroy();
        } else if (pn.titulus == PervideasNuntiusCasibus.petitioObstructionum) {
          PetitioObstructionumPervideasNuntius popn =
              PetitioObstructionumPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
          Obstructionum? obs = obss.singleWhereOrNull((element) =>
              element.interioreObstructionum.priorProbationem ==
              popn.probationem);
          if (obs == null) {
            Obstructionum obsr = await Obstructionum.acciperePrior(directorium);
            clientis.write(json.encode(SummaScandalumExNodoPervideasNuntius(
                obsr.interioreObstructionum.obstructionumNumerus,
                PervideasNuntiusCasibus.summaScandalumExNodo, []).indu()));
            clientis.destroy();
            print('ididdestroymyclient!');
          } else {
            clientis.write(json.encode(ObstructionumReponereUnaPervideasNuntius(
                    obs, PervideasNuntiusCasibus.obstructionumReponereUna, [])
                .indu()));
          }
        } else if (pn.titulus == PervideasNuntiusCasibus.propter) {
          PropterPervideasNuntius ppn = PropterPervideasNuntius.ex(
              json.decode(eventus) as Map<String, dynamic>);
          if (ppn.propter.probationem ==
              HEX.encode(sha512
                  .convert(utf8.encode(
                      json.encode(ppn.propter.interiorePropter.toJson())))
                  .bytes)) {
            if (rationibus.any((p) =>
                p.interiorePropter.identitatis ==
                ppn.propter.interiorePropter.identitatis)) {
              rationibus.removeWhere((p) =>
                  p.interiorePropter.identitatis ==
                  ppn.propter.interiorePropter.identitatis);
            }
            rationibus.add(ppn.propter);
            if (!ppn.accepit.contains(ip)) {
              ppn.accepit.add(ip);
            }
            for (String nervusFilim
                in bases.where((n) => !ppn.accepit.contains(n))) {
              List<String> fissile = nervusFilim.split(':');
              Socket nervus =
                  await Socket.connect(fissile[0], int.parse(fissile[1]));
              nervus.write(json.encode(PropterPervideasNuntius(
                  ppn.propter, PervideasNuntiusCasibus.accepit, ppn.accepit).indu()));
            }
            clientis.destroy();
          }
        } else if (pn.titulus ==
            PervideasNuntiusCasibus.prepareObstructionumSync) {
          List<String> albumBases = bases;
          albumBases.removeWhere((lb) => pn.accepit.contains(lb));
          clientis.write(json.encode(PrepareObstructionumAnswerPervideasNuntius(
              albumBases,
              PervideasNuntiusCasibus.prepareObstructionumAnswer, [])));
          clientis.destroy();
        } else if (pn.titulus == PervideasNuntiusCasibus.liberTransaction) {
          LiberTransactioPervideasNuntius ltpn =
              LiberTransactioPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
          if (await ltpn.transactio
                  .convalidandumTransaction(null, TransactioGenus.liber, lo) &&
              ltpn.transactio.isFurantur() &&
              !ltpn.transactio.validateProbationem()) {
            if (liberTransactions.any((alt) =>
                alt.interioreTransactio.identitatis ==
                ltpn.transactio.interioreTransactio.identitatis)) {
              liberTransactions.remove(ltpn.transactio);
            }
            liberTransactions.add(ltpn.transactio);
            if (!pn.accepit.contains(ip)) {
              pn.accepit.add(ip);
            }
            syncThrough(pn.accepit, ltpn.transactio);
          }
        } else if (pn.titulus == PervideasNuntiusCasibus.fixumTransaction) {
          FixumTransactioPervideasNuntius ftpn =
              FixumTransactioPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
          if (await ftpn.transactio
                  .convalidandumTransaction(null, TransactioGenus.fixum, lo) &&
              ftpn.transactio.isFurantur() &&
              !ftpn.transactio.validateProbationem()) {
            if (fixumTransactions.any((aft) =>
                aft.interioreTransactio.identitatis ==
                ftpn.transactio.interioreTransactio.identitatis)) {
              fixumTransactions.remove(ftpn.transactio);
            }
            fixumTransactions.add(ftpn.transactio);
            if (!pn.accepit.contains(ip)) {
              pn.accepit.add(ip);
            }
            syncThrough(pn.accepit, ftpn.transactio);
          }
        } else if (pn.titulus == PervideasNuntiusCasibus.expressiTransaction) {
          ExpressiTransactioPervideasNuntius etpn =
              ExpressiTransactioPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
          if (await etpn.transactio.convalidandumTransaction(
                  null, TransactioGenus.expressi, lo) &&
              etpn.transactio.isFurantur() &&
              !etpn.transactio.validateProbationem()) {
            if (expressiTransactions.any((aet) =>
                aet.interioreTransactio.identitatis ==
                etpn.transactio.interioreTransactio.identitatis)) {
              expressiTransactions.remove(etpn.transactio);
            }
            expressiTransactions.add(etpn.transactio);
            if (!pn.accepit.contains(ip)) {
              pn.accepit.add(ip);
            }
            syncThrough(pn.accepit, etpn.transactio);
          }
        } else if (pn.titulus == PervideasNuntiusCasibus.connexaLiberExpressi) {
          ConnexaLiberExpressiPervideasNuntius clepn =
              ConnexaLiberExpressiPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          if (!Utils.cognoscereConnexaLiberExpressi(
              PublicKey.fromHex(Pera.curve(), clepn.cle.dominus),
              Signature.fromASN1Hex(clepn.cle.signature),
              clepn.cle.interioreConnexaLiberExpressi)) {
            Print.nota(
                nuntius:
                    'solus dominus liber transactionis potest sync an connexionem ad suum expressi transactionem',
                message:
                    'only the owner of a liber transaction can sync an connection to its expressi transaction');
            return;
          }
          connexiaLiberExpressis.add(clepn.cle);
          if (!clepn.accepit.contains(ip)) {
            clepn.accepit.add(ip);
          }
          for (String nervuss
              in bases.where((n) => !clepn.accepit.contains(n))) {
            Socket nervus = await Socket.connect(
                nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write(json.encode(clepn.indu()));
          }
        } else if (pn.titulus == PervideasNuntiusCasibus.siRemotionemSync) {
          SiRemotionemPervideasNuntius srpn = SiRemotionemPervideasNuntius.ex(
              json.decode(eventus) as Map<String, dynamic>);
          if (srpn.siRemotionem.validateProbationem() &&
              srpn.siRemotionem.seligeSignatureAbMittente() &&
              await srpn.siRemotionem.remotumEst() &&
              await srpn.siRemotionem.nonHabetInitus()) {
            if (siRemotiones.contains(srpn.siRemotionem)) {
              siRemotiones.remove(srpn.siRemotionem);
            }
            siRemotiones.add(srpn.siRemotionem);
            for (String nervuss
                in bases.where((s) => !srpn.accepit.contains(s))) {
              Socket nervus = await Socket.connect(
                  nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(srpn.indu()));
            }
            clientis.destroy();
          } else {
            Print.nota(
                nuntius:
                    'Mittens huius obstructionum continet rem probationem turpis rommovetur',
                message:
                    'Mittens huius obstructionum continet rem probationem turpis rommovetur');
          }
        } else if (pn.titulus ==
            PervideasNuntiusCasibus.removeLiberTransactions) {
          RemoveTransactionsPervideasNuntius rtpn =
              RemoveTransactionsPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          if (!await Transactio.inObstructionumCatenae(
              TransactioGenus.liber, rtpn.identitatum, directorium)) {
            Print.nota(
                nuntius: 'transaction non est inventus in aliquo, caudices',
                message: 'transaction is not found in any of the blocks');
          }
          liberTransactions.removeWhere((lt) => rtpn.identitatum.any(
              (identitatis) =>
                  identitatis == lt.interioreTransactio.identitatis));
          for (String nervusFilim
              in bases.where((n) => !rtpn.accepit.contains(n))) {
            List<String> fissile = nervusFilim.split(':');
            Socket nervus =
                await Socket.connect(fissile[0], int.parse(fissile[1]));
            if (!rtpn.accepit.contains(ip)) {
              rtpn.accepit.add(ip);
            }
            nervus.write(rtpn.indu());
          }
          clientis.destroy();
        } else if (pn.titulus ==
            PervideasNuntiusCasibus.removeFixumTransactions) {
          RemoveTransactionsPervideasNuntius rtpn =
              RemoveTransactionsPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          if (!await Transactio.inObstructionumCatenae(
              TransactioGenus.fixum, rtpn.identitatum, directorium)) {
            Print.nota(
                nuntius: 'transaction non est inventus in aliquo, caudices',
                message: 'transaction is not found in any of the blocks');
          }
          fixumTransactions.removeWhere((ft) => rtpn.identitatum.any(
              (identitatis) =>
                  identitatis == ft.interioreTransactio.identitatis));
          for (String nervusFilim
              in bases.where((n) => !rtpn.accepit.contains(n))) {
            List<String> fissile = nervusFilim.split(':');
            Socket nervus =
                await Socket.connect(fissile[0], int.parse(fissile[1]));
            if (!rtpn.accepit.contains(ip)) {
              rtpn.accepit.add(ip);
            }
            nervus.write(rtpn.indu());
          }
          clientis.destroy();
        } else if (pn.titulus ==
            PervideasNuntiusCasibus.removeExpressiTransactions) {
          RemoveTransactionsPervideasNuntius rtpn =
              RemoveTransactionsPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          expressiTransactions.removeWhere((et) => rtpn.identitatum.any(
              (identitatis) =>
                  identitatis == et.interioreTransactio.identitatis));
          for (String nervusFilim
              in bases.where((n) => !rtpn.accepit.contains(n))) {
            List<String> fissile = nervusFilim.split(':');
            Socket nervus =
                await Socket.connect(fissile[0], int.parse(fissile[1]));
            if (!rtpn.accepit.contains(ip)) {
              rtpn.accepit.add(ip);
            }
            nervus.write(rtpn.indu());
          }
          clientis.destroy();
        } else if (pn.titulus == PervideasNuntiusCasibus.removePropters) {
          RemoveProptersPervideasNuntius rppn =
              RemoveProptersPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          rationibus.removeWhere((p) => rppn.identitatum.any(
              (identiatis) => identiatis == p.interiorePropter.identitatis));
          if (!rppn.accepit.contains(ip)) {
            rppn.accepit.add(ip);
          }
          for (String nervuss
              in bases.where((s) => !rppn.accepit.contains(s))) {
            Socket nervus = await Socket.connect(
                nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write(json.encode(rppn.indu()));
          }
          clientis.destroy();
        } else if (pn.titulus ==
            PervideasNuntiusCasibus.removeConnexaLiberExpressis) {
          RemoveConnexaLiberExpressiPervideasNuntius rclepn =
              RemoveConnexaLiberExpressiPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          connexiaLiberExpressis.removeWhere((cle) => rclepn.identitatum.any(
              (identitatis) =>
                  identitatis ==
                  cle.interioreConnexaLiberExpressi.identitatis));
          if (!rclepn.accepit.contains(ip)) {
            rclepn.accepit.add(ip);
          }
          for (String nervuss
              in bases.where((s) => !rclepn.accepit.contains(s))) {
            Socket nervus = await Socket.connect(
                nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write(json.encode(rclepn.indu()));
          }
        } else if (pn.titulus == PervideasNuntiusTitulus.accipreObstructionum) {
          ObstructionumPervideasNuntius opn = ObstructionumPervideasNuntius.ex(
              json.decode(eventus) as Map<String, dynamic>);
          Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
          List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
          print('tobemoresureexpectedisunexpected');
          print('prioroblocktobeprinted');
          print(prioro.toJson());
          print('listlast');
          print(lo.last.toJson());
          print('isitametteroftime');
          prioro = await Obstructionum.acciperePrior(directorium);
          print(prioro.toJson());
          if (opn.obstructionum.interioreObstructionum.priorProbationem !=
              prioro.probationem) {
            print('wasnotpreviousprobationemno');
            if (!lo.map((mo) => mo.probationem).contains(opn
                    .obstructionum.interioreObstructionum.priorProbationem) &&
                !opn.obstructionum.interioreObstructionum.estFurca) {
              Print.nota(
                  nuntius: 'ignotus obstructionum intra album omnium caudices',
                  message: 'unknown block inside of the list of all blocks');
              return;
            } else if (opn.obstructionum.interioreObstructionum.estFurca) {
              List<String> probationems = [];
              foramenFurca
                  .map((mff) => mff.probationem)
                  .forEach(probationems.add);
              tridentes.map((mt) => mt.probationem).forEach(probationems.add);
              if (!probationems.contains(
                  opn.obstructionum.interioreObstructionum.priorProbationem)) {
                Print.nota(
                    nuntius: 'licet furca obstructionum',
                    message: 'illegal fork block');
                return;
              }
              tridentes.add(opn.obstructionum);
            } else if (lo.map((mo) => mo.probationem).contains(opn.obstructionum.probationem) && !opn.obstructionum.interioreObstructionum.estFurca) {
              print('justvalidatethevalidated');
              List<Obstructionum> loc = lo
                  .takeWhile((two) =>
                      two.interioreObstructionum.priorProbationem !=
                      opn.obstructionum.probationem)
                  .toList();
              loc.removeLast();
              print(loc.map((e) => e.toJson()));
              if (await validateObstructionum(
                  clientis, loc, opn.obstructionum)) {
                clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                        opn.obstructionum,
                        PervideasNuntiusCasibus.obstructionumIsSalvare,
                        opn.accepit)
                    .indu()));
                clientis.destroy();
              }
            } else if (lo.map((mo) => mo.probationem).contains(opn
                    .obstructionum.interioreObstructionum.priorProbationem) &&
                !opn.obstructionum.interioreObstructionum.estFurca) {
              print('howaboutlo');
              print(lo.map((e) => e.toJson()));
              List<Obstructionum> lot = [lo.first];
              print('howaboutloaftertakeone');
              lot.skip(1);
              print(lo.map((e) => e.toJson()));
              lot.addAll(lot.takeWhile((two) =>
                      two.probationem !=
                      opn.obstructionum.interioreObstructionum.priorProbationem));
              print('isprobwrong');
              // loc.removeLast();
              print(lot.map((e) => e.toJson()));
              if (await validateObstructionum(
                  clientis, lot, opn.obstructionum)) {
                clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                        opn.obstructionum,
                        PervideasNuntiusCasibus.obstructionumIsSalvare,
                        opn.accepit)
                    .indu()));
                clientis.destroy();
              }
            } else {
              print('notyethere');
              List<Obstructionum> loc = lo
                  .takeWhile((fwo) =>
                      fwo.probationem ==
                      opn.obstructionum.interioreObstructionum.priorProbationem)
                  .toList();
              loc.add(lo.singleWhere((swo) => loc.last.probationem == swo.interioreObstructionum.priorProbationem));

              if (!await validateObstructionum(
                  clientis, loc, opn.obstructionum)) {
                return;
              }
              foramenFurca.add(opn.obstructionum);
              if (!opn.accepit.contains(ip)) {
                opn.accepit.add(ip);
              }
              for (String nervuss
                  in bases.where((wb) => !opn.accepit.contains(wb))) {
                Socket nervus = await Socket.connect(
                    nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
                nervus.write(json.encode(
                    SatusFurcaPropagationemPervideasNuntius(
                            opn.obstructionum,
                            PervideasNuntiusTitulus.addereForamenFurca,
                            opn.accepit)
                        .indu()));
              }
            }
          } else {
            print('blocklisttobeprinted');
            print(lo.map((o) => o.toJson()).toList());
            if (!await validateObstructionum(clientis, lo, opn.obstructionum)) {
              return;
            }
            print('gotpassedvalidate');
            if (!opn.accepit.contains(ip)) {
              opn.accepit.add(ip);
            }
            clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                    opn.obstructionum,
                    PervideasNuntiusCasibus.obstructionumIsSalvare,
                    opn.accepit)
                .indu()));
            print('sendpermissiontosalvare');
            if (bases.where((wb) => !opn.accepit.contains(wb)).isNotEmpty) {
              for (String nervuss
                  in bases.where((n) => !opn.accepit.contains(n))) {
                Socket nervus = await Socket.connect(
                    nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
                nervus.write(json.encode(ObstructionumPervideasNuntius(
                        opn.obstructionum,
                        PervideasNuntiusTitulus.accipreObstructionum,
                        opn.accepit)
                    .indu()));
                print('sendedblocktrhoughthrough');
                nervus.listen((convalescit) async {
                  print('llisteningtovalidatedbycalidates');
                  ObstructionumSalvarePervideasNuntius ospn =
                      ObstructionumSalvarePervideasNuntius.ex(
                          json.decode(String.fromCharCodes(convalescit).trim())
                              as Map<String, dynamic>);
                  print('nowiwillsalvare');
                  await ospn.obstructionum.salvare(directorium);
                });
              }
            } else {
              print('actuallyreallyornot');
              final random = Random();
              opn.accepit.remove(ip);
              String nervuss = bases[random.nextInt(bases.length)];
              print('thenodetoinspect $nervuss');
              opn.accepit.add(ip);
              Socket nervus = await Socket.connect(
                  nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(ObstructionumPervideasNuntius(
                      opn.obstructionum,
                      PervideasNuntiusTitulus.accipreObstructionum,
                      opn.accepit)
                  .indu()));
              nervus.listen((convalescit) async {
                print('jsutformer');
                ObstructionumSalvarePervideasNuntius ospn =
                    ObstructionumSalvarePervideasNuntius.ex(
                        json.decode(String.fromCharCodes(convalescit).trim())
                            as Map<String, dynamic>);
                print('nowiwillsalvare');
                await ospn.obstructionum.salvare(directorium);
              });
            }
          }
        } else if (pn.titulus == PervideasNuntiusTitulus.addereForamenFurca) {
          SatusFurcaPropagationemPervideasNuntius sfppn =
              SatusFurcaPropagationemPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
          if (!lo
              .map((mo) => mo.probationem)
              .contains(sfppn.obstructionum.probationem)) {
            Print.nota(
                nuntius: 'non iure primo de furca',
                message: 'not a legal begin of a fork');
            return;
          }
          foramenFurca.add(sfppn.obstructionum);
          if (!sfppn.accepit.contains(ip)) {
            sfppn.accepit.add(ip);
          }
          for (String nervuss
              in bases.where((wb) => sfppn.accepit.contains(wb))) {
            Socket nervus = await Socket.connect(
                nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write(json.encode(SatusFurcaPropagationemPervideasNuntius(
                sfppn.obstructionum,
                PervideasNuntiusTitulus.addereForamenFurca,
                sfppn.accepit)));
          }
        }
      });
    });
  }

  void connect(String taberNodi) async {
    bases.add(taberNodi);
    List<String> taberNodifissile = taberNodi.split(':');
    Socket nervus = await Socket.connect(
        taberNodifissile[0], int.parse(taberNodifissile[1]));
    nervus.write(json.encode(UnaBasesSingulasPervideasNuntius(
            ip, PervideasNuntiusCasibus.connectTaberNodi, List<String>.from([]))
        .indu()));
    nervus.listen((data) async {
      print('noproblemtabernodi');
      InConnectPervideasNuntius icpn = InConnectPervideasNuntius.ex(json
          .decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
      if (bases.length < maxPares) {
        bases.addAll(icpn.bases.take((maxPares - bases.length)));
      }
      rationibus.addAll(icpn.rationibus);
      liberTransactions.addAll(icpn.liberTansactions);
      fixumTransactions.addAll(icpn.fixumTransactions);
      expressiTransactions.addAll(icpn.expressiTransactions);
    });
  }

  void sync(bool recentibus) async {
    final random = Random();
    if (recentibus) {
      String nervuss = bases[random.nextInt(bases.length)];
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(PetitioObstructionumIncipioPervideasNuntius(
          PervideasNuntiusCasibus.petitioObstructionumIncipio, [ip]).indu()));
      nervus.listen((eventus) async {
        PervideasNuntius pn = PervideasNuntius.ex(
            json.decode(String.fromCharCodes(eventus)) as Map<String, dynamic>);
        if (pn.titulus == PervideasNuntiusCasibus.obstructionumReponereUna) {
          ObstructionumReponereUnaPervideasNuntius orupn =
              ObstructionumReponereUnaPervideasNuntius.ex(
                  json.decode(String.fromCharCodes(eventus).trim())
                      as Map<String, dynamic>);
          if (orupn.obstructionum.interioreObstructionum.generare ==
              Generare.incipio) {
            print('nowiwillsalvare');
            await orupn.obstructionum.salvareIncipio(directorium);
            nervus.write(json.encode(PetitioObstructionumPervideasNuntius(
                orupn.obstructionum.probationem,
                PervideasNuntiusCasibus.petitioObstructionum, []).indu()));
          } else {
            print('nowiwillsalvare');
            await orupn.obstructionum.salvare(directorium);
            nervus.write(PetitioObstructionumPervideasNuntius(
                orupn.obstructionum.probationem,
                PervideasNuntiusCasibus.petitioObstructionum, []).indu());
          }
        } else if (pn.titulus == PervideasNuntiusCasibus.summaScandalumExNodo) {
          SummaScandalumExNodoPervideasNuntius scenpn =
              SummaScandalumExNodoPervideasNuntius.ex(
                  json.decode(String.fromCharCodes(eventus).trim())
                      as Map<String, dynamic>);
          Print.nota(
              nuntius:
                  'ad summum impedimentum perveneris cum numero ${scenpn.numerus} nodi hodiernae adhuc sync ulteriore si novus clausus additur catenae',
              message:
                  'you have reached the highest block with number ${scenpn.numerus} the current node you will still sync further if a new block is added to the chain');
          nervus.destroy();
        }
      });
    } else {
      Obstructionum prior = await Obstructionum.acciperePrior(directorium);
      String nervuss = bases[random.nextInt(bases.length)];
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(PetitioObstructionumPervideasNuntius(prior.probationem,
          PervideasNuntiusCasibus.petitioObstructionum, []).indu());
      nervus.listen((eventus) async {
        ObstructionumReponereUnaPervideasNuntius orupn =
            ObstructionumReponereUnaPervideasNuntius.ex(
                json.decode(String.fromCharCodes(eventus).trim())
                    as Map<String, dynamic>);
        print('nowiwillsalvare');
        await orupn.obstructionum.salvare(directorium);
        nervus.write(PetitioObstructionumPervideasNuntius(
            orupn.obstructionum.probationem,
            PervideasNuntiusCasibus.petitioObstructionum, []).indu());
      });
    }
  }

  void syncPropter(Propter propter) async {
    if (rationibus.any((p) =>
        p.interiorePropter.identitatis ==
        propter.interiorePropter.identitatis)) {
      rationibus.removeWhere((p) =>
          p.interiorePropter.identitatis ==
          propter.interiorePropter.identitatis);
    }
    rationibus.add(propter);
    for (String nervusString in bases) {
      List<String> nervusStringFissile = nervusString.split(':');
      Socket nervus = await Socket.connect(
          nervusStringFissile[0], int.parse(nervusStringFissile[1]));
      nervus.write(json.encode(PropterPervideasNuntius(
          propter, PervideasNuntiusCasibus.propter, [ip]).indu()));
    }
  }

  void syncLiberTransaction(Transactio tx) async {
    if (liberTransactions.any((t) =>
        t.interioreTransactio.identitatis ==
        tx.interioreTransactio.identitatis)) {
      liberTransactions.removeWhere((t) =>
          t.interioreTransactio.identitatis ==
          tx.interioreTransactio.identitatis);
    }
    // liberTransactions.map((lt) => lt.interioreTransactio. = true);
    liberTransactions.add(tx);
    for (String nervuss in bases.where((b) => !bases.any((aip) => aip == ip))) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(TransactioPervideasNuntius(
          tx, PervideasNuntiusCasibus.liberTransaction, [ip]).indu()));
    }
  }

  void syncFixumTransaction(Transactio tx) async {
    if (fixumTransactions.any((t) =>
        t.interioreTransactio.identitatis ==
        tx.interioreTransactio.identitatis)) {
      fixumTransactions.removeWhere((t) =>
          t.interioreTransactio.identitatis ==
          tx.interioreTransactio.identitatis);
    }
    fixumTransactions.add(tx);
    for (String nervuss in bases.where((b) => !bases.any((aip) => aip == ip))) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(TransactioPervideasNuntius(
          tx, PervideasNuntiusCasibus.fixumTransaction, [ip]).indu()));
    }
  }

  void syncExpressiTransaction(Transactio tx) async {
    if (expressiTransactions.any((t) =>
        t.interioreTransactio.identitatis ==
        tx.interioreTransactio.identitatis)) {
      expressiTransactions.removeWhere((t) =>
          t.interioreTransactio.identitatis ==
          tx.interioreTransactio.identitatis);
    }
    expressiTransactions.add(tx);
    for (String nervuss in bases.where((b) => !bases.any((aip) => aip == ip))) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(TransactioPervideasNuntius(
          tx, PervideasNuntiusCasibus.expressiTransaction, [ip]).indu()));
    }
  }

  // maby avoid checking just check if any and skippi syncing if already is in the list
  void syncConnexaLiberExpressi(ConnexaLiberExpressi clep) async {
    connexiaLiberExpressis.add(clep);
    for (String nervuss in bases.where((b) => !bases.any((aip) => aip == ip))) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(ConnexaLiberExpressiPervideasNuntius(
          clep, PervideasNuntiusCasibus.connexaLiberExpressi, [ip]).indu()));
    }
  }

  void syncSiRemotiones(SiRemotionem sr) async {
    if (siRemotiones.any((asr) =>
        asr.interioreSiRemotionem.identitatisInterioreSiRemotionem ==
        sr.interioreSiRemotionem.identitatisInterioreSiRemotionem)) {
      siRemotiones.removeWhere((rwsr) =>
          rwsr.interioreSiRemotionem.identitatisInterioreSiRemotionem ==
          sr.interioreSiRemotionem.identitatisInterioreSiRemotionem);
    }
    siRemotiones.add(sr);
    for (String nervuss in bases.where((b) => !bases.any((aip) => aip == ip))) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(SiRemotionemPervideasNuntius(
          sr, PervideasNuntiusCasibus.siRemotionemSync, [ip]).indu()));
    }
  }

  void removePropters(List<String> ids) async {
    rationibus.removeWhere(
        (p) => ids.any((i) => i == p.interiorePropter.identitatis));
    for (String nervus in bases) {
      Socket soschock = await Socket.connect(
          nervus.split(':')[0], int.parse(nervus.split(':')[1]));
      soschock.write(json.encode(RemoveProptersPervideasNuntius(
          ids, PervideasNuntiusCasibus.removePropters, [ip]).indu()));
    }
  }

  void removeLiberTransactions(List<String> identitatum) async {
    liberTransactions.removeWhere(
        (l) => identitatum.any((i) => i == l.interioreTransactio.identitatis));
    for (String nervuss in bases) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(RemoveTransactionsPervideasNuntius(
          Exemplar.liber,
          identitatum,
          PervideasNuntiusCasibus.removeTransactions,
          [ip]).indu()));
    }
  }

  void removeFixumTransactions(List<String> identitatum) async {
    fixumTransactions.removeWhere(
        (l) => identitatum.any((i) => i == l.interioreTransactio.identitatis));
    for (String nervuss in bases) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(RemoveTransactionsPervideasNuntius(
          Exemplar.fixum,
          identitatum,
          PervideasNuntiusCasibus.removeTransactions,
          [ip]).indu()));
    }
  }

  void removeExpressiTransactions(List<String> identitatum) async {
    expressiTransactions.removeWhere(
        (l) => identitatum.any((i) => i == l.interioreTransactio.identitatis));
    for (String nervuss in bases) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(RemoveTransactionsPervideasNuntius(
          Exemplar.expressi,
          identitatum,
          PervideasNuntiusCasibus.removeTransactions,
          [ip]).indu()));
    }
  }

  void removeConnexaLiberExpressis(List<String> identitatum) async {
    connexiaLiberExpressis.removeWhere((cle) => identitatum.any((identitatis) =>
        identitatis == cle.interioreConnexaLiberExpressi.identitatis));
    for (String nervuss in bases) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(RemoveConnexaLiberExpressiPervideasNuntius(
          identitatum,
          PervideasNuntiusCasibus.removeConnexaLiberExpressis,
          [ip]).indu()));
    }
  }

  void syncBlock(Obstructionum o) async {
    List<String> accepit = bases;
    accepit.add(ip);
    List<Socket> lsn = [];
    for (String nervuss in bases.where((wb) => wb != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(ObstructionumPervideasNuntius(
              o, PervideasNuntiusTitulus.accipreObstructionum, accepit)
          .indu()));
      lsn.add(nervus);
      Print.nota(
          message:
              'sended block with number: ${o.interioreObstructionum.obstructionumNumerus} across the network',
          nuntius:
              'misit obstructionum cum numero: ${o  .interioreObstructionum.obstructionumNumerus} per network');

      nervus.listen((eventus) async {
        print('passedallvalidations');
        PervideasNuntius pn = PervideasNuntius.ex(
            json.decode(String.fromCharCodes(eventus).trim())
                as Map<String, dynamic>);
        if (pn.titulus == PervideasNuntiusCasibus.obstructionumIsSalvare) {
          print('wentintosalvare');
          ObstructionumSalvarePervideasNuntius oispn =
              ObstructionumSalvarePervideasNuntius.ex(
                  json.decode(String.fromCharCodes(eventus).trim())
                      as Map<String, dynamic>);
          print('nowiwillsalvare');
          isSalvare = true;
          await oispn.obstructionum.salvare(directorium);
          isSalvare = false;
          print('savedforsure');
          for (Socket td in lsn) {
            td.destroy();
          }
        } else if (pn.titulus == PervideasNuntiusCasibus.subter) {
          PetitioSummumObsturctionumProbationemPervideasNuntius psoppn =
              PetitioSummumObsturctionumProbationemPervideasNuntius.ex(
                  json.decode(String.fromCharCodes(eventus).trim())
                      as Map<String, dynamic>);
          List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
          List<String> documenta = obss.map((e) => e.probationem).toList();
          for (int i = documenta.length; i >= 0; i--) {
            for (int ii = 0; ii < psoppn.documenta.length; ii++) {
              if (documenta[i] != psoppn.documenta[ii]) {
                continue;
              } else {
                nervus.write(PetitioObstructionumPervideasNuntius(documenta[i],
                    PervideasNuntiusCasibus.petitioObstructionum, []).indu());
              }
            }
          }
        } else if (pn.titulus ==
            PervideasNuntiusCasibus.obstructionumReponereUna) {
          ObstructionumReponereUnaPervideasNuntius orupn =
              ObstructionumReponereUnaPervideasNuntius.ex(
                  json.decode(String.fromCharCodes(eventus).trim())
                      as Map<String, dynamic>);
          print('nowiwillsalvare');
          await orupn.obstructionum.salvare(directorium);
          nervus.write(PetitioObstructionumPervideasNuntius(
              orupn.obstructionum.probationem,
              PervideasNuntiusCasibus.petitioObstructionum, []).indu());
        }
      });
    }
  }

  Future syncThrough(List<String> accepit, Transactio transactio) async {
    // ppn.accepit.add(ip);
    for (String nervusFilim in bases.where((n) => !accepit.contains(n))) {
      List<String> fissile = nervusFilim.split(':');
      Socket nervus = await Socket.connect(fissile[0], int.parse(fissile[1]));
      nervus.write(json.encode(TransactioPervideasNuntius(
          transactio, PervideasNuntiusCasibus.accepit, accepit)));
    }
  }

  List<ConnexaLiberExpressi> invenireConnexaLiberExpressis(
      List<String> liberIdentitatum) {
    return connexiaLiberExpressis
        .where((cle) => liberIdentitatum.any(
            (li) => li == cle.interioreConnexaLiberExpressi.liberIdentitatis))
        .toList();
  }

  Future<bool> validateObstructionum(Socket clientis, List<Obstructionum> lo,
      Obstructionum obstructionum) async {
    Obstructionum incipio = await Obstructionum.accipereIncipio(directorium);
    Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
    if (!obstructionum.isProbationem()) {
      Print.nota(
          nuntius:
              'Hashing in obstructionum non propono in probationem vel obstructionum Nullam',
          message:
              'Hashing the block does not resolve into the proof or block hash');
      return false;
    }
    if (obstructionum.interioreObstructionum.divisone() <
        prioro.interioreObstructionum.divisa && obstructionum.interioreObstructionum.estFurca) {
      Obstructionum? summum = lo.singleWhereOrNull((swono) =>
          swono.probationem ==
          obstructionum.interioreObstructionum.priorProbationem);
      if (summum == null) {
        Print.nota(
            nuntius:
                'invalidum est divisio quia non prior matching obstructionum est inventus',
            message:
                'invalid division because no previous matching block is found');
        return false;
      } else {
        Obstructionum.removereUsqueAd(
            summum.probationem, directorium); // send message and sync
      }
    }
    List<String> fixum = [];
    for (Transactio lt
        in obstructionum.interioreObstructionum.liberTransactions) {
      if (lt.interioreTransactio.transactioSignificatio !=
          TransactioSignificatio.praemium) {
        if (!await lt.convalidandumTransaction(
                obstructionum.interioreObstructionum.producentis,
                TransactioGenus.liber,
                lo) ||
            lt.isFurantur()) {
          Print.nota(
              nuntius:
                  'obstructionum ineuntes continet vestra corrumpere transactions',
              message: 'your incoming block contains corrupt transactions');
          return false;
        }
      } else {
        // to inspect
        lt.validateBlockreward();
      }
    }
    for (Transactio ft
        in obstructionum.interioreObstructionum.fixumTransactions) {
      if (!await ft.convalidandumTransaction(null, TransactioGenus.fixum, lo) ||
          ft.isFurantur()) {
        Print.nota(
            nuntius:
                'obstructionum ineuntes continet vestra corrumpere transactions',
            message: 'your incoming block contains corrupt transactions');
        return false;
      }
    }
    for (Transactio et
        in obstructionum.interioreObstructionum.expressiTransactions) {
      if (!await et.convalidandumTransaction(
              null, TransactioGenus.expressi, lo) ||
          et.isFurantur()) {
        Print.nota(
            nuntius:
                'obstructionum ineuntes continet vestra corrumpere transactions',
            message: 'your incoming block contains corrupt transactions');
        return false;
      }
    }
    switch (obstructionum.interioreObstructionum.generare) {
      case Generare.incipio:
        {
          Print.nota(
              nuntius: 'Ineuntes scandalum non attigit hanc',
              message: 'the incoming block should not have reached this state');
          return false;
        }
      case Generare.expressi:
      case Generare.confussus:
        {
          if (prioro.interioreObstructionum.generare == Generare.expressi) {
            Print.nota(
                nuntius: 'non duo expressi cursus sustentabatur',
                message: 'cannot produce two expressi blocks in a row');
            return false;
          }
          if (await Obstructionum.gladiatorConfodiantur(
              obstructionum.interioreObstructionum.gladiator.interioreGladiator
                  .input!.gladiatorIdentitatis,
              obstructionum.interioreObstructionum.producentis,
              lo)) {
            Print.nota(
                nuntius: 'clausus potest non oppugnare publica clavem',
                message: 'block can not attack the same public key');
            return false;
          }
          if (!await obstructionum.convalidandumTransform(lo)) {
            Print.nota(
                nuntius: 'licet transformatio liber ad fixum',
                message: 'illegal transform of liber to fixum');
            return false;
          }
          if (!await obstructionum.vicit(lo)) {
            Print.nota(
                nuntius: 'nullum signum gladiatorium pugnae',
                message: 'invalid signature of gladiator battle');
            return false;
          }
    
          // hmm
          if (!await obstructionum.convalidandumObsturcutionumNumerus(
              prioro, prioro)) {
            Print.nota(
                nuntius:
                    'Mittens huius obstructionum conatur cibum usque ad numerum obstructionum',
                message:
                    'the sender of this block is trying to mess up the block number');
            return false;
          }
          break;
        }
      case Generare.efectus:
        if (!await obstructionum.validatePraemium(incipio)) {
          Print.nota(
              nuntius:
                  'hoc est Mittens obstructionum praemia corrupta est obstructionum',
              message: 'the sender of this block has corrupted block rewards');
          return false;
        }
        if (!await obstructionum.convalidandumObsturcutionumNumerus(
            incipio, prioro)) {
          Print.nota(
              nuntius:
                  'Mittens huius obstructionum conatur cibum usque ad numerum obstructionum',
              message:
                  'the sender of this block is trying to mess up the block number');
          return false;
        }
      default:
        {
          Print.nota(
              nuntius:
                  'in ineuntes obstructionum conatur facere aliquid illicitum',
              message:
                  'in ineuntes obstructionum conatur facere aliquid illicitum');
          return false;
        }
    }
    switch (await Obstructionum.estVerum(
        obstructionum.interioreObstructionum, lo)) {
      case Corrumpo.forumCap:
        {
          Print.nota(
              nuntius: 'pecunia corrumpitur a mittente hoc scandalum',
              message:
                  'total amount of money is corrupt from the sender of this block');
          return false;
        }
      case Corrumpo.summaDifficultas:
        {
          Print.nota(
              nuntius: 'tota difficultas corrumpitur a mittente hoc scandalum',
              message: 'tota difficultas corrumpitur a mittente hoc scandalum');
          return false;
        }
      case Corrumpo.numerus:
        Print.nota(
            nuntius:
                'scandalum numerus est corruptus ab mittente hoc scandalum',
            message:
                'the block number is corrupt from the sender of this block');
        return false;
      case Corrumpo.divisa:
        Print.nota(
            nuntius: 'corrupta est divisio a mittente hoc scandalum',
            message: 'the division is corrupt from the sender of this block');
        return false;
      case Corrumpo.legalis:
        break;
    }
    switch (Obstructionum.fortiorEst(
        obstructionum.interioreObstructionum, prioro)) {
      case QuidFacere.solitum:
        {
          print(' butofcourse');
          if (!Obstructionum.nonFortum(
                  obstructionum.interioreObstructionum.liberTransactions) &&
              !Obstructionum.nonFortum(
                  obstructionum.interioreObstructionum.fixumTransactions)) {
            Print.nota(
                nuntius: 'producens ad vos suscepit conatur furantur pecuniam',
                message:
                    'the producer of the block you recieved is trying to steal money');
            return false;
          }
          List<TransactioOutput> outputs = [];
          obstructionum.interioreObstructionum.liberTransactions
              .where((lt) =>
                  lt.interioreTransactio.transactioSignificatio !=
                      TransactioSignificatio.praemium &&
                  lt.interioreTransactio.transactioSignificatio !=
                      TransactioSignificatio.ardeat)
              .map((lt) => lt.interioreTransactio.outputs)
              .forEach(outputs.addAll);
          if (!await Transactio.omnesClavesPublicasDefendi(outputs, lo)) {
            Print.nota(
                nuntius: 'non omnes claves publicae defenduntur',
                message: 'not all public keys are defended');
            return false;
          }
          if (obstructionum.interioreObstructionum.generare ==
                  Generare.confussus ||
              obstructionum.interioreObstructionum.generare ==
                  Generare.expressi) {
            List<TransactioInput> tis = [];
            obstructionum.interioreObstructionum.liberTransactions
                .where((lt) =>
                    lt.interioreTransactio.transactioSignificatio ==
                    TransactioSignificatio.ardeat)
                .map((lt) => lt.interioreTransactio.inputs)
                .forEach(tis.addAll);
            if (!await Transactio.validateArdeat(tis, lo)) {
              Print.nota(
                  nuntius: 'corrumpere ardeat victos',
                  message: 'corrupt burn of the losers');
              return false;
            }
          }
        }
      case QuidFacere.subter:
        {
          // opn.accepit.add(ip);
          // List<Obstructionum> obsss =
          //     await Obstructionum.getBlocks(directorium);
          // List<String> documenta =
          //     obsss.reversed.map((obs) => obs.probationem).take(763).toList();
          // clientis.write(PetitioSummumObsturctionumProbationemPervideasNuntius(
          //     ip,
          //     documenta,
          //     PervideasNuntiusCasibus.petitioSummumObsturctionumProbationem,
          //     opn.accepit));
        }
      case QuidFacere.corrupt:
        print('indeednocommunt');
        return false;
      default:
        print('echtwaar');
        return false;
    }
    return true;
  }
}
