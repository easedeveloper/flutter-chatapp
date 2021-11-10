import 'package:chatapp/global/enviroment.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatusSocket {
  Online,
  Offline,
  Connecting
}


class SocketService with ChangeNotifier {

  ServerStatusSocket _serverStatus = ServerStatusSocket.Connecting;
  late IO.Socket _socket;

  ServerStatusSocket get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;


  // SocketService(){
  //   this._initConfig();
  // }

  void connect() async {

    final token = await Authservice.getToken();
    //Espera a que tengas la verificacion del token y luego guardarlo
    
    // Dart client
    this._socket = IO.io(Enviroment.socketURL, {
      'transports'    : ['websocket'],
      'autoConnect'   : true,
      'forceNew'      : true,
      'extraHeaders'  : {
      'x-token': token
      } 
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatusSocket.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatusSocket.Offline;
      notifyListeners();
    });
  }

  void discconect(){
    this._socket.disconnect();
  }

}