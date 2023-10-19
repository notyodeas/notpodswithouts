bla() {
  List<String> t = ["a", "b", "c", "d"];
  t.removeWhere((element) => element[0] == "a");
  print(t);
}

void main() {
  bla();
}
