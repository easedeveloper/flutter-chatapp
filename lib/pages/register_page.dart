import 'package:chatapp/helpers/mostrar_alert_helpers.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

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
                Logo( titulo: 'Registro', ),
                  
                _Formulario(),
                  
                Labels( ruta: 'loading', titulo:'¿Ya tienes cuenta?' , subTitulo:'Ingresa Ahora',),
                  
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
  final nameCrtl = TextEditingController();
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
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCrtl,
          ),

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
            text: 'Crear Cuenta',
            onPressed: authService.authenticando ? null : () async {
              
              final registroOK = await authService.register(
                nameCrtl.text.trim(),
                emailCrtl.text.trim(), 
                passCrtl.text.trim(),
              );

              if ( registroOK == true ) {
                //Conectar al Socket server
                socketService.connect();

                Navigator.pushReplacementNamed(context, 'usuarios');
              }else{
                mostrarAlerta(context, 'Registro Incorrecto', 'Revice sus credenciales');
              }

              print(nameCrtl.text);
              print(emailCrtl.text);
              print(passCrtl.text);
            }
          )
        ],
      ),
    );
  }
}





