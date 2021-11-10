import 'package:chatapp/global/enviroment.dart';
import 'package:chatapp/models/usuarios_responde.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:http/http.dart' as http;

import 'package:chatapp/models/usuario_model.dart';


class UsuariosService{

  Future<List<UsuarioModel>> getUsuarios() async {

    String? token = await Authservice.getToken();

    try {
      final uriParse = Uri.parse('${ Enviroment.apiURL }/usuarios');
      
      final resp = await http.get(
        uriParse,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token.toString(),
        }
      );

      //Mapear la respuesta
      final usuariosListResponse = usuariosListResponseFromJson( resp.body );

      return usuariosListResponse.usuarios!;

    } catch (e) {
      return [];
    }

  }

}