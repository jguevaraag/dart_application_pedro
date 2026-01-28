import 'videojoc.dart';

class JocsPunts extends Videojoc<int> {
  JocsPunts(super.nom, super.codi, super.estil, super.compra, super.lloguer);

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
  JocSpeedRun(super.nom, super.codi, super.estil, super.compra, super.lloguer);

  @override
  String get repteDelDia => "Acaba en menys de 2h";

  @override
  String mostrarHighScores() {
    return "Ranking de tiempos (menor es mejor): \n $puntuacions";
  }
}

class JocDuel extends Videojoc<bool> {
  JocDuel(super.nom, super.codi, super.estil, super.compra, super.lloguer);

  @override
  String get repteDelDia => "Guanya 3 partides seguides!";

  @override
  String mostrarHighScores() {
    // Lógica compleja de ordenación según requisito 2:
    // 1. % Victorias. 2. En empate, más victorias totales.

    var entries = puntuacions.entries.toList();

    entries.sort((a, b) {
      // Usuario A
      int winsA = a.value.where((v) => v == true).length;
      int totalA = a.value.length;
      double ratioA = totalA == 0 ? 0 : winsA / totalA;

      // Usuario B
      int winsB = b.value.where((v) => v == true).length;
      int totalB = b.value.length;
      double ratioB = totalB == 0 ? 0 : winsB / totalB;

      // Ordenar: primero compara ratio
      int compareRatio = ratioB.compareTo(ratioA); // Descendente
      if (compareRatio != 0) return compareRatio;

      // Si ratio es igual, quien tenga más victorias gana
      return winsB.compareTo(winsA);
    });

    // Formatear salida
    StringBuffer sb = StringBuffer();
    sb.writeln("--- Rànquing Duels ---");
    for (var e in entries.take(10)) {
      // Top 10
      int wins = e.value.where((v) => v).length;
      int total = e.value.length;
      double pct = total == 0 ? 0 : (wins / total) * 100;
      sb.writeln("${e.key}: ${pct.toStringAsFixed(1)}% wr ($wins victories)");
    }
    return sb.toString();
  }
}
