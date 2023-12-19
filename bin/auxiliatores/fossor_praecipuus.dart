
import 'package:tuple/tuple.dart';

import '../exempla/connexa_liber_expressi.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/incipit_pugna.dart';
import '../exempla/solucionis_propter.dart';
import '../exempla/transactio.dart';
import 'package:collection/collection.dart';
import 'package:elliptic/elliptic.dart';

class COE {
  int maxime;
  List<Transactio> llt;
  List<Transactio> lft;
  COE({ required this.maxime, required this.llt, required this.lft });

  Map<String, dynamic> toJson() => {
    'maxime': maxime,
    'llt': llt.map((e) => e.toJson()).toList(),
    'lft': lft.map((e) => e.toJson()).toList()
  };

  static Future<COE> computo(int maxime, Obstructionum prior, Gladiator gladiator, IncipitPugna ip, List<Transactio> llt, List<Obstructionum> lo) async {
    List<Transactio> llttbi = [];
    List<Transactio> lfttbi = [];
    List<Transactio> ltp = [];
    List<String> llti = [];
    for (String acc in gladiator
          .interioreGladiator.outputs[ip.victima!.primis! ? 0 : 1].rationibus
          .map((e) => e.interiorePropter.publicaClavis)) {
      InterioreTransactio? it = await Pera.perdita(
        PrivateKey.fromHex(Pera.curve(), ip.privatusClavis!),
        acc,
        prior.probationem,
        llt,
        lo);
      if (it != null) {
        ltp.add(Transactio.nullam(it));
        llti.add(it.identitatis);
        maxime -= it.inputs.length;
      }
    }
    llttbi.addAll(ltp);
    List<Transactio> ltpr = [];
    for (Transactio t in ltp) {
      Transactio? rtt = llt.singleWhereOrNull((swonlt) => t.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interioreTransactio.identitatis) && !llti.contains(swonlt.interioreTransactio.identitatis));
      while (rtt != null) {
        ltpr.add(rtt);
        llti.add(rtt.interioreTransactio.identitatis);
        maxime -= 1;
        rtt = llt.singleWhereOrNull((swonlt) => rtt!.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interioreTransactio.identitatis) && !llti.contains(swonlt.interioreTransactio.identitatis));
      }
    }
    llttbi.insertAll(0, ltpr);
    List<Transactio> lttf = [];
    Tuple2<InterioreTransactio?, InterioreTransactio?> transform =
          await Pera.transformFixum(
              ip.privatusClavis!, llt, lo);
    if (transform.item1 != null) {
      llttbi.add(Transactio.nullam(transform.item1!));
      maxime -= transform.item1!.inputs.length;
      for (TransactioInput ti in transform.item1!.inputs) {
        Transactio? ift = llt.singleWhereOrNull((swonlt) => swonlt.interioreTransactio.identitatis == ti.transactioIdentitatis && !llti.contains(swonlt.interioreTransactio.identitatis));
        while (ift != null) {
          lttf.add(ift);
          llti.add(ift.interioreTransactio.identitatis); 
          maxime -= 1;
          ift = llt.singleWhereOrNull((swonlt) => ift!.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interioreTransactio.identitatis) && !llti.contains(swonlt.interioreTransactio.identitatis));
        }  
      }
    }
    if (transform.item2 != null) {
      lfttbi.add(Transactio.nullam(transform.item2!));
    }
    llttbi.insertAll(0, lttf);
    return COE(maxime: maxime, llt: llttbi, lft: lfttbi);
  }
}

class FossorPraecipuus {
  List<Transactio> llttbui = [];
  List<Transactio> llttbi = [];
  List<String> llti = [];
  List<ConnexaLiberExpressi> lcletbi = [];
  List<String> lclei = [];
  List<Transactio> lettbi = [];
  List<String> leti = [];
  List<Transactio> lfttbui = [];
  List<Transactio> lfttbi = [];
  List<String> lfti = [];
  List<Propter> lptbi = [];
  List<String> lpi = [];
  List<SiRemotionem> lsrtbi = [];
  List<String> lsri = [];
  List<SolucionisPropter> lsptbi = [];
  List<String> lspi = [];
  List<FissileSolucionisPropter> lfsptbi = [];
  List<String> lfspi = [];

  List<String> referreDebetIdentitatumLiber = [];
  List<String> referreDebetIdentitatumExpressi = [];

