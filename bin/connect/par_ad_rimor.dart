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
import '../exempla/solucionis_propter.dart';
import '../exempla/transactio.dart';
import '../exempla/utils.dart';
import 'package:collection/collection.dart';
import 'package:elliptic/elliptic.dart';
import '../server.dart';

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

class PetitioExpressiTransactioPervideasNuntius extends PervideasNuntius {
  PetitioExpressiTransactioPervideasNuntius(String titulus, List<String> accepit): super(titulus, accepit);
  PetitioExpressiTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius): super.ex(nuntius);
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}
class DareExpressiTransactioPervideasNuntius extends PervideasNuntius {
  Transactio transactio;
  DareExpressiTransactioPervideasNuntius(this.transactio, String titulus, List<String> accepit): super(titulus, accepit);
  DareExpressiTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius): 
  transactio = Transactio.fromJson(nuntius[PervideasNuntiusCasibus.transactio] as Map<String, dynamic>),
  super.ex(nuntius);
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

class SolucionisPropterPervideasNuntius extends PervideasNuntius {
  SolucionisPropter solucionisPropter;
  SolucionisPropterPervideasNuntius(this.solucionisPropter, String titulus, List<String> accepit): super(titulus, accepit);
  SolucionisPropterPervideasNuntius.ex(Map<String, dynamic> nuntius): solucionisPropter = SolucionisPropter.fromJson(nuntius[PervideasNuntiusCasibus.solucionisPropter] as Map<String, dynamic>), super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.solucionisPropter: solucionisPropter.toJson(),
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}
class FissileSolucionisPropterPervideasNuntius extends PervideasNuntius {
  FissileSolucionisPropter fissileSolucionisPropter;
  FissileSolucionisPropterPervideasNuntius(this.fissileSolucionisPropter, String titulus, List<String> accepit): super(titulus, accepit);
  FissileSolucionisPropterPervideasNuntius.ex(Map<String, dynamic> nuntius): fissileSolucionisPropter = FissileSolucionisPropter.fromJson(nuntius[PervideasNuntiusCasibus.solucionisPropter] as Map<String, dynamic>), super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.solucionisPropter: fissileSolucionisPropter.toJson(),
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

// enum Exemplar { liber, expressi, fixum }

// extension ExemplarFromJson on Exemplar {
//   static fromJson(String name) {
//     switch (name) {
//       case 'liber':
//         return Exemplar.liber;
//       case 'expressi':
//         return Exemplar.expressi;
//       case 'fixum':
//         return Exemplar.fixum;
//     }
//   }
// }

class RemoveByIdentitatumPervideasNuntius extends PervideasNuntius {
  List<String> identitatum;
  RemoveByIdentitatumPervideasNuntius(this.identitatum, String titulus, List<String> accepit): super(titulus, accepit);
  RemoveByIdentitatumPervideasNuntius.ex(Map<String, dynamic> nuntius): identitatum = List<String>.from(nuntius[PervideasNuntiusCasibus.identitatum] as List<dynamic>), super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.identitatum: identitatum,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
  };
}
class RemoveTransactionsPervideasNuntius extends PervideasNuntius {
  TransactioGenus transactioGenus;
  List<String> identitatum;
  RemoveTransactionsPervideasNuntius(
      this.transactioGenus, this.identitatum, String titulust, List<String> accepit)
      : super(titulust, accepit);
  RemoveTransactionsPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : transactioGenus =
            TransactioGenusFromJson.fromJson(nuntius[PervideasNuntiusCasibus.transactioGenus])
                as TransactioGenus,
        identitatum = List<String>.from(
            nuntius[PervideasNuntiusCasibus.identitatum] as List<dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.transactioGenus: transactioGenus.name.toString(),
    PervideasNuntiusCasibus.identitatum: identitatum,
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}

class SumoTransactionsPervideasNuntius extends PervideasNuntius {
  TransactioGenus transactioGenus;
  List<String> identitatum;
  SumoTransactionsPervideasNuntius(this.transactioGenus, this.identitatum, String titulust, List<String> accepit): super(titulust, accepit);
  SumoTransactionsPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : transactioGenus =
            TransactioGenusFromJson.fromJson(nuntius[PervideasNuntiusCasibus.transactioGenus].toString())
                as TransactioGenus,
        identitatum = List<String>.from(
            nuntius[PervideasNuntiusCasibus.identitatum] as List<dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.transactioGenus: transactioGenus.name.toString(),
    PervideasNuntiusCasibus.identitatum: identitatum,
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
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
  bool isRemove = false;
  bool isLiber = false;
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
  List<SolucionisPropter> solucionisRationibus = [];
  List<FissileSolucionisPropter> fissileSolucionisRationibus = [];
  List<Obstructionum> foramenFurca = [];
  List<Obstructionum> tridentes = [];
  List<Isolate> syncBlocks = [];

  List<String> epistulae = [];
  bool occupatus = false;
  ParAdRimor(this.maxPares, this.ip, this.directorium);

  audite() async {
    List<String> sip = ip.split(':');
    ServerSocket serverNervum =
        await ServerSocket.bind(sip[0], int.parse(sip[1]));
    serverNervum.listen((clientis) {
      utf8.decoder.bind(clientis).listen((nuntius) async {
        Print.nota(
            nuntius: 'pervideas ut pari servo suscepit nuntium on $ip',
            message: 'peer to peer server recieved a message on $ip');
        epistulae.add(nuntius);
        print('contentofmsginpool $nuntius');
        print('fifo ${epistulae.first}');
        while (occupatus || isSalvare) {
          await Future.delayed(Duration(seconds: 1));
        }
        occupatus = true;
        String eventus = epistulae.removeAt(0);
        PervideasNuntius pn =
            PervideasNuntius.ex(json.decode(eventus) as Map<String, dynamic>);
        // while (isSalvare) {
        //   await Future.delayed(Duration(milliseconds: 100));
        // }
        switch (pn.titulus) {
          case PervideasNuntiusTitulus.connectTaberNodi: {
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
                titulus: PervideasNuntiusTitulus.onConnect,
                accepit: List<String>.from([ip])).indu()));
            for (String nervuss
                in bases.where((wb) => !ubs.accepit.contains(wb))) {
              Socket nervus = await Socket.connect(
                  nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(UnaBasesSingulasPervideasNuntius(
                  nervuss,
                  PervideasNuntiusTitulus.singleSocket,
                  List<String>.from([ip])).indu()));
            }
            if (bases.length < maxPares &&
                !bases.contains(ubs.nervus) &&
                ip != ubs.nervus) {
              bases.add(ubs.nervus);
            }
            clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.singleSocket: {
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
                      nervuss, PervideasNuntiusTitulus.singleSocket, ubs.accepit)
                  .indu()));
            }
            clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.petitioObstructionumIncipio: {
            PetitioObstructionumIncipioPervideasNuntius poipn =
              PetitioObstructionumIncipioPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
            List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
            if (!poipn.accepit.contains(ip)) {
              poipn.accepit.add(ip);
            }
            clientis.write(json.encode(ObstructionumReponereUnaPervideasNuntius(
                    obss[0],
                    PervideasNuntiusTitulus.obstructionumReponereUna,
                    poipn.accepit)
                .indu()));
            print('waitingtobedestroyed');
            break;
          }
          case PervideasNuntiusTitulus.petitioObstructionum: {
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
                  PervideasNuntiusTitulus.summaScandalumExNodo, []).indu()));
              clientis.destroy();
              print('ididdestroymyclient!');
            } else {
              clientis.write(json.encode(ObstructionumReponereUnaPervideasNuntius(
                      obs, PervideasNuntiusTitulus.obstructionumReponereUna, [])
                  .indu()));
            }
            break;
          }
          case PervideasNuntiusTitulus.propter: {
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
                        ppn.propter, PervideasNuntiusTitulus.propter, ppn.accepit)
                    .indu()));
              }
              clientis.destroy();
            }
            break;
          }
          case PervideasNuntiusTitulus.prepareObstructionumSync: {
            List<String> albumBases = bases;
            albumBases.removeWhere((lb) => pn.accepit.contains(lb));
            clientis.write(json.encode(PrepareObstructionumAnswerPervideasNuntius(
                albumBases,
                PervideasNuntiusTitulus.prepareObstructionumAnswer, [])));
            clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.liberTransactio: {
            LiberTransactioPervideasNuntius ltpn =
              LiberTransactioPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            List<Transactio> ltc = List<Transactio>.from(liberTransactions.map((mlt) => Transactio.fromJson(mlt.toJson())));
            ltc.add(ltpn.transactio);
            if (await convalidandumLiber(ltc, lo)) {
              if (liberTransactions.any((alt) =>
                  alt.interioreTransactio.identitatis ==
                  ltpn.transactio.interioreTransactio.identitatis)) {
                print('didhadtoremove');
                liberTransactions.removeWhere((rwlt) =>
                    rwlt.interioreTransactio.identitatis ==
                    ltpn.transactio.interioreTransactio.identitatis);
              }
              liberTransactions.add(ltpn.transactio);
              // if (!expressiTransactions.any((aet) => aet.interioreTransactio.inputs.any((ei) => ei.transactioIdentitatis == ltpn.transactio.interioreTransactio.identitatis) && (ltpn.transactio.interioreTransactio.transactioSignificatio == TransactioSignificatio.regularis || ltpn.transactio.interioreTransactio.transactioSignificatio == TransactioSignificatio.refugium))) {
              //   print('ithinkiwrote');
              //   clientis.write(json.encode(PetitioExpressiTransactioPervideasNuntius(PervideasNuntiusTitulus.petitioExpressiTransactio, pn.accepit).indu()));
              // }
              if (!pn.accepit.contains(ip)) {
                pn.accepit.add(ip);
              }
              syncThrough(TransactioGenus.liber, ltpn.transactio, pn.accepit);
            }
            break;
          }
          case PervideasNuntiusTitulus.fixumTransactio: {
            // FixumTransactioPervideasNuntius ftpn =
            //   FixumTransactioPervideasNuntius.ex(
            //       json.decode(eventus) as Map<String, dynamic>);
            // List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            // if (await ftpn.transactio
            //         .convalidandumTransaction(null, TransactioGenus.fixum, fixumTransactions, lo) &&
            //     ftpn.transactio.isFurantur() &&
            //     !ftpn.transactio.validateProbationem() && ftpn.transactio.minusQuamBidInProbationibus(fixumTransactions, lo)) {
            //   if (fixumTransactions.any((aft) =>
            //       aft.interioreTransactio.identitatis ==
            //       ftpn.transactio.interioreTransactio.identitatis)) {
            //     fixumTransactions.removeWhere((rwft) =>
            //         rwft.interioreTransactio.identitatis ==
            //         ftpn.transactio.interioreTransactio.identitatis);
            //   }
            //   fixumTransactions.add(ftpn.transactio);
            //   if (!pn.accepit.contains(ip)) {
            //     pn.accepit.add(ip);
            //   }
            //   syncThrough(TransactioGenus.fixum, ftpn.transactio, pn.accepit);
            // }
            // break;
          }
          case PervideasNuntiusTitulus.expressiTransactio: {
        
            ExpressiTransactioPervideasNuntius etpn =
                ExpressiTransactioPervideasNuntius.ex(
                    json.decode(eventus) as Map<String, dynamic>);
            
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            List<Transactio> stagnum = [];
            stagnum.addAll(liberTransactions);
            stagnum.addAll(expressiTransactions);
            if (await convalidandumLiber(stagnum, lo)) {
              if (expressiTransactions.any((aet) =>
                  aet.interioreTransactio.identitatis ==
                  etpn.transactio.interioreTransactio.identitatis)) {
                expressiTransactions.removeWhere((rwet) =>
                    rwet.interioreTransactio.identitatis ==
                    etpn.transactio.interioreTransactio.identitatis);
              }
              expressiTransactions.add(etpn.transactio);
              if (!pn.accepit.contains(ip)) {
                pn.accepit.add(ip);
              }
              syncThrough(TransactioGenus.expressi, etpn.transactio, etpn.accepit);
            }
            break;
          }
          case PervideasNuntiusTitulus.connexaLiberExpressi: {
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
            break;
          }
          case PervideasNuntiusTitulus.siRemotionem: {
            SiRemotionemPervideasNuntius srpn = SiRemotionemPervideasNuntius.ex(
              json.decode(eventus) as Map<String, dynamic>);
            if (srpn.siRemotionem.interioreSiRemotionem.siRemotionemInput ==
                null) {
              if (srpn.siRemotionem.validateProbationem() &&
                  srpn.siRemotionem.interioreSiRemotionem.cognoscereOutput() &&
                  await srpn.siRemotionem.remotumEst() &&
                  await srpn.siRemotionem.nonHabetInitus()) {
                await siRemotionemSyncThrough(srpn);
                print('ifvalidated');
                clientis.destroy();
              } else {
                Print.nota(
                    nuntius:
                        'Mittens huius obstructionum continet rem probationem turpis rommovetur',
                    message:
                        'The sender of this contains proof of the fact that it will be removed');
              }
            } else {
              List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
              if (
                srpn.siRemotionem.interioreSiRemotionem.siRemotionemInput!.cognoscere(lo) && 
              lo.any((ao) => ao.interioreObstructionum.siRemotiones.any((asr) => asr.interioreSiRemotionem.identitatisInterioreSiRemotionem == srpn.siRemotionem.interioreSiRemotionem.siRemotionemInput!.siRemotionemIdentiatis)) &&
              srpn.siRemotionem.interioreSiRemotionem.siRemotionemInput!.solvitStagnum(srpn.siRemotionem.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!, lo)
              ) {
                await siRemotionemSyncThrough(srpn);
                clientis.destroy();

              }
            }
            break;
          }
          case PervideasNuntiusTitulus.solucionisPropter: {
            SolucionisPropterPervideasNuntius sppn = SolucionisPropterPervideasNuntius.ex(json.decode(eventus) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            if (!sppn.solucionisPropter.interioreSolucionisPropter.estValidus(lo)) {
              return;
            }
            if (solucionisRationibus.any((asr) => asr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sppn.solucionisPropter.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis)) {
              solucionisRationibus.removeWhere((rwsr) => rwsr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sppn.solucionisPropter.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis); 
            }
            solucionisRationibus.add(sppn.solucionisPropter);
            if (!sppn.accepit.contains(ip)) {
              sppn.accepit.add(ip);
            }
            for (String nervuss in bases.where((wb) => !sppn.accepit.contains(wb))) {
              Socket nervus = await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(sppn.indu()));
              nervus.destroy();
            }
            break;
          }
          case PervideasNuntiusTitulus.fissileSolucionisPropter: {
            FissileSolucionisPropterPervideasNuntius fsppn = FissileSolucionisPropterPervideasNuntius.ex(json.decode(eventus) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            if (!fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.estValidus(lo)) {
              return;
            }
            fissileSolucionisRationibus.add(fsppn.fissileSolucionisPropter);
            if (!fsppn.accepit.contains(ip)) {
              fsppn.accepit.add(ip);
            }
            for (String nervuss in bases.where((wb) => !fsppn.accepit.contains(wb))) {
              Socket nervus = await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(fsppn.indu()));
              nervus.destroy();
            }
            break;
          }
          case PervideasNuntiusTitulus.removeTransactions: {
            isRemove = true;
          RemoveTransactionsPervideasNuntius rtpn =
              RemoveTransactionsPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
          List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
          if (!await Transactio.inObstructionumCatenae(
              rtpn.transactioGenus, rtpn.identitatum, lo) && 
              !rtpn.identitatum.every((ei) => liberTransactions.any((alt) => alt.interioreTransactio.identitatis == ei)) && 
              !rtpn.identitatum.every((ei) => fixumTransactions.any((alt) => alt.interioreTransactio.identitatis == ei)) &&
              !rtpn.identitatum.every((ei) => expressiTransactions.any((alt) => alt.interioreTransactio.identitatis == ei))) {

            print('theidentitatums ${rtpn.identitatum}');
            print('andthefullmsg\n');
            print(rtpn.indu());
            print('whatsuplistofblocks\n');
            print(lo.map((e) => e.toJson()));

            print('lastforno\n');
            print(lo.last.toJson());
            Print.nota(
                nuntius: 'transaction non est inventus in aliquo, caudices',
                message: 'transaction is not found in any of the blocks');
            return;
          }
          switch (rtpn.transactioGenus) {
            case TransactioGenus.liber: {
              liberTransactions.removeWhere((lt) => rtpn.identitatum.any(
              (identitatis) =>
                  identitatis == lt.interioreTransactio.identitatis));
              break;
            }
            case TransactioGenus.fixum: {
              fixumTransactions.removeWhere((ft) => rtpn.identitatum.any(
              (identitatis) =>
                  identitatis == ft.interioreTransactio.identitatis));
              break;
            }
            case TransactioGenus.expressi: {
              expressiTransactions.removeWhere((et) => rtpn.identitatum.any(
              (identitatis) =>
                  identitatis == et.interioreTransactio.identitatis));
              break;
            }
          }
          if (!rtpn.accepit.contains(ip)) {
              rtpn.accepit.add(ip);
          }
          for (String nervusFilim
              in bases.where((n) => !rtpn.accepit.contains(n))) {
            List<String> fissile = nervusFilim.split(':');
            Socket nervus =
                await Socket.connect(fissile[0], int.parse(fissile[1]));
            nervus.write(json.encode(rtpn.indu()));
          }
          isRemove = false;
          clientis.destroy();
          break;
          }
          // case PervideasNuntiusTitulus.sumoTransactions: {
          //   while (isRemove) {
          //   await Future.delayed(Duration(milliseconds:  100));
          //   }
          //   SumoTransactionsPervideasNuntius stpn = SumoTransactionsPervideasNuntius.ex(json.decode(eventus) as Map<String, dynamic>);
          //   switch (stpn.transactioGenus) {
          //     case TransactioGenus.liber: {
          //       for (Transactio t in liberTransactions.where((wlt) => !wlt.capta && stpn.identitatum.any((ai) => ai == wlt.interioreTransactio.identitatis))) {
          //         t.capta = true;
          //       }
          //       break;
          //     }
          //     case TransactioGenus.fixum: {
          //       for (Transactio t in fixumTransactions.where((wlt) => !wlt.capta && stpn.identitatum.any((ai) => ai == wlt.interioreTransactio.identitatis))) {
          //         t.capta = true;
          //       }
          //       break;
          //     }
          //     case TransactioGenus.expressi: {
          //       for (Transactio t in expressiTransactions.where((wlt) => !wlt.capta && stpn.identitatum.any((ai) => ai == wlt.interioreTransactio.identitatis))) {
          //         t.capta = true;
          //       }
          //       break;
          //     }
          //   }
          //   if (!stpn.accepit.contains(ip)) {
          //     stpn.accepit.add(ip);
          //   }
          //   for (String nervuss
          //       in bases.where((s) => !stpn.accepit.contains(s))) {
          //     Socket nervus = await Socket.connect(
          //         nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
          //     nervus.write(json.encode(stpn.indu()));
          //   }
          //   clientis.destroy();
          //   break;
          // }
          case PervideasNuntiusTitulus.removePropters: {
            RemoveByIdentitatumPervideasNuntius rbipn =
              RemoveByIdentitatumPervideasNuntius.ex(
                  json.decode(eventus) as Map<String, dynamic>);
            rationibus.removeWhere((p) => rbipn.identitatum.any(
                (identiatis) => identiatis == p.interiorePropter.identitatis));
            if (!rbipn.accepit.contains(ip)) {
              rbipn.accepit.add(ip);
            }
            for (String nervuss
                in bases.where((s) => !rbipn.accepit.contains(s))) {
              Socket nervus = await Socket.connect(
                  nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(rbipn.indu()));
            }
            clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.removeConnexaLiberExpressis: {
            RemoveByIdentitatumPervideasNuntius rbipn =
                RemoveByIdentitatumPervideasNuntius.ex(
                    json.decode(eventus) as Map<String, dynamic>);
            connexiaLiberExpressis.removeWhere((cle) => rbipn.identitatum.any(
                (identitatis) =>
                    identitatis ==
                    cle.interioreConnexaLiberExpressi.identitatis));
            if (!rbipn.accepit.contains(ip)) {
              rbipn.accepit.add(ip);
            }
            for (String nervuss
                in bases.where((s) => !rbipn.accepit.contains(s))) {
              Socket nervus = await Socket.connect(
                  nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(rbipn.indu()));
            }
            clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.removeSiRemotionems: {
            RemoveByIdentitatumPervideasNuntius rbipn =
                RemoveByIdentitatumPervideasNuntius.ex(
                    json.decode(eventus) as Map<String, dynamic>);
            siRemotiones.removeWhere((rwsr) => rbipn.identitatum.any((ai) =>
                ai ==
                rwsr.interioreSiRemotionem.identitatisInterioreSiRemotionem));
            if (!rbipn.accepit.contains(ip)) {
              rbipn.accepit.add(ip);
            }
            for (String nervuss
                in bases.where((s) => !rbipn.accepit.contains(s))) {
              Socket nervus = await Socket.connect(
                  nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(rbipn.indu()));
            }
            clientis.destroy();
            break;
          }           
          case PervideasNuntiusTitulus.removeSolucionisRationibus: {
            RemoveByIdentitatumPervideasNuntius rbipn = RemoveByIdentitatumPervideasNuntius.ex(json.decode(eventus) as Map<String, dynamic>);
            solucionisRationibus.removeWhere((rwsr) => rbipn.identitatum.any((ai) => ai == rwsr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis));
            if (!rbipn.accepit.contains(ip)) {
              rbipn.accepit.add(ip);
            }
            for (String nervuss
                in bases.where((s) => !rbipn.accepit.contains(s))) {
              Socket nervus = await Socket.connect(
                  nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(rbipn.indu()));
            }
            clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.removeFissileSolucionisRationibus: {
            RemoveByIdentitatumPervideasNuntius rbipn = RemoveByIdentitatumPervideasNuntius.ex(json.decode(eventus) as Map<String, dynamic>);
            fissileSolucionisRationibus.removeWhere((rwsr) => rbipn.identitatum.any((ai) => ai ==rwsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis));
            if (!rbipn.accepit.contains(ip)) {
              rbipn.accepit.add(ip);
            }
            for (String nervuss
                in bases.where((s) => !rbipn.accepit.contains(s))) {
              Socket nervus = await Socket.connect(
                  nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(rbipn.indu()));
            }
            clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.accipreObstructionum: {
            ObstructionumPervideasNuntius opn = ObstructionumPervideasNuntius.ex(
              json.decode(eventus) as Map<String, dynamic>);
            Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            print('accipereobstructionum with priorprob ${opn.obstructionum.interioreObstructionum.priorProbationem} and highest block ${prioro.toJson()}');
            print('whydidlonothaveit ordidithaveitthough and is it some weird removal \n ${lo.last.toJson()}');
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
              } else if (opn.obstructionum.interioreObstructionum.estFurca &&
                  foramenFurca.map((mff) => mff.probationem).contains(opn
                      .obstructionum.interioreObstructionum.priorProbationem)) {
                print('wwentintofurcatrueandforamenfurcacontains');
                Obstructionum ffi = foramenFurca.singleWhere((swff) =>
                    swff.probationem ==
                    opn.obstructionum.interioreObstructionum.priorProbationem);
                do {
                  lo.removeLast();
                } while (lo.last.probationem !=
                    ffi.interioreObstructionum.priorProbationem);
                lo.add(ffi);
                if (await validateObstructionum(
                    clientis, lo, opn.obstructionum)) {
                  tridentes.add(opn.obstructionum);
                  if (opn.obstructionum.interioreObstructionum.divisa <
                          prioro.interioreObstructionum.divisa &&
                      opn.obstructionum.interioreObstructionum
                              .summaObstructionumDifficultas >
                          prioro.interioreObstructionum
                              .summaObstructionumDifficultas) {
                    await Obstructionum.removereUsqueAd(ffi, directorium);
                    await ffi.salvare(directorium);
                    await opn.obstructionum.salvare(directorium);
                  }
                  if (!opn.accepit.contains(ip)) {
                    opn.accepit.add(ip);
                  }
                  clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                          opn.obstructionum,
                          PervideasNuntiusTitulus.obstructionumIsSalvare,
                          opn.accepit)
                      .indu()));
                }
                clientis.destroy();
              } else if (opn.obstructionum.interioreObstructionum.estFurca &&
                  !foramenFurca.map((mff) => mff.probationem).contains(opn
                      .obstructionum.interioreObstructionum.priorProbationem)) {
                if (tridentes.map((mt) => mt.probationem).any((ap) =>
                    ap ==
                    opn.obstructionum.interioreObstructionum.priorProbationem)) {
                  print(
                      'isloindeedalreadyfiuckedup ${lo.map((e) => e.toJson())}');
                  Obstructionum? fton = tridentes.singleWhere((swt) =>
                      swt.probationem ==
                      opn.obstructionum.interioreObstructionum.priorProbationem);
                  List<Obstructionum> lof = [];
                  do {
                    lof.add(fton!);
                    fton = tridentes.singleWhereOrNull((swt) =>
                        swt.probationem ==
                        fton?.interioreObstructionum.priorProbationem);
                    print('ftonloop');
                    print(fton?.toJson());
                  } while (fton != null);
                  print('whatislof ${lof.reversed.map((e) => e.toJson())}');
                  print('howaboutloaftertakeone');
                  List<Obstructionum> lov = [];
                  //this conddintion is never true it grabbed al the blocks instead of a couple
                  Obstructionum foramen = foramenFurca.singleWhere((swf) =>
                      swf.probationem ==
                      lof.last.interioreObstructionum.priorProbationem);
                  lov.addAll(lo.takeWhile((two) =>
                      two.probationem !=
                      foramen.interioreObstructionum.priorProbationem));
                  print('didlochange ${lo.map((e) => e.toJson())}');
                  lov.add(lo.singleWhere((swo) =>
                      swo.probationem ==
                      foramen.interioreObstructionum.priorProbationem));
                  lov.add(foramen);
                  lov.addAll(lof.reversed);
                  print('thiscorruptchainofblocksdownhere');
                  for (Obstructionum o in lov) {
                    print('${o.toJson()}\n');
                    print('\n');
                  }
                  if (!await validateObstructionum(
                      clientis, lov, opn.obstructionum)) {
                    return;
                  }
                  tridentes.add(opn.obstructionum);
                  if (opn.obstructionum.interioreObstructionum.divisa <
                          prioro.interioreObstructionum.divisa &&
                      opn.obstructionum.interioreObstructionum
                              .summaObstructionumDifficultas >
                          prioro.interioreObstructionum
                              .summaObstructionumDifficultas) {
                    print('okeletsreplace');
                    await Obstructionum.removereUsqueAd(foramen, directorium);
                    print('removed now list is');
                    List<Obstructionum> tlo =
                        await Obstructionum.getBlocks(directorium);
                    for (Obstructionum o in tlo) {
                      print('${o.toJson()}\n');
                      print('\n');
                    }

                    await foramen.salvare(directorium);
                    for (Obstructionum o in lof.reversed) {
                      await o.salvare(directorium);
                    }
                    await opn.obstructionum.salvare(directorium);
                  }
                  clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                          opn.obstructionum,
                          PervideasNuntiusTitulus.obstructionumIsSalvare,
                          opn.accepit)
                      .indu()));
                  clientis.destroy();
                } else {
                  Print.nota(nuntius: 'invalidum furca', message: 'invalid fork');
                  return;
                }
              } else if (lo
                      .map((mo) => mo.probationem)
                      .contains(opn.obstructionum.probationem) &&
                  !opn.obstructionum.interioreObstructionum.estFurca) {
                print('gotinunused');
                List<Obstructionum> loc = lo
                    .takeWhile((two) =>
                        two.interioreObstructionum.priorProbationem !=
                        opn.obstructionum.probationem)
                    .toList();
                loc.removeLast();
                // Obstructionum o = loc.removeLast();
                print(loc.map((e) => e.toJson()));
                if (await validateObstructionum(
                    clientis, loc, opn.obstructionum)) {
                  clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                          opn.obstructionum,
                          PervideasNuntiusTitulus.obstructionumIsSalvare,
                          opn.accepit)
                      .indu()));
                  clientis.destroy();
                }
                // loc.add(o);
              } else if (lo.map((mo) => mo.probationem).contains(opn
                      .obstructionum.interioreObstructionum.priorProbationem) &&
                  !opn.obstructionum.interioreObstructionum.estFurca) {
                print('howaboutlo');
                print(lo.map((e) => e.toJson()));
                // List<Obstructionum> lot = [lo.first];
                print('howaboutloaftertakeone');
                // List<Obstructionum> lok = lo.skip(1).toList();
                print(lo.map((e) => e.toJson()));
                List<Obstructionum> lov = [];
                lov.addAll(lo.takeWhile((two) =>
                    two.probationem !=
                    opn.obstructionum.interioreObstructionum.priorProbationem));
                print('isprobwrong');
                lov.add(lo.singleWhere((swo) =>
                    swo.probationem ==
                    opn.obstructionum.interioreObstructionum.priorProbationem));
                print(lo.map((e) => e.toJson()));
                if (await validateObstructionum(
                    clientis, lov, opn.obstructionum)) {
                  if (opn.obstructionum.interioreObstructionum.divisa <
                          prioro.interioreObstructionum.divisa &&
                      opn.obstructionum.interioreObstructionum
                              .summaObstructionumDifficultas >
                          prioro.interioreObstructionum
                              .summaObstructionumDifficultas) {
                    print('divisa was lower in probwrong');
                    await Obstructionum.removereUsqueAd(
                        opn.obstructionum, directorium);
                    await opn.obstructionum.salvare(directorium);
                  } else {
                    print('loaftervalidateobs ${lo.map((e) => e.toJson())}');
                    foramenFurca.add(opn.obstructionum);
                  }
                  print('didwegetpassedhere');
                  clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                          opn.obstructionum,
                          PervideasNuntiusTitulus.obstructionumIsSalvare,
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
                loc.add(lo.singleWhere((swo) =>
                    loc.last.probationem ==
                    swo.interioreObstructionum.priorProbationem));

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
              if (!await validateObstructionum(clientis, lo, opn.obstructionum)) {
                return;
              }
              clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                      opn.obstructionum,
                      PervideasNuntiusTitulus.obstructionumIsSalvare,
                      opn.accepit)
                  .indu()));
              if (!opn.accepit.contains(ip)) {
                opn.accepit.add(ip);
              }
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
                  nervus.listen((convalescit) async {
                    ObstructionumSalvarePervideasNuntius ospn =
                        ObstructionumSalvarePervideasNuntius.ex(
                            json.decode(String.fromCharCodes(convalescit).trim())
                                as Map<String, dynamic>);
                    isSalvare = true;
                    await ospn.obstructionum.salvare(directorium);
                    isSalvare = false;
                  });
                }
                // lets add blockproducer to the message and else if if aint blockproducer so a boolean so a ip
              } else if(opn.obstructionum.interioreObstructionum.producentis != argumentis!.publicaClavis) {
                print('willsearchforrandomnodetovalidateblockagains');
                final random = Random();
                String nervuss = bases[random.nextInt(bases.length)];
                // opn.accepit.add(ip);
                Socket nervus = await Socket.connect(
                    nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
                nervus.write(json.encode(ObstructionumPervideasNuntius(
                        opn.obstructionum,
                        PervideasNuntiusTitulus.accipreObstructionum,
                        opn.accepit)
                    .indu()));
                nervus.listen((convalescit) async {
                  ObstructionumSalvarePervideasNuntius ospn =
                      ObstructionumSalvarePervideasNuntius.ex(
                          json.decode(String.fromCharCodes(convalescit).trim())
                              as Map<String, dynamic>);
                  print('recievedpermissiontosalvare');
                  isSalvare = true;
                  await ospn.obstructionum.salvare(directorium);
                  isSalvare = false;
                });
              }
            }
            break;
          } 
          case PervideasNuntiusTitulus.addereForamenFurca: {
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
            break;
          }
        }
        occupatus = false;
      });
    });
  }

  void connect(String taberNodi) async {
    bases.add(taberNodi);
    List<String> taberNodifissile = taberNodi.split(':');
    Socket nervus = await Socket.connect(
        taberNodifissile[0], int.parse(taberNodifissile[1]));
    nervus.write(json.encode(UnaBasesSingulasPervideasNuntius(
            ip, PervideasNuntiusTitulus.connectTaberNodi, List<String>.from([]))
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
          PervideasNuntiusTitulus.petitioObstructionumIncipio, [ip]).indu()));
      nervus.listen((eventus) async {
        print('hearedback');
        PervideasNuntius pn = PervideasNuntius.ex(
            json.decode(String.fromCharCodes(eventus)) as Map<String, dynamic>);
        print('msg\n');
        print(pn.indu());
        if (pn.titulus == PervideasNuntiusTitulus.obstructionumReponereUna) {
          ObstructionumReponereUnaPervideasNuntius orupn =
              ObstructionumReponereUnaPervideasNuntius.ex(
                  json.decode(String.fromCharCodes(eventus).trim())
                      as Map<String, dynamic>);
          print('orupn\n');
          print(orupn.indu());
          if (orupn.obstructionum.interioreObstructionum.generare ==
              Generare.incipio) {
            print('nowiwillsalvare');
            await orupn.obstructionum.salvareIncipio(directorium);
            nervus.write(json.encode(PetitioObstructionumPervideasNuntius(
                orupn.obstructionum.probationem,
                PervideasNuntiusTitulus.petitioObstructionum, []).indu()));
          } else {
            print('nowiwillsalvare');
            await orupn.obstructionum.salvare(directorium);
            nervus.write(PetitioObstructionumPervideasNuntius(
                orupn.obstructionum.probationem,
                PervideasNuntiusTitulus.petitioObstructionum, []).indu());
          }
        } else if (pn.titulus == PervideasNuntiusTitulus.summaScandalumExNodo) {
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
          PervideasNuntiusTitulus.petitioObstructionum, []).indu());
      nervus.listen((eventus) async {
        ObstructionumReponereUnaPervideasNuntius orupn =
            ObstructionumReponereUnaPervideasNuntius.ex(
                json.decode(String.fromCharCodes(eventus).trim())
                    as Map<String, dynamic>);
        print('nowiwillsalvare');
        await orupn.obstructionum.salvare(directorium);
        nervus.write(PetitioObstructionumPervideasNuntius(
            orupn.obstructionum.probationem,
            PervideasNuntiusTitulus.petitioObstructionum, []).indu());
      });
    }
  }

  Future syncPropter(Propter propter) async {
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
          propter, PervideasNuntiusTitulus.propter, [ip]).indu()));
      nervus.destroy();
    }
  }

  Future syncLiberTransaction(Transactio ltx) async {
    if (liberTransactions.any((alt) =>
        alt.interioreTransactio.identitatis ==
        ltx.interioreTransactio.identitatis)) {
      print('removedonsendernode');
      liberTransactions.removeWhere((rwlt) =>
          rwlt.interioreTransactio.identitatis ==
          ltx.interioreTransactio.identitatis);
    }
    liberTransactions.add(ltx);
    for (String nervuss in bases.where((b) => b != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(TransactioPervideasNuntius(
          ltx, PervideasNuntiusTitulus.liberTransactio, [ip]).indu()));
      nervus.destroy();        
    }
  }

  Future syncFixumTransaction(Transactio tx) async {
    if (fixumTransactions.any((t) =>
        t.interioreTransactio.identitatis ==
        tx.interioreTransactio.identitatis)) {
      fixumTransactions.removeWhere((t) =>
          t.interioreTransactio.identitatis ==
          tx.interioreTransactio.identitatis);
    }
    fixumTransactions.add(tx);
    for (String nervuss in bases.where((b) => b != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(TransactioPervideasNuntius(
          tx, PervideasNuntiusTitulus.fixumTransactio, [ip]).indu()));
      nervus.destroy();
    }
  }

  Future syncExpressiTransaction(Transactio tx) async {
    if (expressiTransactions.any((t) =>
        t.interioreTransactio.identitatis ==
        tx.interioreTransactio.identitatis)) {
      expressiTransactions.removeWhere((t) =>
          t.interioreTransactio.identitatis ==
          tx.interioreTransactio.identitatis);
    }
    expressiTransactions.add(tx);
    for (String nervuss in bases.where((b) => b != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(TransactioPervideasNuntius(
          tx, PervideasNuntiusCasibus.expressiTransactio, [ip]).indu()));
      nervus.destroy();
    }
  }

  // maby avoid checking just check if any and skippi syncing if already is in the list
  Future syncConnexaLiberExpressi(ConnexaLiberExpressi clep) async {
    connexiaLiberExpressis.add(clep);
    for (String nervuss in bases.where((b) => b != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(ConnexaLiberExpressiPervideasNuntius(
          clep, PervideasNuntiusTitulus.connexaLiberExpressi, [ip]).indu()));
      nervus.destroy();
    }
  }

  Future syncSiRemotiones(SiRemotionem sr) async {
    if (siRemotiones.any((asr) =>
        asr.interioreSiRemotionem.identitatisInterioreSiRemotionem ==
        sr.interioreSiRemotionem.identitatisInterioreSiRemotionem)) {
      siRemotiones.removeWhere((rwsr) =>
          rwsr.interioreSiRemotionem.identitatisInterioreSiRemotionem ==
          sr.interioreSiRemotionem.identitatisInterioreSiRemotionem);
    }
    siRemotiones.add(sr);
    for (String nervuss in bases.where((b) => b != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(SiRemotionemPervideasNuntius(
          sr, PervideasNuntiusTitulus.siRemotionem, [ip]).indu()));
      nervus.destroy();
    }
  } 

  Future syncSolucionisPropter(SolucionisPropter sr) async {
    if (solucionisRationibus.any((asr) => asr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis)) {
      solucionisRationibus.removeWhere((rwsr) => rwsr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis);
    }
    solucionisRationibus.add(sr);
    for (String nervuss in bases.where((b) => b != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(SolucionisPropterPervideasNuntius(
          sr, PervideasNuntiusTitulus.solucionisPropter, [ip]).indu()));
      nervus.destroy();
    }
  }
  Future syncFissileSolucionisPropter(FissileSolucionisPropter fsr) async {
    if (fissileSolucionisRationibus.any((afsr) => afsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == fsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis)) {
      solucionisRationibus.removeWhere((rwfsr) => rwfsr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == fsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis);
    }
    fissileSolucionisRationibus.add(fsr);
    for (String nervuss in bases.where((b) => b != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(FissileSolucionisPropterPervideasNuntius(
          fsr, PervideasNuntiusTitulus.fissileSolucionisPropter, [ip]).indu()));
      nervus.destroy();
    }
  }
  //todpop hier 1 pervideasnutniusmessage for all these removals and ids
  Future removePropters(List<String> ids) async {
    rationibus.removeWhere(
        (p) => ids.any((i) => i == p.interiorePropter.identitatis));
    for (String nervus in bases.where((wb) => wb != ip)) {
      Socket soschock = await Socket.connect(
          nervus.split(':')[0], int.parse(nervus.split(':')[1]));
      soschock.write(json.encode(RemoveByIdentitatumPervideasNuntius(
          ids, PervideasNuntiusTitulus.removePropters, [ip]).indu()));
      soschock.destroy();
    }
  }

  Future removeLiberTransactions(List<String> identitatum) async {
    isRemove = true;
    liberTransactions.removeWhere(
        (l) => identitatum.any((i) => i == l.interioreTransactio.identitatis));
    for (String nervuss in bases.where((wb) => wb != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(RemoveTransactionsPervideasNuntius(
          TransactioGenus.liber,
          identitatum,
          PervideasNuntiusTitulus.removeTransactions,
          [ip]).indu()));
      nervus.destroy();
    }
    isRemove = false;
  }

  Future removeFixumTransactions(List<String> identitatum) async {
    fixumTransactions.removeWhere(
        (l) => identitatum.any((i) => i == l.interioreTransactio.identitatis));
    for (String nervuss in bases.where((wb) => wb != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(RemoveTransactionsPervideasNuntius(
          TransactioGenus.fixum,
          identitatum,
          PervideasNuntiusTitulus.removeTransactions,
          [ip]).indu()));
      nervus.destroy();
    }
  }

  Future removeExpressiTransactions(List<String> identitatum) async {
    expressiTransactions.removeWhere(
        (l) => identitatum.any((i) => i == l.interioreTransactio.identitatis));
    for (String nervuss in bases.where((wb) => wb != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(RemoveTransactionsPervideasNuntius(
          TransactioGenus.expressi,
          identitatum,
          PervideasNuntiusTitulus.removeTransactions,
          [ip]).indu()));
      nervus.destroy();
    }
  }

  Future removeConnexaLiberExpressis(List<String> identitatum) async {
    connexiaLiberExpressis.removeWhere((cle) => identitatum.any((identitatis) =>
        identitatis == cle.interioreConnexaLiberExpressi.identitatis));
    for (String nervuss in bases.where((wb) => wb != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(RemoveByIdentitatumPervideasNuntius(
          identitatum,
          PervideasNuntiusTitulus.removeConnexaLiberExpressis,
          [ip]).indu()));
      nervus.destroy();
    }
  }

  Future removeSiRemotionems(List<String> identitatum) async {
    siRemotiones.removeWhere((rwsr) => identitatum.any((ai) =>
        ai == rwsr.interioreSiRemotionem.identitatisInterioreSiRemotionem));
    for (String nervuss in bases.where((wb) => wb != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(RemoveByIdentitatumPervideasNuntius(
              identitatum, PervideasNuntiusTitulus.removeSiRemotionems, [ip])
          .indu()));
      nervus.destroy();
    }
  }

  Future removeSolucionisPropter(List<String> claves) async {
    solucionisRationibus.removeWhere((rwsr) => claves.any((ai) => ai == rwsr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis));
    for (String nervus in bases.where((wb) => wb != ip)) {
      Socket soschock = await Socket.connect(
          nervus.split(':')[0], int.parse(nervus.split(':')[1]));
      soschock.write(json.encode(RemoveByIdentitatumPervideasNuntius(
         claves, PervideasNuntiusTitulus.removeSolucionisRationibus, [ip]).indu()));
      soschock.destroy();
    }
  }
  Future removeFissileSolucionisPropter(List<String> claves) async {
    fissileSolucionisRationibus.removeWhere((rwsr) => claves.any((ai) => ai == rwsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis));
    for (String nervus in bases.where((wb) => wb != ip)) {
      Socket soschock = await Socket.connect(
          nervus.split(':')[0], int.parse(nervus.split(':')[1]));
      soschock.write(json.encode(RemoveByIdentitatumPervideasNuntius(
          claves, PervideasNuntiusTitulus.removeFissileSolucionisRationibus, [ip]).indu()));
      soschock.destroy();
    }
  }

  // Future sumoLiberTransactions(List<String> identitatum) async {
  //   while(isRemove) {
  //     await Future.delayed(Duration(milliseconds: 100));
  //   }    
  //   for (Transactio t in liberTransactions.where((wlt) => !wlt.capta && identitatum.any((ai) => ai == wlt.interioreTransactio.identitatis))) {
  //     t.capta = true;
  //   }
  //   for (String nervuss in bases.where((wb) => wb != ip)) {
  //     Socket nervus = await Socket.connect(
  //         nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
  //     nervus.write(json.encode(SumoTransactionsPervideasNuntius(
  //         TransactioGenus.liber,
  //         identitatum,
  //         PervideasNuntiusTitulus.sumoTransactions,
  //         [ip]).indu()));
  //     nervus.destroy();
  //   }
  // }
  // Future sumoFixumTransactions(List<String> identitatum) async {
  //   for (Transactio t in fixumTransactions.where((wlt) => !wlt.capta && identitatum.any((ai) => ai == wlt.interioreTransactio.identitatis))) {
  //     t.capta = true;
  //   }
  //   for (String nervuss in bases.where((wb) => wb != ip)) {
  //     Socket nervus = await Socket.connect(
  //         nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
  //     nervus.write(json.encode(SumoTransactionsPervideasNuntius(
  //         TransactioGenus.fixum,
  //         identitatum,
  //         PervideasNuntiusTitulus.sumoTransactions,
  //         [ip]).indu()));
  //     nervus.destroy();
  //   }
  // }
  // Future sumoExpressiTransactions(List<String> identitatum) async {
  //   for (Transactio t in expressiTransactions.where((wlt) => !wlt.capta && identitatum.any((ai) => ai == wlt.interioreTransactio.identitatis))) {
  //     t.capta = true;
  //   }
  //   for (String nervuss in bases.where((wb) => wb != ip)) {
  //     Socket nervus = await Socket.connect(
  //         nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
  //     nervus.write(json.encode(SumoTransactionsPervideasNuntius(
  //         TransactioGenus.expressi,
  //         identitatum,
  //         PervideasNuntiusTitulus.sumoTransactions,
  //         [ip]).indu()));
  //     nervus.destroy();
  //   }
  // }

  Future syncBlock(Obstructionum o) async {
    List<String> accepit = bases;
    if (!accepit.contains(ip)) {
      accepit.add(ip);
    }
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
              'misit obstructionum cum numero: ${o.interioreObstructionum.obstructionumNumerus} per network');

      nervus.listen((eventus) async {
        print('passedallvalidations');
        PervideasNuntius pn = PervideasNuntius.ex(
            json.decode(String.fromCharCodes(eventus).trim())
                as Map<String, dynamic>);
        if (pn.titulus == PervideasNuntiusTitulus.obstructionumIsSalvare) {
          print('wentintosalvare');
          ObstructionumSalvarePervideasNuntius oispn =
              ObstructionumSalvarePervideasNuntius.ex(
                  json.decode(String.fromCharCodes(eventus).trim())
                      as Map<String, dynamic>);
          print('nowiwillsalvare');
          isSalvare = true;          
          await oispn.obstructionum.salvare(directorium);
          isSalvare = false;
          InFieriObstructionum ifo = oispn.obstructionum.inFieriObstructionum();
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
          ifo.solucionisRationibus.forEach((sr) => isolates.solocionisRationem[sr]?.kill(priority: Isolate.immediate));
          ifo.fissileSolucionisRationibus.forEach((fsr) => isolates.fissileSolocionisRationem[fsr]?.kill(priority: Isolate.immediate));
          await par!.removePropters(ifo.gladiatorIdentitatum);
          await par!.removeLiberTransactions(ifo.liberTransactions);
          await par!.removeFixumTransactions(ifo.fixumTransactions);
          await par!.removeExpressiTransactions(ifo.expressiTransactions);
          await par!.removeConnexaLiberExpressis(ifo.connexaLiberExpressis);
          await par!.removeSiRemotionems(ifo.siRemotionems);
          await par!.removeSolucionisPropter(ifo.solucionisRationibus);
          await par!.removeFissileSolucionisPropter(ifo.fissileSolucionisRationibus);
          // await par!.sumoLiberTransactions(ifo.liberTransactions);
          // await par!.sumoFixumTransactions(ifo.fixumTransactions);
          // await par!.sumoExpressiTransactions(ifo.expressiTransactions);          
          
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
                    PervideasNuntiusTitulus.petitioObstructionum, []).indu());
              }
            }
          }
        } else if (pn.titulus ==
            PervideasNuntiusTitulus.obstructionumReponereUna) {
          ObstructionumReponereUnaPervideasNuntius orupn =
              ObstructionumReponereUnaPervideasNuntius.ex(
                  json.decode(String.fromCharCodes(eventus).trim())
                      as Map<String, dynamic>);
          print('nowiwillsalvare');
          await orupn.obstructionum.salvare(directorium);
          nervus.write(PetitioObstructionumPervideasNuntius(
              orupn.obstructionum.probationem,
              PervideasNuntiusTitulus.petitioObstructionum, []).indu());
        }
      });
    }
  }

  Future syncThrough(TransactioGenus tg, Transactio transactio, List<String> accepit) async {
    // ppn.accepit.add(ip);
    for (String nervusFilim in bases.where((n) => !accepit.contains(n))) {
      List<String> fissile = nervusFilim.split(':');
      Socket nervus = await Socket.connect(fissile[0], int.parse(fissile[1]));
      switch (tg) {
        case TransactioGenus.liber: {
          nervus.write(json.encode(TransactioPervideasNuntius(
           transactio, PervideasNuntiusTitulus.liberTransactio, accepit).indu()));
          nervus.listen((eventus) {
              PetitioExpressiTransactioPervideasNuntius petpn =
              PetitioExpressiTransactioPervideasNuntius.ex(
                  json.decode(String.fromCharCodes(eventus).trim()));
              Transactio? t = expressiTransactions.singleWhereOrNull((swet) => swet.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == transactio.interioreTransactio.identitatis));
              if (t != null) {
                nervus.write(json.encode(DareExpressiTransactioPervideasNuntius(t, PervideasNuntiusTitulus.expressiTransactio, petpn.accepit).indu()));              
              }
              nervus.destroy();        
          });
          break;
        }
        case TransactioGenus.fixum: {
          nervus.write(json.encode(TransactioPervideasNuntius(
          transactio, PervideasNuntiusTitulus.fixumTransactio, accepit).indu()));
          break;
        }
        default: break;
      }
    }
  }

  Iterable<ConnexaLiberExpressi> invenireConnexaLiberExpressis(
      Iterable<String> liberIdentitatum) {
    return connexiaLiberExpressis
        .where((cle) => liberIdentitatum.any(
            (li) => li == cle.interioreConnexaLiberExpressi.liberIdentitatis));
  }

  Future<bool> validateObstructionum(Socket clientis, List<Obstructionum> lo,
      Obstructionum obstructionum) async {
        print('howmanytimedoyouenterandvalidate');
    Obstructionum incipio = await Obstructionum.accipereIncipio(directorium);
    if (!obstructionum.isProbationem()) {
      Print.nota(
          nuntius:
              'Hashing in obstructionum non propono in probationem vel obstructionum Nullam',
          message:
              'Hashing the block does not resolve into the proof or block hash');
      return false;
    }
    if (!obstructionum.transactionsIncluduntur(lo)) {
        Print.nota(nuntius: 'refered gestum obstructionum non est inventus', message: 'refered transaction of block is not found');
      return false;
    }
    if (!await convalidandumLiber(obstructionum.interioreObstructionum.liberTransactions, lo)) {
      Print.nota(
        nuntius:
            'obstructionum ineuntes continet vestra corrumpere transactions',
        message: 'your incoming block contains corrupt transactions');
      return false;
    }
    List<Transactio> ltltet = [];
    ltltet.addAll(liberTransactions);
    ltltet.addAll(expressiTransactions);
    if (!await convalidandumLiber(ltltet, lo)) {
      Print.nota(
            nuntius:
                'obstructionum ineuntes continet vestra corrumpere transactions',
            message: 'your incoming block contains corrupt transactions');
        return false;
    }
    for (SiRemotionem sr in obstructionum.interioreObstructionum.siRemotiones.where((wsr) => wsr.interioreSiRemotionem.siRemotionemOutput != null)) {
      if (!sr.interioreSiRemotionem.cognoscereOutput()) {
        Print.nota(nuntius: 'corrumpere si remotionem output signature', message: 'corrupt si remotionem output signature');
        return false;
      }
      if (lo.any((ao) => sr.interioreSiRemotionem.siRemotionemOutput!.liber ? ao.interioreObstructionum.liberTransactions.any((alt) => alt.interioreTransactio.identitatis == sr.interioreSiRemotionem.siRemotionemOutput!.transactioIdentitatis) : ao.interioreObstructionum.fixumTransactions.any((aft) => aft.interioreTransactio.identitatis == sr.interioreSiRemotionem.siRemotionemOutput!.transactioIdentitatis))) {
        Print.nota(nuntius: 'rem numquam removeri non potuit altius', message: 'transaction was never removed so could not create depth');
        return false;
      }
    }
    for (SiRemotionem sr in obstructionum.interioreObstructionum.siRemotiones.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null)) {
      if (!sr.interioreSiRemotionem.siRemotionemInput!.cognoscere(lo)) {
        Print.nota(nuntius: 'corrumpere si remotionem input signature', message: 'corrupt si remotionem input signature');
        return false;
      }
      if (!lo.any((ao) => ao.interioreObstructionum.siRemotiones.any((asr) => asr.interioreSiRemotionem.identitatisInterioreSiRemotionem == sr.interioreSiRemotionem.siRemotionemInput!.siRemotionemIdentiatis))) {
        Print.nota(nuntius: 'non inveniret profundum ut stipendium', message: 'could not find depth to pay ');
        return false;
      }
      if (!obstructionum.interioreObstructionum.liberTransactions.any((alt) => alt.interioreTransactio.identitatis == sr.interioreSiRemotionem.siRemotionemInput!.transactioIdentitatis) && !obstructionum.interioreObstructionum.fixumTransactions.any((aft) => aft.interioreTransactio.identitatis == sr.interioreSiRemotionem.siRemotionemInput!.transactioIdentitatis)) {
        Print.nota(nuntius: 'rem invenire non potuit reddere profundum', message: 'could not find transaction that would pay the depth');
        return false;
      }
      if (!sr.interioreSiRemotionem.siRemotionemInput!.solvit(obstructionum, lo)) {
        return false;
      }
    }
    for (SolucionisPropter sp in obstructionum.interioreObstructionum.solucionisRationibus) {
      if (!sp.interioreSolucionisPropter.estValidus(lo) || !sp.estProbationem() || !sp.interioreSolucionisPropter.quinSignature()) {
        return false;
      }
    }
    for (FissileSolucionisPropter fsp in obstructionum.interioreObstructionum.fissileSolucionisRationibus) {
      if (!fsp.interioreFissileSolucionisPropter.estValidus(lo) || !fsp.estProbationem() || !fsp.interioreFissileSolucionisPropter.quinSignature()) {
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
      case Generare.expressi: {
        if (lo.last.interioreObstructionum.generare != Generare.efectus) {
          Print.nota(nuntius: 'an expressi scandalum fieri potest nisi super efectus scandalum', message: 'an expressi block can only occur on top of an efectus block');
          return false;
        }
      }
      case Generare.confussus:
        {
          if (await Obstructionum.gladiatorConfodiantur(
              obstructionum.interioreObstructionum.gladiator.interioreGladiator
                  .input!.victima.gladiatorIdentitatis,
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
          if (!await obstructionum.convalidandumPerdita(lo)) {
            Print.nota(nuntius: 'invalidum perdita', message: 'invalidum perdita');
            return false;
          }

          // hmm this would actually fail to
          if (!await obstructionum.convalidandumObsturcutionumNumerus(
              incipio, lo.last)) {
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
            incipio, lo.last)) {
          Print.nota(
              nuntius:
                  'Mittens huius obstructionum conatur cibum usque ad numerum obstructionum',
              message:
                  'the sender of this block is trying to mess up the block number');
          return false;
        }
        if (!obstructionum.convalidandumExpressiMoles()) {
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
        obstructionum.interioreObstructionum, lo.last)) {
      case QuidFacere.solitum:
        {
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
          List<TransactioInput> lti = [];
          obstructionum.interioreObstructionum.liberTransactions.map((mlt) => mlt.interioreTransactio.inputs).forEach(lti.addAll);
          List<TransactioOutput> outputs = [];
          obstructionum.interioreObstructionum.liberTransactions
              .where((wlt) =>
                  wlt.interioreTransactio.transactioSignificatio !=
                      TransactioSignificatio.praemium &&
                  wlt.interioreTransactio.transactioSignificatio !=
                      TransactioSignificatio.ardeat &&
                  lti.any((ati) => ati.transactioIdentitatis == wlt.interioreTransactio.identitatis))
              .map((mlt) => mlt.interioreTransactio.outputs)
              .forEach(outputs.addAll);

              // we need to remove these outputs if one of the txs of the current block reference a tx of this block
              //
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

  Future siRemotionemSyncThrough(SiRemotionemPervideasNuntius srpn) async {
    if (siRemotiones.any((asr) =>
        asr.interioreSiRemotionem.identitatisInterioreSiRemotionem ==
        srpn.siRemotionem.interioreSiRemotionem
            .identitatisInterioreSiRemotionem)) {
      siRemotiones.removeWhere((rwsr) =>
          rwsr.interioreSiRemotionem.identitatisInterioreSiRemotionem ==
          srpn.siRemotionem.interioreSiRemotionem
              .identitatisInterioreSiRemotionem);
    }
    siRemotiones.add(srpn.siRemotionem);
    for (String nervuss in bases.where((s) => !srpn.accepit.contains(s))) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(srpn.indu()));
      nervus.destroy();
    }
  }

  Future<bool> convalidandumLiber(Iterable<Transactio> llt, List<Obstructionum> lo) async {
    // ltttip.addAll(liberTransactions);
    // ltttip.addAll(lo.last.interioreObstructionum.expressiTransactions);
    for (Transactio lt in llt) {
      switch(lt.interioreTransactio.transactioSignificatio) {
        case TransactioSignificatio.regularis:
        case TransactioSignificatio.expressi:
        case TransactioSignificatio.refugium: {
          if (lt.minusQuamBidInProbationibus(llt, lo)) {
            if (lt.interioreTransactio.liber) {
              for (TransactioOutput to in lt.interioreTransactio.outputs) {
                if (!await Pera.isPublicaClavisDefended(to.publicaClavis, lo)) {
                  Print.nota(nuntius: 'non potest mittere pecuniam publicam clavem indefensam', message: 'can not send money to undefended public key');
                  return false;
                }
              }
            }
          } else {
            Print.nota(nuntius: 'non plus quam modus', message: 'can not spend more money than your limit');
            return false;
          } 
          if (lt.solucionis(lo)){
            Print.nota(nuntius: 'iusto negotio non potest esse solutio ratio', message: 'regular transaction can not be a payment account');
            return false;
          } 
        }
        case TransactioSignificatio.ardeat:
        case TransactioSignificatio.perdita: {
          if (!lt.estDominus(llt, lo) || lt.isFurantur() || lt.habetProfundum(lo) || !lt.verumMoles(llt, lo) || !lt.validateProbationem()) {
            print('bailedliberconv');
            return false;
          }
          break;
        }
        default: break;
      }
    }

    return true;    
  }
}
