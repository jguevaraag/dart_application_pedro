enum Estil { shooter, plataformes, cartes, simulacio }

//Clase sealed para els videojocs generics
sealed class Videojoc<T> {
  final String nom;
  final String codi;
  final Estil estil;
  final double preuCompra;
  final double preuLloguer;

  //Utilitzem un Map per guardar les puntuacions dels usuaris y ho posem amb el tipus genèric T.
  final Map<String, T> puntuacions = {};

  //Fem el constructor que utilitzen les subclasses
  Videojoc(this.nom, this.codi, this.estil, this.preuCompra, this.preuLloguer);

  // Mètode abstracte per mostrar els highscores segons el tipus de joc.
  String mostrarHighscores();

  // Getter abstracte per obtenir el repte del dia.
  String get repteDelDia;

  // Mètode per registrar una puntuació.
  void registrarPuntuacio(String email, T puntuacio) {
    puntuacions[email] = puntuacio;
  }
}

class JocPunts extends Videojoc<int> {
  // Usamos 'super' para pasar los datos al padre
  JocPunts(String nom, String codi, Estil estil, double compra, double lloguer)
    : super(nom, codi, estil, compra, lloguer);

  @override
  String get repteDelDia => "Guanya 2000 punts avui!"; // Reto específico [5]

  @override
  String mostrarHighscores() {
    // Lógica simple: Imprimir el mapa
    // (Para nota alta habría que ordenar, pero primero hagamos que funcione)
    return "Ranking Puntos: $puntuacions";
  }
}

class JocSpeedRun extends Videojoc<double> {
  JocSpeedRun(
    String nom,
    String codi,
    Estil estil,
    double compra,
    double lloguer,
  ) : super(nom, codi, estil, compra, lloguer);

  @override
  String get repteDelDia => "Acaba en menys de 2h!";

  @override
  String mostrarHighscores() {
    return "Ranking Tiempo (Menos es mejor): $puntuacions";
  }
}
