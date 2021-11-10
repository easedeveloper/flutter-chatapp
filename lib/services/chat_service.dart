
import 'package:chatapp/global/enviroment.dart';
import 'package:chatapp/models/mensjaes_response.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chatapp/models/usuario_model.dart';


class ChatService with ChangeNotifier{

  late UsuarioModel usuarioPara;


  Future<List<Mensaje>> getChat(String usuarioID) async { 

    final uriParse = Uri.parse('${Enviroment.apiURL}/mensajes/$usuarioID');
    final resp = await http.get( 
                  uriParse,
                  headers:{
                    'Content-Type': 'application/json',
                    'x-token': await Authservice.getToken()
                  },
    );
    print( 'RESBODY: $resp.body' );
    //Mapeamos la Respuesta
    final msjResponse= mensajesResponseFromJson( resp.body );
    print( msjResponse.mensajes );
    return msjResponse.mensajes!;
  }

}



