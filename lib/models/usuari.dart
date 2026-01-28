import 'llicencia.dart';

class Jugador {
  final String email;
  final String nick;
  final String password;
  final DateTime dataAlta;

  final List<String> amics = [];

  final List<Llicencia> llicencies = [];

  // Fem que la data d'alta sigui la data actual en el moment de crear l'usuari.
  Jugador(this.email, this.nick, this.password) : dataAlta = DateTime.now();
}
