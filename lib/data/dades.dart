import 'package:dart_application_pedro/models/usuari.dart';
import 'package:dart_application_pedro/models/videojoc.dart';

class Dades {
  //Creamos una unica instancia de esta clase (Singleton).
  static final Dades _instance = Dades._();

  //Amb aquest factory retornem la instancia unica.
  factory Dades() => _instance;

  //Aquest constructor evita que es pugui crear mes d'una instancia.
  Dades._();

  //Llistes on posarem les dades de l'aplicació.
  final List<Jugador> llistaUsuaris = [];
  final List<Videojoc> catalegVideojocs = [];

  //En esta instancia de Judagor guardarem l'usuari que ha fet login.
  Jugador? usuariActiu;

  // Farem un metode que quan s'inicii l'aplicació carregui dades inicials de prova.
  void carregarDadesInicials() {
    catalegVideojocs.add(
      JocPunts("Super Dart Bros", "mario", Estil.plataformes, 50.0, 5.0),
    );
    catalegVideojocs.add(
      JocSpeedRun("Sonic Dart", "sonic", Estil.plataformes, 40.0, 4.0),
    );

    llistaUsuaris.add(Jugador("admin@test.com", "Admin", "1234"));
  }
}
