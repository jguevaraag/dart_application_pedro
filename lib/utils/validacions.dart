extension ValidacioEmail on String {
  bool isValidEmail() {
    // Lógica simple: contiene @ y .
    return contains('@') && contains('.');
  }
}
