class BadRequest {
  final int code;
  final String nuntius;
  final String message;
  BadRequest(
      {required this.code, required this.nuntius, required this.message});
  Map<String, dynamic> toJson() =>
      {'code': code, 'nuntius': nuntius, 'message': message};
}
