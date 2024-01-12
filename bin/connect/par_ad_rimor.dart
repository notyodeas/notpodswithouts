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
import '../exempla/errors.dart';
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
// class RemoveTransactionsPervideasNuntius extends PervideasNuntius {
//   TransactioGenus transactioGenus;
//   List<String> identitatum;
//   RemoveTransactionsPervideasNuntius(
//       this.transactioGenus, this.identitatum, String titulust, List<String> accepit)
//       : super(titulust, accepit);
//   RemoveTransactionsPervideasNuntius.ex(Map<String, dynamic> nuntius)
//       : transactioGenus =
//             TransactioGenusFromJson.fromJson(nuntius[PervideasNuntiusCasibus.transactioGenus])
//                 as TransactioGenus,
//         identitatum = List<String>.from(
//             nuntius[PervideasNuntiusCasibus.identitatum] as List<dynamic>),
//         super.ex(nuntius);
//   @override
//   Map<String, dynamic> indu() => {
//     PervideasNuntiusCasibus.transactioGenus: transactioGenus.name.toString(),
//     PervideasNuntiusCasibus.identitatum: identitatum,
//     PervideasNuntiusCasibus.titulus: titulus,
//     PervideasNuntiusCasibus.accepit: accepit
//   };
// }

class InritaTransactioPervideasNuntius extends PervideasNuntius {
  InterioreInritaTransactio interiore;
  InritaTransactioPervideasNuntius(this.interiore, String titulus, List<String> accepit): super(titulus, accepit);
  
  InritaTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius): interiore = InterioreInritaTransactio.fromJson(nuntius[PervideasNuntiusCasibus.interiore]), super.ex(nuntius);
  
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.interiore: interiore.toJson(),
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}
class NeTransactioPervideasNuntius extends PervideasNuntius {
  InritaTransactio it;
  NeTransactioPervideasNuntius(this.it, String titulus, List<String> accepit): super(titulus, accepit);

  NeTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius):
    it = InritaTransactio.fromJson(nuntius[PervideasNuntiusCasibus.it] as Map<String, dynamic>), super.ex(nuntius);
  
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.it: it.toJson(),
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
        PervideasNuntiusCasibus.probationem: probationem,
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

class QueueItem  {
  Socket clientis;
  String msg;
  QueueItem(this.clientis, this.msg);
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
  List<InritaTransactio> inritaTransactions = [];
  List<SiRemotionem> siRemotiones = [];
  List<ConnexaLiberExpressi> connexiaLiberExpressis = [];
  List<SolucionisPropter> solucionisRationibus = [];
  List<FissileSolucionisPropter> fissileSolucionisRationibus = [];
  List<Obstructionum> foramenFurca = [];
  List<Obstructionum> tridentes = [];
  List<Isolate> syncBlocks = [];

