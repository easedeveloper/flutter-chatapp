









import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/helpers/mostrar_alert_helpers.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            //esto seria el total de la pantalla

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //Ayudara a exparsir todos los elemntos en la pantalla
              children: [
                Logo( titulo: 'Messenger', ),
                  
                _Formulario(),
                  
                Labels( ruta: 'Register', titulo:'¿No tienes cuenta?' , subTitulo: 'Crea una ahora!',),
                  
                Text('Terminos y Condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200 ),)
                
              ],
            ),
          ),
        ),
      )
   );
  }
}



class _Formulario extends StatefulWidget {
  @override
  __FormularioState createState() => __FormularioState();
}

class __FormularioState extends State<_Formulario> {

  final emailCrtl = TextEditingController();
  final passCrtl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<Authservice>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 50),
      child: Column(
        children: [

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo Electronico',
            keyboardType: TextInputType.emailAddress,
            textController: emailCrtl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCrtl,
            isPassword: true,
          ),
          
          BotonAzul(
            text: 'Ingrese',
            onPressed: authService.authenticando ? null : () async{
              FocusScope.of(context).unfocus();
              //nos servira para poder ocultar el teclado una vez que ya se autentico

              final loginOK = await authService.login(emailCrtl.text.trim(), passCrtl.text.trim());

              if ( loginOK! ) {
                //Connectar a nuestro socket server
                socketService.connect();
                
                //Navegar a otra Pantalla
                Navigator.pushReplacementNamed(context, 'usuarios');
                  //usando pushReplacementNamed, lo hago para que no puedan regresar a mi LOGIN

              }else{
                //Mostrar la Alerta
                mostrarAlerta(
                  context,
                  'Login Incorrecto',
                  'Revise sus crendenciales'
                );
              }

              // //trim() para que se haya espacios en blanco
              // print(emailCrtl.text);
              // print(passCrtl.text);
            }
          )
        ],
      ),
    );
  }
}