  FossorPraecipuus({ required bool efectus, required int maxime, required Iterable<Transactio> llt, required Iterable<Transactio> lft, required Iterable<Transactio> let, required Iterable<ConnexaLiberExpressi> lcle, required Iterable<SiRemotionem> lsr, required Iterable<Propter> lp, required Iterable<SolucionisPropter> lsp, required Iterable<FissileSolucionisPropter> lfsp, required Iterable<Obstructionum> lo }) {
    llt.map((mlt) => mlt.interioreTransactio.identitatis).forEach(referreDebetIdentitatumLiber.add);
    List<Transactio> llttm = [];
    lo.map((mo) => mo.interioreObstructionum.liberTransactions).forEach(llttm.addAll);
    llttm.map((mlt) => mlt.interioreTransactio.identitatis).forEach(referreDebetIdentitatumLiber.add);
    bool istxs = false;
    bool capta = false;
    for (int i = 128; i > 0; i--) {
      capta = false;
      istxs = true;
      while ((maxime > 0 && !capta) || (istxs && !capta)) {
        int tslt = llttbui.length;
        llttbui.addAll(
            llt.where((wlt) => wlt.probationem.startsWith('0' * i) && !llti.contains(wlt.interioreTransactio.identitatis) && wlt.interioreTransactio.inputs.every((ei) => referreDebetIdentitatumLiber.contains(ei.transactioIdentitatis))  && wlt.interioreTransactio.probatur).isNotEmpty ?  
          llt.where((wlt) => wlt.probationem.startsWith('0' * i) && !llti.contains(wlt.interioreTransactio.identitatis) && wlt.interioreTransactio.inputs.every((ei) => referreDebetIdentitatumLiber.contains(ei.transactioIdentitatis)) && wlt.interioreTransactio.probatur) : 
          []
        );
        maxime -= (llttbui.length - tslt);
        llti.addAll(llttbui.map((e) => e.interioreTransactio.identitatis));
        maxime -= llttbui.length;
        List<Transactio> llttba = [];
        for (Transactio t in llttbui) {
          for (TransactioInput ti in t.interioreTransactio.inputs) {
            Transactio? rt = llt.singleWhereOrNull((swonlt) => swonlt.interioreTransactio.identitatis == ti.transactioIdentitatis && !llttbui.map((mlt) => mlt.interioreTransactio).contains(swonlt.interioreTransactio) && !llti.contains(swonlt.interioreTransactio.identitatis));
            while (rt != null) {
              maxime -= 1;
              llttba.add(rt);
              llti.add(rt.interioreTransactio.identitatis);
              rt = llt.singleWhereOrNull((swonlt) => rt!.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interioreTransactio.identitatis) && !llti.contains(swonlt.interioreTransactio.identitatis)  && !llttba.map((mlt) => mlt.interioreTransactio).contains(swonlt.interioreTransactio) && !llttbui.map((mlt) => mlt.interioreTransactio).contains(swonlt.interioreTransactio));
            }
          }
        }
        print('jupjallttbui \n${llttbui.map((e) => e.toJson())} and ja llttba \n ${llttba.map((e) => e.toJson())}');
        llttbi.addAll(llttbui);
        llttbi.addAll(llttba);
        llttbui = [];
        print('ohholdup llttbi had value ${llttbi.map((e) => e.toJson())}');

        if (efectus) {
          int tscle = lcletbi.length;
          List<String> llttbii = [];
          llttbi.map((mlttbi) => mlttbi.interioreTransactio.identitatis).forEach(llttbii.add);
          lcletbi.addAll(lcle.where((cle) => llttbii.any((alti) => alti == cle.interioreConnexaLiberExpressi.liberIdentitatis) && !lclei.contains(cle.interioreConnexaLiberExpressi.identitatis)).toList());
          maxime -= (lcletbi.length - tscle);
          lclei.addAll(lcletbi.map((mcle) => mcle.interioreConnexaLiberExpressi.identitatis));
          lettbi.addAll(let
              .where((et) => lcle.any((cle) =>
              cle.interioreConnexaLiberExpressi.expressiIdentitatum.any((aei) => aei == et.interioreTransactio.identitatis)) && !leti.contains(et.interioreTransactio.identitatis)));
          leti.addAll(lettbi.map((met) => met.interioreTransactio.identitatis));
        }
        istxs = false;
        istxs = true;
        int tsft = lfttbui.length;
        lfttbui.addAll(
          lft.where((wft) => wft.probationem.startsWith('0' * i) && !lfti.contains(wft.interioreTransactio.identitatis)  && wft.interioreTransactio.probatur).isNotEmpty ?  
          lft.where((wft) => wft.probationem.startsWith('0' * i) && !lfti.contains(wft.interioreTransactio.identitatis) && wft.interioreTransactio.probatur): 
          []
        );
        lfti.addAll(lfttbui.map((e) => e.interioreTransactio.identitatis));
        maxime -= (lfttbui.length - tsft);
        List<Transactio> lfttba = [];
        for (Transactio t in lfttbui) {
          for (TransactioInput ti in t.interioreTransactio.inputs) {
            Transactio? rt = lft.singleWhereOrNull((swonft) => swonft.interioreTransactio.identitatis == ti.transactioIdentitatis);
            while (rt != null) {
              maxime -= 1;
              lfttba.add(rt);
              lfti.add(rt.interioreTransactio.identitatis);
              rt = lft.singleWhereOrNull((swonft) => rt!.interioreTransactio.inputs.any((ai) => ai.transactioIdentitatis == swonft.interioreTransactio.identitatis) && !lfti.contains(swonft.interioreTransactio.identitatis));
            }
          }
        }
        lfttbi.addAll(llttbui);
        lfttbi.addAll(lfttba);
        lfttbui = [];
        istxs = false;
        istxs  = true;
        int tssr = lsrtbi.length;
        lsrtbi.addAll(lsr.where((wsr) => wsr.probationem.startsWith('0' * i) && !lsri.contains(wsr.interioreSiRemotionem.identitatisInterioreSiRemotionem)));
        lsri.addAll(lsrtbi.map((msr) => msr.interioreSiRemotionem.identitatisInterioreSiRemotionem));
        maxime -= (lsrtbi.length - tssr);
        List<Transactio> lltrbsr = [];
        lsrtbi.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null && wsr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!.liber).map((msr) => Transactio.nullam(msr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!)).forEach(lltrbsr.add);
        llttbi.addAll(lltrbsr);
        maxime -= lltrbsr.length;
        List<Transactio> lftrbsr = [];
        lsrtbi.where((wsr) => wsr.interioreSiRemotionem.siRemotionemInput != null && !wsr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!.liber).map((msr) => Transactio.nullam(msr.interioreSiRemotionem.siRemotionemInput!.interioreTransactio!)).forEach(lftrbsr.add);
        lfttbi.addAll(lftrbsr);
        maxime -= lftrbsr.length;
        istxs = false;
        int tslp = lptbi.length;
        lptbi.addAll(lp.where((wp) => wp.probationem.startsWith('0' * i) && !lpi.contains(wp.interiorePropter.identitatis)));
        lpi.addAll(lptbi.map((mp) => mp.interiorePropter.identitatis));
        maxime -= (lp.length - tslp);

        int tssp = lsptbi.length;
        lsptbi.addAll(lsp.where((wsp) => wsp.probationem.startsWith('0' * i) && !lspi.contains(wsp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis)));
        lspi.addAll(lsptbi.map((msp) => msp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis));
        maxime -= (lsptbi.length - tssp);
        int tsfsp = lfsp.length;
        lfsptbi.addAll(lfsp.where((wfsp) => wfsp.probationem.startsWith('0' * i) && lfspi.contains(wfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis)));
        lfspi.addAll(lfsptbi.map((mfsp) => mfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis));
        maxime -= (lfsptbi.length - tsfsp);
        print('reachedendcaptawillbetrue');
        capta = true;        
      }
    }
  }
  FossorPraecipuus.coe({ required this.llttbi, required this.lfttbi, required bool efectus, required int maxime, required Iterable<Transactio> llt, required Iterable<Transactio> lft, required Iterable<Transactio> let, required Iterable<ConnexaLiberExpressi> lcle, required Iterable<SiRemotionem> lsr, required Iterable<Propter> lp, required Iterable<SolucionisPropter> lsp, required Iterable<FissileSolucionisPropter> lfsp, required Iterable<Obstructionum> lo }) {
    FossorPraecipuus(efectus: efectus, maxime: maxime, llt: llt, lft: lft, let: let, lcle: lcle, lsr: lsr, lp: lp, lsp: lsp, lfsp: lfsp, lo: lo);
  }

}