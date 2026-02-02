import 'dart:math'; //L'utilitzem per generar IDs aleatoris.

enum TipusLlicencia { compra, lloguer, prova }

class Llicencia {
  final String id;
  final TipusLlicencia tipus;
  int canvisPropietariRestants; // Comptador de canvis de propietari.
  int
  horesJocRestants; // Comptador d'hores de joc restants. Fare servir -1 per a il·limitat.

  //Aixo es un constructor privat per a que nomes es pugui fer de la forma que volem.
  Llicencia._(
    this.id,
    this.tipus,
    this.canvisPropietariRestants,
    this.horesJocRestants,
  );

  factory Llicencia.compra() {
    String idAleatorio = _generarId();
    return Llicencia._(idAleatorio, TipusLlicencia.compra, 3, -1);
  }

  factory Llicencia.prova() {
    String idAleatorio = _generarId();
    return Llicencia._(idAleatorio, TipusLlicencia.prova, 0, 3);
  }

  //Aqui farem servir el random per generar un ID.
  static String _generarId() {
    var random = Random();
    return "LIC-${random.nextInt(999999)}";
  }

  bool intentarTransferencia() {
    if (canvisPropietariRestants > 0) {
      canvisPropietariRestants--; //Restem un us a l'intent de transferencia.
      return true;
    }
    return false;
  }
}
