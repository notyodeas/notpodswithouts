import '../constantes.dart';
import '../telum.dart';

class GladiatorArma {
  String basisDefensio;
  String basisImpetum;
  List<Telum> defensionesLiber;
  List<Telum> impetusLiber;
  List<Telum> defensionesFixum;
  List<Telum> impetusFixum;
  GladiatorArma({
    required this.basisDefensio,
    required this.basisImpetum,
    required this.defensionesLiber,
    required this.impetusLiber,
    required this.defensionesFixum,
    required this.impetusFixum,
  });

  Map<String, dynamic> toJson() => {
        JSON.basisDefensio: basisDefensio,
        JSON.basisImpetum: basisImpetum,
        JSON.gladiatorDefensionesLiber:
            defensionesLiber.map((dl) => dl.toJson()).toList(),
        JSON.gladiatorDefensionesFixum:
            defensionesFixum.map((gf) => gf.toJson()).toList(),
        JSON.gladiatorImpetusLiber:
            impetusLiber.map((sil) => sil.toJson()).toList(),
        JSON.gladiatorImpetusFixum:
            impetusFixum.map((sif) => sif.toJson()).toList(),
      };
}
