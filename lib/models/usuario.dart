import 'llicencia.dart';

class Jugador {
  final String email;
  final String nick;
  final String password; // Simplificado para la práctica
  final DateTime dataCreacio;
  
  // Lista de amigos (otros jugadores)
  List<Jugador> amics = [];
  
  // Inventario de licencias (Juego -> Llicencia)
  // Usamos un Map para acceder rápido por código de juego
  Map<String, Llicencia> llicencies = {};

  // Constructor
  Jugador(this.email, this.nick, this.password) 
      : dataCreacio = DateTime.now();

  // Gestión de amigos [Cite: Requisito 6.2 - F, A]
  void afegirAmic(Jugador amic) {
    if (!amics.contains(amic) && amic != this) {
      amics.add(amic);
    }
  }

  String llistarAmics() {
    if (amics.isEmpty) return "No tens amics :(";
    return amics.map((a) => "- ${a.nick} (${a.email})").join("\n");
  }
}