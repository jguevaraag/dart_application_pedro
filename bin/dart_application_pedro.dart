import 'package:dart_application_pedro/views/menus.dart';
//import 'package:dart_application_pedro/models/Videojoc.dart';

void main(List<String> arguments) {
  // Instanciamos la vista
  final menu = MenuPrincipal();

  // Bucle infinito hasta que el usuario decida salir [22]
  while (true) {
    menu.mostrarMenu();
  }
}
