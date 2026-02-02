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

    // Validem que tingui llicències per donar.
    if (me.llicencies.isEmpty) {
      print("Error: No tens cap llicència per donar.");
      return;
    }

    // Mostrem les llicències disponibles.
    print("Les teves llicències:");
    for (int i = 0; i < me.llicencies.length; i++) {
      //Accedim a la llicència i la mostrem.
      var llicencia = me.llicencies[i];
      print(
        "[$i] ID: ${llicencia.id} - Tipus: ${llicencia.tipus.name} - Canvis restants: ${llicencia.canvisPropietariRestants}",
      );
    }

    // Pedim quina llicència donar.
    stdout.write("Tria el NÚMERO de la llicència a donar: ");
    // Transformem l'entrada a int.
    int? index = int.tryParse(stdin.readLineSync() ?? "");

    if (index == null || index < 0 || index >= me.llicencies.length) {
      print("Error: Selecció no vàlida.");
      return;
    }

    var llicenciaADonar = me.llicencies[index];

    //Validem que la llicència es pugui transferir.
    if (llicenciaADonar.canvisPropietariRestants <= 0) {
      print("Error: Aquesta llicència ja no es pot transferir més cops.");
      return;
    }

    // Demanem l'email de l'amic receptor.
    stdout.write("Escriu l'EMAIL de l'amic receptor: ");
    String emailAmic = stdin.readLineSync() ?? "";

    // Mirem si aquest usuari existex en la llista d'amics.
    if (!me.amics.contains(emailAmic)) {
      print(
        "Error: Aquest usuari no està a la teva llista d'amics. Afegeix-lo primer!",
      );
      return;
    }

    // Mirem la llista d'usuaris per trobar l'amic receptor.
    try {
      // Llancem excepcio si no troba l'usuari.
      var usuariReceptor = Dades().llistaUsuaris.firstWhere(
        (u) => u.email == emailAmic,
      );

      //Restem un intent de transferencia i fem el canvi.
      if (llicenciaADonar.intentarTransferencia()) {
        // Eliminem la llicència de l'usuari actual.
        me.llicencies.removeAt(index);

        // La fiquem a l'usuari receptor.
        usuariReceptor.llicencies.add(llicenciaADonar);

        print(
          "ÈXIT! Has donat la llicència ${llicenciaADonar.id} a $emailAmic.",
        );
      }
    } catch (e) {
      print(
        "Error: L'usuari $emailAmic no existeix a la base de dades (ningú s'ha registrat amb aquest mail).",
      );
    }
  }
}
