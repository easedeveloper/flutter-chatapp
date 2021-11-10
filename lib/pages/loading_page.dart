import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/usuarios_page.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
         return Center(
              child: Text('Espere...'),
            );
        },
      ),
   );
  }

  Future checkLoginState( BuildContext context ) async {
    final authService = Provider.of<Authservice>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggIn();

    if ( autenticado! ) {
      //Conectar al Socket Service
      socketService.connect();

      //Navigator.pushReplacementNamed(context, 'usuarios');

      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: ( _, __, ___, ) => UsuariosPage(), //usuariospage
        transitionDuration: Duration(milliseconds: 0)
      ));

    }else{
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: ( _, __, ___, ) => LoginPage(),
        transitionDuration: Duration(milliseconds: 0)
      ));
      
    }

  }

}