

import 'dart:collection';

import '../constantes.dart';

class SiRemotionemRemove {
  String ex;
  String signature;
  SiRemotionemRemove.fromJson(Map<String, dynamic> map):
    ex = map[JSON.ex],
    signature = map[JSON.signature];
}