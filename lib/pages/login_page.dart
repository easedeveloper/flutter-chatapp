import 'package:chatapp/pages/loading_page.dart';
import 'package:chatapp/pages/usuarios_page.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

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
    final authService = Provider.of<Authservice>(context);

    final autenticado = await authService.isLoggIn();

    if ( autenticado! ) {
      //Conectar al Socket Service
      //Navigator.pushReplacementNamed(context, 'usuarios');

      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: ( _, __, ___, ) => UsuariosPage(),
        transitionDuration: Duration(milliseconds: 0)
      ));

    }else{
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: ( _, __, ___, ) => LoadingPage(),
        transitionDuration: Duration(milliseconds: 0)
      ));
      
    }

  }

}