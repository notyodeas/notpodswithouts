
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/incipit_pugna.dart';
import '../exempla/telum.dart';

class RequiriturInProbationem {

  static Future<List<String>> requiriturInProbationem(bool iPrimis, String iIdentitatis, Victima victima, List<Obstructionum> lo) async {
    List<Telum> impetus = [];
    impetus.addAll(await Pera.maximeArma(liber: true, primis: iPrimis, impetum: true, gladiatorIdentitatis:
        iIdentitatis, lo: lo));
    impetus.addAll(await Pera.maximeArma(liber: false, primis: iPrimis, impetum: true, gladiatorIdentitatis: iIdentitatis, lo: lo));
    List<Telum> defensiones = [];
    defensiones.addAll(await Pera.maximeArma(liber: true, primis: victima.primis, impetum: false,
        gladiatorIdentitatis: victima.identitatis, lo: lo));
    defensiones.addAll(await Pera.maximeArma(liber: false, primis: iPrimis, impetum: false,
        gladiatorIdentitatis: victima.identitatis, lo: lo));
    List<String> gladii = [];
    impetus.map((mi) => mi.telum).forEach(gladii.addAll);
    List<String> scuta = [];
    defensiones.map((e) => e.telum).forEach(scuta.addAll);
    final String baseDefensio = await Pera.turpiaGladiatoriaTelum(
        victima.primis, false, victima.identitatis, lo);
    final String baseImpetum = await Pera.turpiaGladiatoriaTelum(
        iPrimis, true, iIdentitatis, lo);
    scuta.add(baseDefensio);
    gladii.add(baseImpetum);
    scuta.removeWhere((defensio) => gladii.any((ag) => ag == defensio));
    return scuta;
  }
}