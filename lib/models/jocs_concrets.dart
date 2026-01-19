import 'videojoc.dart';

class JocsPunts extends Videojoc<int> {
  JocsPunts(String nom, String codi, Estil estil, double compra, double lloguer)
      : super(nom, codi, estil, compra, lloguer);

      @override
  String get repteDelDia => "Guanya 2000 punts avui!";

  @override
  String mostrarHighScores() {
    var resultat = StringBuffer(); 
    resultat.write("TOP 10 Punts:\n");
    puntuacions.forEach((user, points) {
       resultat.write("$user: $points\n"); 
    });
    return resultat.toString();
  }
}

class JocSpeedRun extends Videojoc<double> {
  JocSpeedRun(String nom, String codi, Estil estil, double compra, double lloguer)
      : super(nom, codi, estil, compra, lloguer);

  @override
  String get repteDelDia => "Acaba en menys de 2h";

  @override
  String mostrarHighScores() {
    return "Ranking de tiempos (menor es mejor): \n $puntuacions";
  }
}