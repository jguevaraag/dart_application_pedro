import 'dart:io';

class MenuPrincipal {
  
  void mostrarMenu() {
    print("--- MENU ---");
    print("[I] Log In");
    print("[R] Registrar-se");
    print("[T] Tancar");
    
    // Leemos la línea (función estándar de dart:io)
    String? opcio = stdin.readLineSync();

    // Switch para control de flujo [20]
    switch (opcio?.toUpperCase()) {
      case 'I':
        _login();
        break; // En Dart el break en switch no vacío es opcional o automático según versión, pero buena práctica
      case 'R':
        _registro();
        break;
      case 'T':
        print("Adéu!");
        exit(0);
      default:
        print("Opció no vàlida");
    }
  }

  void _login() {
    print("Usuari:");
    String? user = stdin.readLineSync();
    // Aquí conectarías con tu lógica de Modelo
  }
  
  void _registro() {
    // Implementar registro
  }
}