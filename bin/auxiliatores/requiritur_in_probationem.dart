
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/incipit_pugna.dart';
import '../exempla/telum.dart';

class RequiriturInProbationem {

  static Future<List<String>> requiriturInProbationem(IncipitPugna ip, List<Obstructionum> lo) async {
    List<Telum> impetus = [];
    impetus.addAll(await Pera.maximeArma(true, ip.inimicus!.primis!, true,
        ip.inimicus!.gladiatorIdentitatis!, lo));
    impetus.addAll(await Pera.maximeArma(false, ip.inimicus!.primis!, false,
        ip.inimicus!.gladiatorIdentitatis!, lo));
    List<Telum> defensiones = [];
    defensiones.addAll(await Pera.maximeArma(true, ip.inimicus!.primis!, false,
        ip.victima!.gladiatorIdentitatis!, lo));
    defensiones.addAll(await Pera.maximeArma(false, ip.inimicus!.primis!, false,
        ip.victima!.gladiatorIdentitatis!, lo));
    List<String> gladii = impetus.map((e) => e.telum).toList();
    List<String> scuta = defensiones.map((e) => e.telum).toList();
    final String baseDefensio = await Pera.turpiaGladiatoriaTelum(
        ip.victima!.primis!, false, ip.victima!.gladiatorIdentitatis!, lo);
    final String baseImpetum = await Pera.turpiaGladiatoriaTelum(
        ip.inimicus!.primis!, true, ip.inimicus!.gladiatorIdentitatis!, lo);
    scuta.add(baseDefensio);
    gladii.add(baseImpetum);
    scuta.removeWhere((defensio) => gladii.any((ag) => ag == defensio));
    return scuta;
  }
}