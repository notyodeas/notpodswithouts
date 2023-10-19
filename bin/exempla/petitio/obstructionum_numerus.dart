class ObstructionumNumerus {
  List<int>? numerus;
  Map<String, dynamic> toJson() => {'numerus': numerus};
  ObstructionumNumerus.fromJson(Map<String, dynamic> map) {
    numerus = List<int>.from(map['numerus'] as List<dynamic>);
  }
}
