import 'package:dart_application_pedro/data/dades.dart'; // Tu "Base de Datos"
import 'package:dart_application_pedro/views/loginview.dart';
import 'package:dart_application_pedro/views/usuari_view.dart';
import 'package:dart_application_pedro/views/partida_view.dart';
import 'package:dart_application_pedro/models/videojoc.dart'; // Para el tipo Videojoc

void main(List<String> arguments) {
  Dades().carregarDadesInicials();
  // Instancem les vistes de Login i Usuari.
  final menu = LoginView();
  final menuUsuari = UsuariView();

  // Bucle principal de l'aplicació.
  while (true) {
    menu.menuLogin();
    bool sessioActiva = true;
    while (sessioActiva) {
      // Truquem al menú d'usuari.
      Videojoc? jocSeleccionat = menuUsuari.menuUsuari();

      if (jocSeleccionat != null) {
        // Si retorna un joc, entrem a la vista de partida.
        final partidaView = PartidaView(jocSeleccionat);
        partidaView.menuPartida();

        // Quan sortim de la partida, tornem al menú d'usuari.
      } else {
        // Si retorna null, l'usuari ha fet logout.
        sessioActiva = false;
        print("Tancant sessió...\n");
      }
    }
  }
}
