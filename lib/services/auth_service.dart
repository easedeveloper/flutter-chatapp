
import 'dart:convert';
import 'package:chatapp/models/usuario_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chatapp/global/enviroment.dart';
import 'package:chatapp/models/login_response_model.dart';


class Authservice with ChangeNotifier{

  late UsuarioModel usuarioModel;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  //***GETTER
  bool get authenticando => this._autenticando;
  //***SETTER
  set authenticando(bool valor){
    this._autenticando = valor;
    notifyListeners();
  }

  //***GETTER Y SETTER DEL TOKEN DE MANERA ESTATICA
  static Future<String> getToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  //***GETTER Y SETTER DEL TOKEN DE MANERA ESTATICA
  static Future<void> deleteToken() async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }


 //************* LOGIN
 Future<bool?> login (String email, String password) async {

   this.authenticando = true;

   final data ={
     'email': email,
     'password': password,
   };

   final uriParse = Uri.parse('${Enviroment.apiURL}/login');
   final resp = await http.post(
    uriParse, 
    body: jsonEncode(data),
    headers:{ 'Content-Type':'application/json' },
   );

   //print(resp.body);
   this.authenticando = false;
   //una vez que ya se autentico, las personas pueden hacer otras interacciones

   if ( resp.statusCode == 200 ) {
     final loginResponde = loginRespondeFromJson( resp.body );
     this.usuarioModel = loginResponde.usuario!;

      //Guardar Token en lugar seguro
      await this._guardartoken(loginResponde.token!);

     return true;
   }else{
     return false;
   }
 }

  //********** REGISTRANDO
  Future register (String name, String email, String password) async {
    this.authenticando = true;

   final data ={
     'nombre': name,
     'email': email,
     'password': password,
   };

   final uriParse = Uri.parse('${Enviroment.apiURL}/login/new');
   final resp = await http.post(
    uriParse, 
    body: jsonEncode(data),
    headers:{ 'Content-Type':'application/json' },
   );

   //print(resp.body);
   this.authenticando = false;
   //una vez que ya se autentico, las personas pueden hacer otras interacciones

   if ( resp.statusCode == 200 ) {
     final loginResponde = loginRespondeFromJson( resp.body );
     this.usuarioModel = loginResponde.usuario!;

      //Guardar Token en lugar seguro
      await this._guardartoken(loginResponde.token!);

     return true;
   }else{
     final respBody = jsonDecode( resp.body );
     //Mapear de un JSON STRING A UN MAPA

     return respBody['msg'];
   }
  }

 Future<bool?> isLoggIn() async {
   final token = await this._storage.read(key:'token');

   final uriParse = Uri.parse('${Enviroment.apiURL}/login/renew');
   final resp = await http.get(
    uriParse,
    headers:{ 
      'Content-Type':'application/json',
      'x-token': token.toString()
    },
   );
    
   //print(resp.body);

   if ( resp.statusCode == 200 ) {
     final loginResponde = loginRespondeFromJson( resp.body );
     this.usuarioModel = loginResponde.usuario!;

      //Guardar Token en lugar seguro
      await this._guardartoken(loginResponde.token!);

     return true;
   }else{
     this._logout();
     return false;
   }

  //  print(token);
 } 

 Future _guardartoken( String token ) async{

   return await _storage.write(key: 'token', value: token);
 }

 Future _logout() async {
   await _storage.delete(key: 'token');
 }

}