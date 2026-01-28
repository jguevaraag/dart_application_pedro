enum Estil { shooter, plataformes, cartes, simulacio }

abstract class Videojoc<T> {
  final String nom;
  final String codi;
  final Estil estil;
  final double preuCompra;
  final double preuLloguer;

  // CORRECCIÓN: El requisito pide una lista de puntuaciones por usuario
  Map<String, List<T>> puntuacions = {};

  Videojoc(this.nom, this.codi, this.estil, this.preuCompra, this.preuLloguer);

  String get repteDelDia;

  // Método abstracto que obligará a las hijas a definir cómo se ordena su ranking
  String mostrarHighScores();

  void registrarPuntuacio(String email, T puntuacio) {
    // Si no existe la lista para este usuario, la crea
    if (!puntuacions.containsKey(email)) {
      puntuacions[email] = [];
    }
    puntuacions[email]!.add(puntuacio);
  }
}