//Aquesta extensió afegeix una funció per validar si un correu electrònic és vàlid.
extension ValidacioEmail on String {
  bool isValidEmail() {
    return contains('@') && contains('.');
  }
}
