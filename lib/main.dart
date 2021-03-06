import 'package:chatapp/routes/mainroutes.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Authservice(),
        /*CREANDO UNA INSTANCIA GLOBAL DE MI AUTHSERVICE. COMO EL 
          MultiProvider ESTA ARRIBA DEL MATERIALAPP TODAS LA RUTAS VAN A TENER EN SU
          CONTEXT EL AUTHSERVICE
        */
        ),

        ChangeNotifierProvider( create: (_) => SocketService() ),

        ChangeNotifierProvider( create: (_) => ChatService() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}