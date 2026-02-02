import 'dart:io';
import '../data/dades.dart';
import 'package:dart_application_pedro/models/videojoc.dart';

class PartidaView {
  // Fiquem el joc actual com a atribut de la classe.
  final Videojoc jocActual;

  PartidaView(this.jocActual);

  void menuPartida() {
    bool sortir = false;

    while (!sortir) {
      print("\n--- JUGANT A: ${jocActual.nom} ---");

      // Mostrem el repte del dia segons el tipus de joc.
      _imprimirRepteDelDia(jocActual);

      print("[P] Jugar Partida (Puntuació)");
      print("[H] Veure Highscores");
      print("[E] Sortir al menú anterior");

      stdout.write("Acció: ");
      String opcio = stdin.readLineSync()?.toUpperCase() ?? "";

      switch (opcio) {
        case 'P':
          _jugarPartida();
          break;
        case 'H':
          print(jocActual.mostrarHighscores());
          break;
        case 'E':
          sortir = true;
          break;
      }
    }
  }

  // Metode privat per imprimir el repte del dia segons el tipus de joc.
  void _imprimirRepteDelDia(Videojoc joc) {
    var textRepte = switch (joc) {
      JocPunts() => "REPTE: Aconsegueix 5000 punts en una partida!",
      JocSpeedRun() => "REPTE: Completa el nivell en menys de 5 minuts!",
    };
    print(textRepte);
  }

  void _jugarPartida() {
    print("Jugant... ");
    stdout.write("Quina puntuació has tret? ");
    String input = stdin.readLineSync() ?? "0";

    //Verifiquem el tipus de joc per guardar la puntuació correctament.
    if (jocActual is JocPunts) {
      int punts = int.tryParse(input) ?? 0;
      (jocActual as JocPunts).registrarPuntuacio(
        Dades().usuariActiu!.email,
        punts,
      );
    } else if (jocActual is JocSpeedRun) {
      double temps = double.tryParse(input) ?? 0.0;
      (jocActual as JocSpeedRun).registrarPuntuacio(
        Dades().usuariActiu!.email,
        temps,
      );
    }

    print("Puntuació guardada!");
  }
}
