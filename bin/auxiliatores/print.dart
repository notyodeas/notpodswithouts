class Print {
  static nota({required String nuntius, required String message}) {
    print('\n');
    print('nuntius: $nuntius');
    print('message: $message');
  }
  static obstructionumReprobatus() {
    print('\n');
    print('corrumpere obstructionum deprehensis in sync');
    print('corrupt block detected upon sync');
  }

  static write(dynamic object) {
      print(' \n clientiswroteback \n ');
      print(object);
  }
  static wroteThrough(dynamic object) {
      print(' \n clientiswrotethrough \n ');
      print(object);
  }
}
