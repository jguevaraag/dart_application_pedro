import 'package:dart_application_pedro/models/llicencia.dart';
import 'package:dart_application_pedro/models/usuari.dart';
import 'package:dart_application_pedro/models/videojoc.dart';
import 'package:dart_application_pedro/utils/validacions.dart';

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

  String? transferirLlicencia(
    Jugador origen,
    String emailDestino,
    Llicencia llicencia,
  ) {
    // Comprovem que la llicència pertany a l'usuari origen
    if (!origen.llicencies.contains(llicencia)) {
      return "Error: La llicència no pertany a l'usuari origen.";
    }

    // No podem transferir a si mateix
    if (origen.email == emailDestino) {
      return "Error: No pots transferir la llicència a tu mateix.";
    }

    // Comprovem existència usuari destí.
    var possibles = llistaUsuaris
        .where((u) => u.email == emailDestino)
        .toList();
    if (possibles.isEmpty) {
      return "Error: L'usuari $emailDestino no existeix.";
    }
    var desti = possibles.first;

    // Comprovem amistat.
    if (!origen.amics.contains(emailDestino)) {
      return "Error: Aquest usuari no està a la teva llista d'amics.";
    }

    // Intentem la transferència segons la lògica de Llicencia.
    if (!llicencia.intentarTransferencia()) {
      return "Error: Aquesta llicència ja no es pot transferir més cops.";
    }

    // Fem el canvi: eliminem de l'origen i afegim al destí.
    origen.llicencies.remove(llicencia);
    desti.llicencies.add(llicencia);

    return null;
  }
}
