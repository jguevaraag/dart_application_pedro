enum Estil { shooter, plataformes, cartes, simulacio }

abstract class Videojoc<T> {
  final String nom;
  final String codi;
  final Estil estil;
  final double preuCompra;
  final double preuLloguer;

  Map<String, T> puntuacions = {};
  Videojoc(this.nom, this.codi, this.estil, this.preuCompra,this.preuLloguer);

  String get repteDelDia;

  String mostrarHighScores();

  void registrarPuntuacio(String email, T puntuacio) {
    puntuacions[email] = puntuacio;
  }
}