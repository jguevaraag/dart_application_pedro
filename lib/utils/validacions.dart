extension ValidacioEmail on String {
  bool isValidEmail() {
    // Lógica simple: contiene @ y .
    return this.contains('@') && this.contains('.');
  }
}