  List<QueueItem> epistulae = [];
  bool occupatus = false;
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
        print('with msg \n $eventus');
        epistulae.add(QueueItem(clientis, eventus));
        bool pass = false;
        while(!occupatus) {
          while (occupatus) {
            await Future.delayed(Duration(seconds: 1));
          }        
          if (!pass)  {
            pass = true;
            break;
          } 
        }
        while (isSalvare) {
          await Future.delayed(Duration(seconds: 1));
        }
        occupatus = true;
        QueueItem qi = epistulae.removeAt(0);
        print('\n okey lets work on this message \n \n ${qi.msg} ');
        // print('nextmsg \n $eventus');
        PervideasNuntius pn =
            PervideasNuntius.ex(json.decode(qi.msg) as Map<String, dynamic>);
        switch (pn.titulus) {
          case PervideasNuntiusTitulus.connectTaberNodi: {
            UnaBasesSingulasPervideasNuntius ubs =
              UnaBasesSingulasPervideasNuntius.ex(
                  json.decode(qi.msg) as Map<String, dynamic>);
            qi.clientis.write(json.encode(InConnectPervideasNuntius(
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
            qi.clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.singleSocket: {
            UnaBasesSingulasPervideasNuntius ubs =
              UnaBasesSingulasPervideasNuntius.ex(
                  json.decode(qi.msg) as Map<String, dynamic>);
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
            qi.clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.petitioObstructionumIncipio: {
            PetitioObstructionumIncipioPervideasNuntius poipn =
              PetitioObstructionumIncipioPervideasNuntius.ex(
                  json.decode(qi.msg) as Map<String, dynamic>);
            List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
            if (!poipn.accepit.contains(ip)) {
              poipn.accepit.add(ip);
            }
            qi.clientis.write(json.encode(ObstructionumReponereUnaPervideasNuntius(
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
                  json.decode(qi.msg) as Map<String, dynamic>);
            List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
            Obstructionum? obs = obss.singleWhereOrNull((element) =>
                element.interiore.priorProbationem ==
                popn.probationem);
            if (obs == null) {
              Obstructionum obsr = await Obstructionum.acciperePrior(directorium);
              qi.clientis.write(json.encode(SummaScandalumExNodoPervideasNuntius(
                  obsr.interiore.obstructionumNumerus,
                  PervideasNuntiusTitulus.summaScandalumExNodo, []).indu()));
              qi.clientis.destroy();
              print('ididdestroymyclient!');
            } else {
              qi.clientis.write(json.encode(ObstructionumReponereUnaPervideasNuntius(
                      obs, PervideasNuntiusTitulus.obstructionumReponereUna, [])
                  .indu()));
            }
            break;
          }
          case PervideasNuntiusTitulus.propter: {
            PropterPervideasNuntius ppn = PropterPervideasNuntius.ex(
              json.decode(qi.msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            if (await Pera.isPublicaClavisDefended(ppn.propter.interiore.publicaClavis, lo)) {
              print('wrotehere');
              Print.nota(nuntius: 'Publica clavis iam defendi', message: 'Public key  already defended');
              break;
            }
            if (ppn.propter.probationem ==
                HEX.encode(sha512
                    .convert(utf8.encode(
                        json.encode(ppn.propter.interiore.toJson())))
                    .bytes)) {
              if (rationibus.any((p) =>
                  p.interiore.publicaClavis ==
                  ppn.propter.interiore.publicaClavis)) {
                Propter p = rationibus.singleWhere((swp) => swp.interiore.publicaClavis == ppn.propter.interiore.publicaClavis);
                int zerosOld = 0;
                for (int i = 1; i < p.probationem.length; i++) {
                  if (p.probationem.substring(0, i) == ('0' * i)) {
                    zerosOld += 1;
                  }
                }
                int zerosNew = 0;
                for (int i = 1; i < ppn.propter.probationem.length; i++) {
                  if (ppn.propter.probationem.substring(0, i) == ('0' * i)) {
                    zerosNew += 1;
                  }
                }
                if (zerosNew <= zerosOld) {
                  Print.nota(nuntius: 'ius non habes hanc rationem reponere in rationibus piscinae', message: 'you do not have the right to replace this account in the accounts pool');
                  break;
                }
                rationibus.removeWhere((p) =>
                    p.interiore.publicaClavis ==
                    ppn.propter.interiore.publicaClavis);
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
              qi.clientis.destroy();
            }
            break;
          }
          case PervideasNuntiusTitulus.prepareObstructionumSync: {
            List<String> albumBases = bases;
            albumBases.removeWhere((lb) => pn.accepit.contains(lb));
            qi.clientis.write(json.encode(PrepareObstructionumAnswerPervideasNuntius(
                albumBases,
                PervideasNuntiusTitulus.prepareObstructionumAnswer, [])));
            qi.clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.liberTransactio: {
            LiberTransactioPervideasNuntius ltpn =
              LiberTransactioPervideasNuntius.ex(
                  json.decode(qi.msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            List<Transactio> ltc = List<Transactio>.from(liberTransactions.map((mlt) => Transactio.fromJson(mlt.toJson())));
            ltc.add(ltpn.transactio);
            if (await convalidandumLiber(ltc, lo)) {
              if (liberTransactions.any((alt) =>
                  alt.interiore.identitatis ==
                  ltpn.transactio.interiore.identitatis)) {
                Transactio lt = liberTransactions.singleWhere((swlt) => swlt.interiore.identitatis == ltpn.transactio.interiore.identitatis);
                int zerosOld = 0;
                for (int i = 1; i < lt.probationem.length; i++) {
                  if (lt.probationem.substring(0, i) == ('0' * i)) {
                    zerosOld += 1;
                  }
                }
                int zerosNew = 0;
                for (int i = 1; i < ltpn.transactio.probationem.length; i++) {
                  if (ltpn.transactio.probationem.substring(0, i) == ('0' * i)) {
                    zerosNew += 1;
                  }
                }
                if (zerosNew <= zerosOld) {
                  Print.nota(nuntius: 'non habes ius pro hac re in transactione piscinae', message: 'you do not have the right to replace this transaction in the transaction pool');
                  break;
                }
                liberTransactions.removeWhere((rwlt) =>
                    rwlt.interiore.identitatis ==
                    ltpn.transactio.interiore.identitatis);
              }
              liberTransactions.add(ltpn.transactio);
              // if (!expressiTransactions.any((aet) => aet.interiore.inputs.any((ei) => ei.transactioIdentitatis == ltpn.transactio.interiore.identitatis) && (ltpn.transactio.interiore.transactioSignificatio == TransactioSignificatio.regularis || ltpn.transactio.interiore.transactioSignificatio == TransactioSignificatio.refugium))) {
              //   print('ithinkiwrote');
              //   clientis.write(json.encode(PetitioExpressiTransactioPervideasNuntius(PervideasNuntiusTitulus.petitioExpressiTransactio, pn.accepit).indu()));
              // }
              if (!pn.accepit.contains(ip)) {
                pn.accepit.add(ip);
              }
              syncThrough(TransactioGenus.liber, ltpn.transactio, pn.accepit);
            } else {
              Print.nota(nuntius: 'transactionis relativus inventus non est sic, haec transactio ad tergum queue movebitur et postea convalescit', message: 'the refered transaction was not found so this transaction will move to the back of the queue and will be validated later');
              epistulae.add(QueueItem(qi.clientis, qi.msg));
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
            //       aft.interiore.identitatis ==
            //       ftpn.transactio.interiore.identitatis)) {
            //     fixumTransactions.removeWhere((rwft) =>
            //         rwft.interiore.identitatis ==
            //         ftpn.transactio.interiore.identitatis);
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
                    json.decode(qi.msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            List<Transactio> stagnum = [];
            stagnum.addAll(liberTransactions);
            stagnum.addAll(expressiTransactions);
            if (await convalidandumLiber(stagnum, lo)) {
              if (expressiTransactions.any((aet) =>
                  aet.interiore.identitatis ==
                  etpn.transactio.interiore.identitatis)) {
                  Transactio tr = expressiTransactions.singleWhere((swet) => swet.interiore.identitatis == etpn.transactio.interiore.identitatis);
                if (!Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), etpn.transactio.interiore.recipiens), Signature.fromASN1Hex(etpn.transactio.interiore.certitudo!), etpn.transactio.interiore.identitatis) && tr.interiore.certitudo == null) {
                  Print.nota(nuntius: 'Missor huius expressi transactionis ius non habuit in reponendo expressi transactionis nostrae', message: 'the sender of this expressi transaction did not have the right to replace our expressi transaction');
                  break;
                }
                expressiTransactions.removeWhere((rwet) =>
                    rwet.interiore.identitatis ==
                    etpn.transactio.interiore.identitatis);
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
                  json.decode(qi.msg) as Map<String, dynamic>);
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
              json.decode(qi.msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            if (srpn.siRemotionem.interiore.siRemotionemInput ==
                null) {
              if (srpn.siRemotionem.validateProbationem() &&
                  srpn.siRemotionem.interiore.cognoscereOutput() &&
                  await srpn.siRemotionem.remotumEst() &&
                  await srpn.siRemotionem.nonHabetInitus() &&
                  srpn.siRemotionem.interiore.siRemotionemOutput!.estTransactionIdentitatisAdhucPraesto(lo, null) &&
                  !inritaTransactions.any((ait) => ait.interiore.identitatis == srpn.siRemotionem.interiore.siRemotionemOutput!.transactioIdentitatis)) {
                await siRemotionemSyncThrough(srpn);
                print('ifvalidated');
                qi.clientis.destroy();
              } else {
                Print.nota(
                    nuntius:
                        'si remotionem corruptam accepit',
                    message:
                        'received corrupt si remotionem');
              }
            } else {
              List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
              if (
                srpn.siRemotionem.interiore.siRemotionemInput!.cognoscere(lo) && 
              lo.any((ao) => ao.interiore.siRemotiones.any((asr) => asr.interiore.signatureInterioreSiRemotionem == srpn.siRemotionem.interiore.siRemotionemInput!.siRemotionemSignature)) &&
              srpn.siRemotionem.interiore.siRemotionemInput!.solvitStagnum(srpn.siRemotionem.interiore.siRemotionemInput!.interioreTransactio!, lo)
              ) {
                await siRemotionemSyncThrough(srpn);
                qi.clientis.destroy();

              }
            }
            break;
          }
          case PervideasNuntiusTitulus.solucionisPropter: {
            SolucionisPropterPervideasNuntius sppn = SolucionisPropterPervideasNuntius.ex(json.decode(qi.msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            if (!sppn.solucionisPropter.interioreSolucionisPropter.estValidus(lo) || !sppn.solucionisPropter.interioreSolucionisPropter.interioreInterioreSolucionisPropter.nonAccipitEtMittente()) {
              break;
            }
            if (solucionisRationibus.any((asr) => asr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sppn.solucionisPropter.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis)) {
                SolucionisPropter sp = solucionisRationibus.singleWhere((swsp) => swsp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sppn.solucionisPropter.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis);
                int zerosOld = 0;
                for (int i = 1; i < sp.probationem.length; i++) {
                  if (sp.probationem.substring(0, i) == ('0' * i)) {
                    zerosOld += 1;
                  }
                }
                int zerosNew = 0;
                for (int i = 1; i < sppn.solucionisPropter.probationem.length; i++) {
                  if (sppn.solucionisPropter.probationem.substring(0, i) == ('0' * i)) {
                    zerosNew += 1;
                  }
                }
                if (zerosNew <= zerosOld) {
                  Print.nota(nuntius: 'non habes ius pro hac solutionis ratione in solutione rationum piscinae', message: 'you do not have the right to replace this pament account n the payment accounts pool');
                  return;
                }
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
            FissileSolucionisPropterPervideasNuntius fsppn = FissileSolucionisPropterPervideasNuntius.ex(json.decode(qi.msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            if (!fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.estValidus(lo)) {
              break;
            }
            if (!fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.nonAccipitEtMittente()) {
              break;
            }
            if (fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.fixs.isEmpty) {
              Print.nota(nuntius: 'certa pecunia ratio saltem certa', message: 'a fixed payment account should have at least one fixed amount');
              break;
            }
            if (fissileSolucionisRationibus.any((afsr) => afsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis)) {
              FissileSolucionisPropter fsp = fissileSolucionisRationibus.singleWhere((swfsp) => swfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis);
              int zerosOld = 0;
              for (int i = 1; i < fsp.probationem.length; i++) {
                if (fsp.probationem.substring(0, i) == ('0' * i)) {
                  zerosOld += 1;
                }
              }
              int zerosNew = 0;
              for (int i = 1; i < fsppn.fissileSolucionisPropter.probationem.length; i++) {
                if (fsppn.fissileSolucionisPropter.probationem.substring(0, i) == ('0' * i)) {
                  zerosNew += 1;
                }
              }
              if (zerosNew <= zerosOld) {
                Print.nota(nuntius: 'non habes ius repone certam solutionis rationem in certa solutione rationum piscinae', message: 'you do not have the right to replace this fixed payment account n the fixed payment accounts pool');
                break;
              }
              fissileSolucionisRationibus.removeWhere((rwsr) => rwsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis); 
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
          case PervideasNuntiusTitulus.removeConnexaLiberExpressis: {
            RemoveByIdentitatumPervideasNuntius rbipn =
                RemoveByIdentitatumPervideasNuntius.ex(
                    json.decode(qi.msg) as Map<String, dynamic>);
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
            qi.clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.inritaTransactio: {
            InritaTransactioPervideasNuntius itpn = InritaTransactioPervideasNuntius.ex(json.decode(qi.msg) as Map<String, dynamic>);
            Transactio? ttr = 
            itpn.interiore.liber ? 
            liberTransactions.singleWhereOrNull(
              (swonlt) => swonlt.interiore.identitatis == itpn.interiore.identitatis) : 
            fixumTransactions.singleWhereOrNull((swonft) => swonft.interiore.identitatis == itpn.interiore.identitatis);
            if (ttr == null) {
              Print.nota(nuntius: 'negotium ad removendum non est inventus', message: 'transaction to remove is not found');
              break;
            }
            if (ttr.interiore.certitudo != null) {
              Print.nota(nuntius: 'non potest removere transactionis quia iam ab ipso signatur', message: 'can not remove transaction because it is already signed by the receiver');
              break;
            }
            if (!Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), ttr.interiore.dominus), Signature.fromASN1Hex(itpn.interiore.signature), ttr.interiore.identitatis)) {
              Print.nota(nuntius: 'nuntius non habet ius removendi rem', message: 'message does not have the right to remove the transaction');
              break;
            }
            itpn.interiore.liber ? liberTransactions.remove(ttr) : fixumTransactions.remove(ttr);
            if (!itpn.accepit.contains(ip)) {
              itpn.accepit.add(ip);
            }
            for (String nervuss
                in bases.where((s) => !itpn.accepit.contains(s))) {
              Socket nervus = await Socket.connect(
                  nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write(json.encode(itpn.indu()));
            }
            qi.clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.accipreObstructionum: {
            ObstructionumPervideasNuntius opn = ObstructionumPervideasNuntius.ex(
              json.decode(qi.msg) as Map<String, dynamic>);
            Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            print('accipereobstructionum with priorprob ${opn.obstructionum.interiore.priorProbationem} and highest block ${prioro.toJson()}');
            print('whydidlonothaveit ordidithaveitthough and is it some weird removal \n ${lo.last.toJson()}');
            if (opn.obstructionum.interiore.priorProbationem !=
                prioro.probationem) {
              print('wasnotpreviousprobationemno');
              if (!lo.map((mo) => mo.probationem).contains(opn
                      .obstructionum.interiore.priorProbationem) &&
                  !opn.obstructionum.interiore.estFurca) {
                Print.nota(
                    nuntius: 'ignotus obstructionum intra album omnium caudices',
                    message: 'unknown block inside of the list of all blocks');
                break;
              } else if (opn.obstructionum.interiore.estFurca &&
                  foramenFurca.map((mff) => mff.probationem).contains(opn
                      .obstructionum.interiore.priorProbationem)) {
                print('wwentintofurcatrueandforamenfurcacontains');
                Obstructionum ffi = foramenFurca.singleWhere((swff) =>
                    swff.probationem ==
                    opn.obstructionum.interiore.priorProbationem);
                do {
                  lo.removeLast();
                } while (lo.last.probationem !=
                    ffi.interiore.priorProbationem);
                lo.add(ffi);
                if (await validateObstructionum(
                    qi.clientis, lo, opn.obstructionum)) {
                  tridentes.add(opn.obstructionum);
                  if (opn.obstructionum.interiore.divisa <
                          prioro.interiore.divisa &&
                      opn.obstructionum.interiore
                              .summaObstructionumDifficultas >
                          prioro.interiore
                              .summaObstructionumDifficultas) {
                    await Obstructionum.removereUsqueAd(ffi, directorium);
                    await ffi.salvare(directorium);
                    await opn.obstructionum.salvare(directorium);
                  }
                  if (!opn.accepit.contains(ip)) {
                    opn.accepit.add(ip);
                  }
                  qi.clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                          opn.obstructionum,
                          PervideasNuntiusTitulus.obstructionumIsSalvare,
                          opn.accepit)
                      .indu()));
                }
                qi.clientis.destroy();
              } else if (opn.obstructionum.interiore.estFurca &&
                  !foramenFurca.map((mff) => mff.probationem).contains(opn
                      .obstructionum.interiore.priorProbationem)) {
                if (tridentes.map((mt) => mt.probationem).any((ap) =>
                    ap ==
                    opn.obstructionum.interiore.priorProbationem)) {
                  print(
                      'isloindeedalreadyfiuckedup ${lo.map((e) => e.toJson())}');
                  Obstructionum? fton = tridentes.singleWhere((swt) =>
                      swt.probationem ==
                      opn.obstructionum.interiore.priorProbationem);
                  List<Obstructionum> lof = [];
                  do {
                    lof.add(fton!);
                    fton = tridentes.singleWhereOrNull((swt) =>
                        swt.probationem ==
                        fton?.interiore.priorProbationem);
                    print('ftonloop');
                    print(fton?.toJson());
                  } while (fton != null);
                  print('whatislof ${lof.reversed.map((e) => e.toJson())}');
                  print('howaboutloaftertakeone');
                  List<Obstructionum> lov = [];
                  //this conddintion is never true it grabbed al the blocks instead of a couple
                  Obstructionum foramen = foramenFurca.singleWhere((swf) =>
                      swf.probationem ==
                      lof.last.interiore.priorProbationem);
                  lov.addAll(lo.takeWhile((two) =>
                      two.probationem !=
                      foramen.interiore.priorProbationem));
                  print('didlochange ${lo.map((e) => e.toJson())}');
                  lov.add(lo.singleWhere((swo) =>
                      swo.probationem ==
                      foramen.interiore.priorProbationem));
                  lov.add(foramen);
                  lov.addAll(lof.reversed);
                  print('thiscorruptchainofblocksdownhere');
                  for (Obstructionum o in lov) {
                    print('${o.toJson()}\n');
                    print('\n');
                  }
                  if (!await validateObstructionum(
                      qi.clientis, lov, opn.obstructionum)) {
                    break;
                  }
                  tridentes.add(opn.obstructionum);
                  if (opn.obstructionum.interiore.divisa <
                          prioro.interiore.divisa &&
                      opn.obstructionum.interiore
                              .summaObstructionumDifficultas >
                          prioro.interiore
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
                    par!.foramenFurca.remove(foramen);
                    await foramen.salvare(directorium);
                    for (Obstructionum o in lof.reversed) {
                      await o.salvare(directorium);
                    }
                    await opn.obstructionum.salvare(directorium);
                  }
                  qi.clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                          opn.obstructionum,
                          PervideasNuntiusTitulus.obstructionumIsSalvare,
                          opn.accepit)
                      .indu()));
                  qi.clientis.destroy();
                } else {
                  Print.nota(nuntius: 'invalidum furca', message: 'invalid fork');
                  break;
                }
              } else if (lo
                      .map((mo) => mo.probationem)
                      .contains(opn.obstructionum.probationem) &&
                  !opn.obstructionum.interiore.estFurca) {
                print('gotinunused');
                List<Obstructionum> loc = lo
                    .takeWhile((two) =>
                        two.interiore.priorProbationem !=
                        opn.obstructionum.probationem)
                    .toList();
                loc.removeLast();
                // Obstructionum o = loc.removeLast();
                print(loc.map((e) => e.toJson()));
                if (await validateObstructionum(
                    qi.clientis, loc, opn.obstructionum)) {
                  qi.clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                          opn.obstructionum,
                          PervideasNuntiusTitulus.obstructionumIsSalvare,
                          opn.accepit)
                      .indu()));
                  print('wewrotebacktosaveto ${clientis.address}:${clientis.port}');
                  qi.clientis.destroy();
                  break;
                }
                // loc.add(o);
              } else if (lo.map((mo) => mo.probationem).contains(opn
                      .obstructionum.interiore.priorProbationem) &&
                  !opn.obstructionum.interiore.estFurca) {
                print('howaboutlo');
                print(lo.map((e) => e.toJson()));
                // List<Obstructionum> lot = [lo.first];
                print('howaboutloaftertakeone');
                // List<Obstructionum> lok = lo.skip(1).toList();
                print(lo.map((e) => e.toJson()));
                List<Obstructionum> lov = [];
                lov.addAll(lo.takeWhile((two) =>
                    two.probationem !=
                    opn.obstructionum.interiore.priorProbationem));
                print('isprobwrong');
                lov.add(lo.singleWhere((swo) =>
                    swo.probationem ==
                    opn.obstructionum.interiore.priorProbationem));
                print(lo.map((e) => e.toJson()));
                if (await validateObstructionum(
                    qi.clientis, lov, opn.obstructionum)) {
                  if (opn.obstructionum.interiore.divisa <
                          prioro.interiore.divisa &&
                      opn.obstructionum.interiore
                              .summaObstructionumDifficultas >
                          prioro.interiore
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
                  qi.clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
                          opn.obstructionum,
                          PervideasNuntiusTitulus.obstructionumIsSalvare,
                          opn.accepit)
                      .indu()));
                  qi.clientis.destroy();
                }
              } else {
                print('notyethere');
                List<Obstructionum> loc = lo
                    .takeWhile((fwo) =>
                        fwo.probationem ==
                        opn.obstructionum.interiore.priorProbationem)
                    .toList();
                loc.add(lo.singleWhere((swo) =>
                    loc.last.probationem ==
                    swo.interiore.priorProbationem));

                if (!await validateObstructionum(
                    qi.clientis, loc, opn.obstructionum)) {
                  break;
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
              if (!await validateObstructionum(qi.clientis, lo, opn.obstructionum)) {
                break;
              }
              qi.clientis.write(json.encode(ObstructionumSalvarePervideasNuntius(
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
                    Obstructionum prior = await Obstructionum.acciperePrior(directorium);
                    isSalvare = true;
                    await ospn.obstructionum.salvare(directorium);
                    isSalvare = false;
                    removerePropterNovumObstructionum(prior, ospn.obstructionum);
                  });
                }
                // lets add blockproducer to the message and else if if aint blockproducer so a boolean so a ip
              } else if(opn.obstructionum.interiore.producentis != argumentis!.publicaClavis) {
                print('willsearchforrandomnodetovalidateblockagains');
                final random = Random();
                List<String> lbu = bases.where((wb) => wb != ip).toList();
                String nervuss = lbu[random.nextInt(lbu.length)];
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
                  Obstructionum prior = await Obstructionum.acciperePrior(directorium);
                  print('recievedpermissiontosalvare');
                  isSalvare = true;
                  await ospn.obstructionum.salvare(directorium);
                  isSalvare = false;
                  removerePropterNovumObstructionum(prior, ospn.obstructionum);
                  // nervus.destroy();
                });
              }
            }
            break;
          } 
          case PervideasNuntiusTitulus.addereForamenFurca: {
            SatusFurcaPropagationemPervideasNuntius sfppn =
              SatusFurcaPropagationemPervideasNuntius.ex(
                  json.decode(qi.msg) as Map<String, dynamic>);
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
        pass = true;
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
          if (orupn.obstructionum.interiore.generare ==
              Generare.incipio) {
            print('nowiwillsalvare');
            await orupn.obstructionum.salvareIncipio(directorium);
            nervus.write(json.encode(PetitioObstructionumPervideasNuntius(
                orupn.obstructionum.probationem,
                PervideasNuntiusTitulus.petitioObstructionum, []).indu()));
          } else {
            print('nowiwillsalvare');
            await orupn.obstructionum.salvare(directorium);
            nervus.write(json.encode(PetitioObstructionumPervideasNuntius(
                orupn.obstructionum.probationem,
                PervideasNuntiusTitulus.petitioObstructionum, []).indu()));
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
      nervus.write(json.encode(PetitioObstructionumPervideasNuntius(prior.probationem,
          PervideasNuntiusTitulus.petitioObstructionum, []).indu()));
      nervus.listen((eventus) async {
        PervideasNuntius pn = PervideasNuntius.ex(
            json.decode(String.fromCharCodes(eventus)) as Map<String, dynamic>);
        switch(pn.titulus) {
          case PervideasNuntiusTitulus.summaScandalumExNodo: {
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
            break;
          }
          case PervideasNuntiusTitulus.obstructionumReponereUna: {
            ObstructionumReponereUnaPervideasNuntius orupn =
            ObstructionumReponereUnaPervideasNuntius.ex(
                json.decode(String.fromCharCodes(eventus).trim())
                    as Map<String, dynamic>);
            print('nowiwillsalvare');
            await orupn.obstructionum.salvare(directorium);
            nervus.write(json.encode(PetitioObstructionumPervideasNuntius(
                orupn.obstructionum.probationem,
                PervideasNuntiusTitulus.petitioObstructionum, []).indu()));
          }
        }
      });
    }
  }

  Future syncPropter(Propter propter) async {
    if (rationibus.any((p) =>
        p.interiore.publicaClavis ==
        propter.interiore.publicaClavis)) {
      rationibus.removeWhere((p) =>
          p.interiore.publicaClavis ==
          propter.interiore.publicaClavis);
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
        alt.interiore.identitatis ==
        ltx.interiore.identitatis)) {
      print('removedonsendernode');
      liberTransactions.removeWhere((rwlt) =>
          rwlt.interiore.identitatis ==
          ltx.interiore.identitatis);
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
        t.interiore.identitatis ==
        tx.interiore.identitatis)) {
      fixumTransactions.removeWhere((t) =>
          t.interiore.identitatis ==
          tx.interiore.identitatis);
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
        t.interiore.identitatis ==
        tx.interiore.identitatis)) {
      expressiTransactions.removeWhere((t) =>
          t.interiore.identitatis ==
          tx.interiore.identitatis);
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

  Future syncInritaTransaction(InritaTransactio it) async {
    if (inritaTransactions.any((ait) => ait.interiore.identitatis == it.interiore.identitatis)) {
      inritaTransactions.removeWhere((rwit) => rwit.interiore.identitatis == it.interiore.identitatis);
    }
    inritaTransactions.add(it);
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
        asr.interiore.signatureInterioreSiRemotionem ==
        sr.interiore.signatureInterioreSiRemotionem)) {
      siRemotiones.removeWhere((rwsr) =>
          rwsr.interiore.signatureInterioreSiRemotionem ==
          sr.interiore.signatureInterioreSiRemotionem);
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
      fissileSolucionisRationibus.removeWhere((rwfsr) => rwfsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == fsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis);
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
  
  // proof you are the owner
  Future removeExpressiTransactions(List<String> identitatum) async {
    expressiTransactions.removeWhere(
        (l) => identitatum.any((i) => i == l.interiore.identitatis));
    for (String nervuss in bases.where((wb) => wb != ip)) {
      Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      // nervus.write(json.encode(RemoveTransactionsPervideasNuntius(
      //     TransactioGenus.expressi,
      //     identitatum,
      //     PervideasNuntiusTitulus.removeTransactions,
      //     [ip]).indu()));
      nervus.destroy();
    }
  }
  // proof you are the owner too
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

  Future inritaTransactio(InterioreInritaTransactio it) async {
    Transactio? t = it.liber ? 
    liberTransactions.singleWhereOrNull((swonlt) => swonlt.interiore.identitatis == it.identitatis) :
    fixumTransactions.singleWhereOrNull((swonft) => swonft.interiore.identitatis == it.identitatis);
    if (t == null) {
      throw BadRequest(code: 0, nuntius: 'transaction invenire non voluisti ut removere', message: 'could not find transaction you wanted to remove');      
    }
    it.liber ? liberTransactions.remove(t) : fixumTransactions.remove(t);
    for (String nervuss in bases.where((wb) => wb != ip)) {
      Socket nervus = await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write(json.encode(InritaTransactioPervideasNuntius(it, PervideasNuntiusTitulus.inritaTransactio, [ip]).indu()));
      nervus.destroy();
    }
  }


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
              'sended block with number: ${o.interiore.obstructionumNumerus} across the network',
          nuntius:
              'misit obstructionum cum numero: ${o.interiore.obstructionumNumerus} per network');
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
          Obstructionum prior = await Obstructionum.acciperePrior(directorium);
          isSalvare = true;          
          await oispn.obstructionum.salvare(directorium);
          isSalvare = false;
          removerePropterNovumObstructionum(prior, oispn.obstructionum);    
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
              Transactio? t = expressiTransactions.singleWhereOrNull((swet) => swet.interiore.inputs.any((ai) => ai.transactioIdentitatis == transactio.interiore.identitatis));
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
            (li) => li == cle.interioreConnexaLiberExpressi.identitatis));
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
      Print.obstructionumReprobatus();
      return false;
    }
    if (!obstructionum.transactionsIncluduntur(lo)) {
      Print.nota(nuntius: 'refered gestum obstructionum non est inventus', message: 'refered transaction of block is not found');
      Print.obstructionumReprobatus();
      return false;
    }
    if (!await convalidandumLiber(obstructionum.interiore.liberTransactions, lo)) {
      Print.nota(
        nuntius:
            'obstructionum ineuntes continet vestra corrumpere transactions',
        message: 'your incoming block contains corrupt transactions');
      Print.obstructionumReprobatus();
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
      Print.obstructionumReprobatus();
        return false;
    }
    for (SiRemotionem sr in obstructionum.interiore.siRemotiones.where((wsr) => wsr.interiore.siRemotionemOutput != null)) {
      if (!sr.interiore.cognoscereOutput()) {
        Print.nota(nuntius: 'corrumpere si remotionem output signature', message: 'corrupt si remotionem output signature');
        Print.obstructionumReprobatus();
        return false;
      }
      if (lo.any((ao) => sr.interiore.siRemotionemOutput!.liber ? ao.interiore.liberTransactions.any((alt) => alt.interiore.identitatis == sr.interiore.siRemotionemOutput!.transactioIdentitatis) : ao.interiore.fixumTransactions.any((aft) => aft.interiore.identitatis == sr.interiore.siRemotionemOutput!.transactioIdentitatis))) {
        Print.nota(nuntius: 'rem numquam removeri non potuit altius', message: 'transaction was never removed so could not create depth');
        Print.obstructionumReprobatus();
        return false;
      }
      if (!sr.interiore.siRemotionemOutput!.estTransactionIdentitatisAdhucPraesto(lo, obstructionum)) {
        Print.obstructionumReprobatus();
        return false;
      }
    }
    for (SiRemotionem sr in obstructionum.interiore.siRemotiones.where((wsr) => wsr.interiore.siRemotionemInput != null)) {
      if (!sr.interiore.siRemotionemInput!.cognoscere(lo)) {
        Print.nota(nuntius: 'corrumpere si remotionem input signature', message: 'corrupt si remotionem input signature');
        Print.obstructionumReprobatus();
        return false;
      }
      if (!lo.any((ao) => ao.interiore.siRemotiones.any((asr) => asr.interiore.signatureInterioreSiRemotionem == sr.interiore.siRemotionemInput!.siRemotionemSignature))) {
        Print.nota(nuntius: 'non inveniret profundum ut stipendium', message: 'could not find depth to pay ');
        Print.obstructionumReprobatus();
        return false;
      }
      if (!obstructionum.interiore.liberTransactions.any((alt) => alt.interiore.identitatis == sr.interiore.siRemotionemInput!.transactioIdentitatis) && !obstructionum.interiore.fixumTransactions.any((aft) => aft.interiore.identitatis == sr.interiore.siRemotionemInput!.transactioIdentitatis)) {
        Print.nota(nuntius: 'rem invenire non potuit reddere profundum', message: 'could not find transaction that would pay the depth');
        Print.obstructionumReprobatus();
        return false;
      }
      if (!sr.interiore.siRemotionemInput!.solvit(obstructionum, lo)) {
        Print.obstructionumReprobatus();
        return false;
      }
    }
    for (SolucionisPropter sp in obstructionum.interiore.solucionisRationibus) {
      if (!sp.interioreSolucionisPropter.estValidus(lo) || !sp.estProbationem() || !sp.interioreSolucionisPropter.quinSignature() || !sp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.nonAccipitEtMittente()) {
        Print.obstructionumReprobatus();
        return false;
      }
    }
    for (FissileSolucionisPropter fsp in obstructionum.interiore.fissileSolucionisRationibus) {
      if (fsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.fixs.isEmpty) {
        Print.nota(nuntius: 'certa pecunia ratio saltem certa', message: 'a fixed payment account should have at least one fixed amount');
        Print.obstructionumReprobatus();
        return false;
      }
      if (!fsp.interioreFissileSolucionisPropter.estValidus(lo) || !fsp.estProbationem() || !fsp.interioreFissileSolucionisPropter.quinSignature() || !fsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.nonAccipitEtMittente()) {
        Print.obstructionumReprobatus();
        return false;
      }
    }
    switch (obstructionum.interiore.generare) {
      case Generare.incipio:
        {
          Print.nota(
              nuntius: 'Ineuntes scandalum non attigit hanc',
              message: 'the incoming block should not have reached this state');
          Print.obstructionumReprobatus();
          return false;
        }
      case Generare.expressi: {
        if (lo.last.interiore.generare != Generare.efectus) {
          Print.nota(nuntius: 'an expressi scandalum fieri potest nisi super efectus scandalum', message: 'an expressi block can only occur on top of an efectus block');
          Print.obstructionumReprobatus();
          return false;
        }
      }
      case Generare.confussus:
        {
          if (await Obstructionum.gladiatorConfodiantur(
              obstructionum.interiore.gladiator.interiore.input!.victima.primis,
              obstructionum.interiore.gladiator.interiore
                  .input!.victima.identitatis,
              obstructionum.interiore.producentis,
              lo)) {
            Print.nota(
                nuntius: 'clausus potest non oppugnare publica clavem',
                message: 'block can not attack the same public key');
            Print.obstructionumReprobatus();
            return false;
          }
          if (!await obstructionum.convalidandumTransform(lo)) {
            Print.nota(
                nuntius: 'licet transformatio liber ad fixum',
                message: 'illegal transform of liber to fixum');
            Print.obstructionumReprobatus();
            return false;
          }
          if (!await obstructionum.vicit(lo)) {
            Print.nota(
                nuntius: 'nullum signum gladiatorium pugnae',
                message: 'invalid signature of gladiator battle');
            Print.obstructionumReprobatus();
            return false;
          }
          if (!await obstructionum.convalidandumPerdita(lo)) {
            Print.nota(nuntius: 'invalidum perdita', message: 'invalidum perdita');
            Print.obstructionumReprobatus();
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
            Print.obstructionumReprobatus();
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
          Print.obstructionumReprobatus();
          return false;
        }
        if (!await obstructionum.convalidandumObsturcutionumNumerus(
            incipio, lo.last)) {
          Print.nota(
              nuntius:
                  'Mittens huius obstructionum conatur cibum usque ad numerum obstructionum',
              message:
                  'the sender of this block is trying to mess up the block number');
          Print.obstructionumReprobatus();
          return false;
        }
        if (!obstructionum.convalidandumExpressiMoles()) {
          Print.obstructionumReprobatus();
          return false;
        }
        if (!await obstructionum.convalidandumRationibus(lo)) {
          Print.obstructionumReprobatus();
          return false;
        }
        default:
        {
          Print.nota(
              nuntius:
                  'in ineuntes obstructionum conatur facere aliquid illicitum',
              message:
                  'in ineuntes obstructionum conatur facere aliquid illicitum');
          Print.obstructionumReprobatus();
          return false;
        }
    }
    switch (await Obstructionum.estVerum(
        obstructionum.interiore, lo)) {
      case Corrumpo.forumCap:
        {
          Print.nota(
              nuntius: 'pecunia corrumpitur a mittente hoc scandalum',
              message:
                  'total amount of money is corrupt from the sender of this block');
          Print.obstructionumReprobatus();
          return false;
        }
      case Corrumpo.summaDifficultas:
        {
          Print.nota(
              nuntius: 'tota difficultas corrumpitur a mittente hoc scandalum',
              message: 'tota difficultas corrumpitur a mittente hoc scandalum');
          Print.obstructionumReprobatus();
          return false;
        }
      case Corrumpo.numerus:
        Print.nota(
            nuntius:
                'scandalum numerus est corruptus ab mittente hoc scandalum',
            message:
                'the block number is corrupt from the sender of this block');
        Print.obstructionumReprobatus();
        return false;
      case Corrumpo.divisa:
        Print.nota(
            nuntius: 'corrupta est divisio a mittente hoc scandalum',
            message: 'the division is corrupt from the sender of this block');
        Print.obstructionumReprobatus();
        return false;
      case Corrumpo.legalis:
        Print.obstructionumReprobatus();
        break;
    }
    switch (Obstructionum.fortiorEst(
        obstructionum.interiore, lo.last)) {
      case QuidFacere.solitum:
        {
          if (!Obstructionum.nonFortum(
                  obstructionum.interiore.liberTransactions) &&
              !Obstructionum.nonFortum(
                  obstructionum.interiore.fixumTransactions)) {
            Print.nota(
                nuntius: 'producens ad vos suscepit conatur furantur pecuniam',
                message:
                    'the producer of the block you recieved is trying to steal money');
            Print.obstructionumReprobatus();
            return false;
          }
          List<TransactioInput> lti = [];
          obstructionum.interiore.liberTransactions.map((mlt) => mlt.interiore.inputs).forEach(lti.addAll);
          List<TransactioOutput> outputs = [];
          obstructionum.interiore.liberTransactions
              .where((wlt) =>
                  wlt.interiore.transactioSignificatio !=
                      TransactioSignificatio.praemium &&
                  wlt.interiore.transactioSignificatio !=
                      TransactioSignificatio.ardeat &&
                  lti.any((ati) => ati.transactioIdentitatis == wlt.interiore.identitatis))
              .map((mlt) => mlt.interiore.outputs)
              .forEach(outputs.addAll);

              // we need to remove these outputs if one of the txs of the current block reference a tx of this block
              //
          if (!await Transactio.omnesClavesPublicasDefendi(outputs, lo)) {
            Print.nota(
                nuntius: 'non omnes claves publicae defenduntur',
                message: 'not all public keys are defended');
            Print.obstructionumReprobatus();
            return false;
          }
          if (obstructionum.interiore.generare ==
                  Generare.confussus ||
              obstructionum.interiore.generare ==
                  Generare.expressi) {
            List<TransactioInput> tis = [];
            obstructionum.interiore.liberTransactions
                .where((lt) =>
                    lt.interiore.transactioSignificatio ==
                    TransactioSignificatio.ardeat)
                .map((lt) => lt.interiore.inputs)
                .forEach(tis.addAll);
            if (!await Transactio.validateArdeat(tis, lo)) {
              Print.nota(
                  nuntius: 'corrumpere ardeat victos',
                  message: 'corrupt burn of the losers');
              Print.obstructionumReprobatus();
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
        asr.interiore.signatureInterioreSiRemotionem ==
        srpn.siRemotionem.interiore
            .signatureInterioreSiRemotionem)) {
      SiRemotionem sr = siRemotiones.singleWhere((swsr) => swsr.interiore.signatureInterioreSiRemotionem == srpn.siRemotionem.interiore.signatureInterioreSiRemotionem);
      int zerosOld = 0;
      for (int i = 1; i < sr.probationem.length; i++) {
        if (sr.probationem.substring(0, i) == ('0' * i)) {
          zerosOld += 1;
        }
      }
      int zerosNew = 0;
      for (int i = 1; i < srpn.siRemotionem.probationem.length; i++) {
        if (srpn.siRemotionem.probationem.substring(0, i) == ('0' * i)) {
          zerosNew += 1;
        }
      }
      if (zerosNew <= zerosOld) {
        Print.nota(nuntius: 'hoc si remotionem in si remotionems piscinae ius non habes', message: 'you do not have the right to replace this si remotionem in the si remotionems pool');
        return;
      }
      siRemotiones.removeWhere((rwsr) =>
          rwsr.interiore.signatureInterioreSiRemotionem ==
          srpn.siRemotionem.interiore
              .signatureInterioreSiRemotionem);
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
    // ltttip.addAll(lo.last.interiore.expressiTransactions);
    for (Transactio lt in llt) {
      switch(lt.interiore.transactioSignificatio) {
        case TransactioSignificatio.regularis: 
        case TransactioSignificatio.expressi:
        case TransactioSignificatio.refugium: {
          if (lt.minusQuamBidInProbationibus(llt, lo)) {
            if (lt.interiore.liber) {
              for (TransactioOutput to in lt.interiore.outputs) {
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
            Print.nota(nuntius: 'iustam rem non ex pretio ratio', message: 'regular transaction can not come from a payment account');
            return false;
          } 
        }
        case TransactioSignificatio.ardeat:
        case TransactioSignificatio.perdita: {
          if (!lt.estDominus(llt, lo) || lt.isFurantur() || !lt.verumMoles(llt, lo) || !lt.validateProbationem()) {
            print('bailedliberconv');
            return false;
          }
          break;
        }
        case TransactioSignificatio.solucionis:  
          if (!lt.convalidandumSolucionis(lo)) {
            print('solucioniserr');
            return false;
          } 
          continue sol;
        case TransactioSignificatio.fissile: {
          if (!lt.convalidandumSolucionisFissile(lo)) {
            print('fissileerr');
            return false;
          }
          continue sol;
        }
        case TransactioSignificatio.reliquiae: {
         if (!lt.convalidandumSolucionisReliquiae(lo)) {
            print('reliquiaeeerr');
            return false;
         } 
         continue sol;
        }
        case TransactioSignificatio.praemium: {
          Obstructionum incipio = await Obstructionum.accipereIncipio(directorium);
          if (!lt.validateBlockreward(incipio)) {
            return false;
          }
          if (!await Pera.isPublicaClavisDefended(lt.interiore.dominus, lo)) {
            Print.nota(nuntius: 'non potest habere obstructionum merces cum clavis publica indefensa', message: 'can not have a block reward with a undefended public key');
            return false;
          }
          break;
        }
        case TransactioSignificatio.transform: {
          break;
        }
        sol:
        default: {
          if (!lt.verumMoles(llt, lo)) {
            print('upferum');
            return false;
          }
          for (TransactioOutput to in lt.interiore.outputs) {
            if (!await Pera.isPublicaClavisDefended(to.publicaClavis, lo)) {
              Print.nota(nuntius: 'non potest mittere pecuniam publicam clavem indefensam', message: 'can not send money to undefended public key');
              return false;
            }
          }
          break;
        }
      }
    }

    return true;    
  }

  void removerePropterNovumObstructionum(Obstructionum prior, Obstructionum novus) {
  InFieriObstructionum ifo = novus.inFieriObstructionum();
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
    rationibus.removeWhere((rwr) => ifo.gladiatorIdentitatum.any((agi) => agi == rwr.interiore.publicaClavis));
    liberTransactions.removeWhere((rwlt) => ifo.liberTransactions.any((alt) => alt == rwlt.interiore.identitatis));
    fixumTransactions.removeWhere((rwft) => ifo.fixumTransactions.any((aft) => aft == rwft.interiore.identitatis));
    expressiTransactions.removeWhere((rwet) => ifo.expressiTransactions.any((aet) => aet == rwet.interiore.identitatis));
    siRemotiones.removeWhere((rwsr) => ifo.siRemotionems.any((asr) => asr == rwsr.interiore.signatureInterioreSiRemotionem));
    solucionisRationibus.removeWhere((rwsp) => ifo.solucionisRationibus.any((asp) => asp == rwsp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis));
    fissileSolucionisRationibus.removeWhere((rwfsp) => ifo.fissileSolucionisRationibus.any((afsp) => afsp == rwfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis));
    if ((prior.interiore.generare == Generare.efectus && novus.interiore.generare != Generare.efectus)) {
      par!.expressiTransactions = [];
    }
  }
}

