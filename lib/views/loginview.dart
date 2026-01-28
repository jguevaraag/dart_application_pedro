import 'dart:io'; // Para leer del teclado
import '../data/dades.dart'; // Para acceder a la lista de usuarios
import '../models/usuari.dart'; // Para crear usuarios
import '../utils/validacions.dart'; // Para validar el email

class LoginView {
  void menuLogin() {
    bool sortir = false;
    while (!sortir) {
      print("\n--- BENVINGUT A CALAMOT GAMES ---");
      print("[I] Log In");
      print("[R] Registrar-se");
      print("[T] Tancar App");

      stdout.write("Tria una opció: ");
      String? opcio = stdin.readLineSync()?.toUpperCase();

      switch (opcio) {
        case 'I':
          _ferLogin(); // Llamamos al método privado
          break;
        case 'R':
          _ferRegistre();
          break;
        case 'T':
          print("Fins aviat!");
          exit(0); //Amb aixo tanquem l'aplicacio directament.
        default:
          print("Opció no vàlida.");
      }
      if (Dades().usuariActiu != null) {
        sortir = true;
      }
    }
  }

  void _ferLogin() {
    print("--- LOGIN ---");
    stdout.write("Email: ");
    // Fem servir la doble interrogació per assegurar que no és null.
    String email = stdin.readLineSync() ?? "";

    stdout.write("Password: ");
    String pass = stdin.readLineSync() ?? "";

    //Fem la cerca de l'usuari en la llista d'usuaris.
    try {
      // Utilitzem firstWhere per trobar l'usuari que coincideixi amb email i password.
      var user = Dades().llistaUsuaris.firstWhere(
        (u) => u.email == email && u.password == pass,
      );

      // Si el troba ho posem com usuari actiu
      Dades().usuariActiu = user;
      print("Benvingut, ${user.nick}!");
    } catch (e) {
      print("ERROR: Usuari o password incorrectes.");
    }
  }

  void _ferRegistre() {
    print("--- REGISTRE ---");
    stdout.write("Email: ");
    String email = stdin.readLineSync() ?? "";

    // Fem servir la extensió per validar l'email.
    if (!email.isValidEmail()) {
      print("ERROR: Format d'email incorrecte.");
      return; // Sortim del metode si l'email no es valid.
    }

    stdout.write("Nick: ");
    String nick = stdin.readLineSync() ?? "";
    stdout.write("Password: ");
    String pass = stdin.readLineSync() ?? "";

    // Creem el nou usuari i l'afegim a la llista.
    var nouUsuari = Jugador(email, nick, pass);
    Dades().llistaUsuaris.add(nouUsuari);
    print("Usuari registrat correctament! Ara fes Login.");
  }
}
