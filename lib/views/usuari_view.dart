import 'dart:io';
import 'package:dart_application_pedro/models/llicencia.dart';
import 'package:dart_application_pedro/models/videojoc.dart';
import '../data/dades.dart';

class UsuariView {
  Videojoc? menuUsuari() {
    bool enrere = false;

    while (!enrere) {
      //Ens asegurem que l'usuari actiu no és null.
      var user = Dades().usuariActiu!;

      print("\n--- MENÚ USUARI: ${user.nick} ---");
      print("[B] Botiga (Llistar Jocs)");
      print("[C] Comprar Joc");
      print("[P] Provar Joc (Demo)");
      print("[J] Jugar");
      print("[D] Donar Joc a un Amic");
      print("[F] Fer Amic");
      print("[A] Els meus Amics");
      print("[E] Enrere (Logout)");

      stdout.write("Opció: ");
      String opcio = stdin.readLineSync()?.toUpperCase() ?? "";

      switch (opcio) {
        case 'B':
          _llistarBotiga();
          break;
        case 'C':
          _adquirirLlicencia(TipusLlicencia.compra);
          break;
        case 'P':
          _adquirirLlicencia(TipusLlicencia.prova);
          break;
        case 'J':
          //Retornem el joc triat per jugar.
          var juego = _triarJocPerJugar();
          if (juego != null) {
            return juego;
          }
          break;
        case 'D':
          _donarJoc();
          break;
        case 'F':
          _ferAmic();
          break;
        case 'A':
          print("Amics: ${user.amics}");
          break;
        case 'E':
          Dades().usuariActiu = null;
          return null;
        default:
          print("Opció incorrecta");
      }
    }
  }

  void _llistarBotiga() {
    print("Jocs disponibles:");
    // Fem el recorregut de la llista de jocs.
    for (var joc in Dades().catalegVideojocs) {
      print(
        "- [${joc.codi}] ${joc.nom} (${joc.estil.name}) - ${joc.preuCompra}€",
      );
    }
  }

  void _adquirirLlicencia(TipusLlicencia tipus) {
    _llistarBotiga();
    stdout.write("Escriu el CODI del joc: ");
    String codi = stdin.readLineSync() ?? "";

    try {
      // Busquem el joc pel codi.
      var joc = Dades().catalegVideojocs.firstWhere((j) => j.codi == codi);

      // Creem la llicència segons el tipus.
      Llicencia novaLlicencia;
      if (tipus == TipusLlicencia.compra) {
        novaLlicencia = Llicencia.compra();
      } else {
        novaLlicencia = Llicencia.prova();
      }

      // Se la donem a l'usuari actiu.
      Dades().usuariActiu!.llicencies.add(novaLlicencia);
      print("Llicència de ${joc.nom} adquirida correctament!");
    } catch (e) {
      print("Codi de joc no vàlid.");
    }
  }

  Videojoc? _triarJocPerJugar() {
    print("--- ELS TEUS JOCS ---");
    // Mirem que l'usuari tingui llicències.
    var misLlicencies = Dades().usuariActiu!.llicencies;
    if (misLlicencies.isEmpty) {
      print("No tens jocs! Vés a la botiga.");
      return null;
    }

    //Validem les llicències i mostrem els jocs disponibles.
    stdout.write("Introdueix el CODI del joc per jugar: ");
    String codi = stdin.readLineSync() ?? "";

    try {
      // Validar que el joc existeix.
      var joc = Dades().catalegVideojocs.firstWhere((j) => j.codi == codi);

      //Validar que l'usuari té llicència per aquest joc.
      bool tieneLicencia = misLlicencies.any((l) => l.horesJocRestants != 0);

      if (tieneLicencia) {
        return joc; // Retronem el joc per jugar.
      } else {
        print("No tens llicència vàlida per aquest joc.");
        return null;
      }
    } catch (e) {
      print("Joc no trobat.");
      return null;
    }
  }

  void _ferAmic() {
    print("--- AFEGIR AMIC ---");
    stdout.write("Escriu l'email del teu amic: ");
    String emailAmic = stdin.readLineSync() ?? "";

    //Accedim a l'usuari actiu.
    var user = Dades().usuariActiu!;

    //Verifiquem que l'email existeix en la llista d'usuaris.
    if (!user.amics.contains(emailAmic)) {
      user.amics.add(emailAmic); //Afegim l'amic a la llista.
      print("$emailAmic afegit a la llista d'amics!");
    } else {
      print("Ja sou amics.");
    }
  }

  void _donarJoc() {
    print("--- DONAR JOC ---");
    var me = Dades().usuariActiu!;

    if (me.llicencies.isEmpty) {
      print("No tens llicències per donar.");
      return;
    }
    // Llistar llicències.
    for (int i = 0; i < me.llicencies.length; i++) {
      var l = me.llicencies[i];
      print(
        "[$i] ID: ${l.id} - Tipus: ${l.tipus.name} - Canvis restants: ${l.canvisPropietariRestants}",
      );
    }

    // Demanar index.
    stdout.write("Tria el número de la llicència a donar: ");
    int? index = int.tryParse(stdin.readLineSync() ?? "");

    if (index == null || index < 0 || index >= me.llicencies.length) {
      print("Selecció no vàlida.");
      return;
    }

    Llicencia llicencia = me.llicencies[index];

    // Demanar receptor.
    stdout.write("Escriu l'EMAIL de l'amic receptor: ");
    String emailAmic = stdin.readLineSync() ?? "";

    // Deleguem la lògica al model Dades.
    String? resultat = Dades().transferirLlicencia(me, emailAmic, llicencia);

    if (resultat == null) {
      print("ÈXIT! Has donat la llicència ${llicencia.id} a $emailAmic.");
    } else {
      print(resultat);
    }
  }
}
