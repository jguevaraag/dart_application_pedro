import 'dart:io';
import 'package:dart_application_pedro/data/dades.dart'; // Tu "Base de Datos"
import 'package:dart_application_pedro/views/loginview.dart';
import 'package:dart_application_pedro/models/videojoc.dart'; // Para el tipo Videojoc
//import 'package:dart_application_pedro/models/Videojoc.dart';

void main(List<String> arguments) {
  Dades().carregarDadesInicials();
  // Instanciamos la vista
  final menu = LoginView();

  // Bucle infinito hasta que el usuario decida salir [22]
  while (true) {
    menu.menuLogin();
  }
}
