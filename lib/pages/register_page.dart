import 'package:flutter/material.dart';

import 'package:chatapp/widgets/widgets.dart';

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
            text: 'Ingrese',
            onPressed: (){
              print(emailCrtl.text);
              print(passCrtl.text);
            }
          )
        ],
      ),
    );
  }
}





