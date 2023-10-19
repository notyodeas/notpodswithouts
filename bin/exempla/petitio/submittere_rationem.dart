import '../constantes.dart';

class SubmittereRationem {
  String? publicaClavis;
  Map<String, dynamic> toJson() => {JSON.publicaClavis: publicaClavis};
  SubmittereRationem.fromJson(Map<String, dynamic> map)
      : publicaClavis = map[JSON.publicaClavis].toString();
}
