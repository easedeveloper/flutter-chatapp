import 'package:chatapp/models/modes.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/services/usuarios_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  final usuariosService = new UsuariosService();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<UsuarioModel> usuariosList = [];
  
  // final usuariosList = [
  //   UsuarioModel(uid: '01', nombre: 'Andrei', email: 'andy@gmail.com',   online: true),
  //   UsuarioModel(uid: '02', nombre: 'Moncho', email: 'moncho@gmail.com', online: false),
  //   UsuarioModel(uid: '03', nombre: 'Yui',    email: 'yui@gmail.com',    online: true),
  // ];

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<Authservice>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuarioModel;

    return Scaffold(
      appBar: AppBar(
        title: Text( usuario.nombre! , style: TextStyle( color: Colors.black54 ),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.black54 ),
          onPressed: (){
            //Desconectarnos del Socket Server
            socketService.discconect();

            Navigator.pushReplacementNamed(context, 'loading');
            Authservice.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( right: 10 ),
            
            child: ( socketService.serverStatus == ServerStatusSocket.Online )
                 ? Icon( Icons.check_circle, color: Colors.green[400])
                 : Icon( Icons.check_circle, color: Colors.red[400])
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,

        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue,),
          waterDropColor: Colors.blue,
        ),
        child: _listviewUsuarios(),
      )
   );
  }

  ListView _listviewUsuarios() {
    return ListView.separated(

      //PARA QUE SE MIRE IGUAL TANTO EN IOS COMO EN ANDROID,
      physics: BouncingScrollPhysics(),

      itemBuilder: (BuildContext context, index) => _usuarioLisTile( usuariosList[index] ),
      separatorBuilder: (BuildContext context, index) => Divider(),
      itemCount: usuariosList.length
    );
  }

  //**** USUARIO LISTLE ò USUARIO TITTLE
  ListTile _usuarioLisTile( UsuarioModel usuModel ) {
    return ListTile(
        title: Text( usuModel.nombre! ),
        subtitle: Text( usuModel.email! ),
        leading: CircleAvatar(
          child: Text( usuModel.nombre!.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuModel.online!
                 ? Colors.green[300]
                 : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: (){
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.usuarioPara = usuModel;
          //Obteniendo de usuModel(nombre, email) en usuarioPara

          Navigator.pushNamed(context, 'chat');
          
          // print( usuModel.nombre );
          // print( usuModel.email );
        },
      );
  }

  _cargarUsuarios() async { 

    //Obteniendo el listado de usuarios de la BD en mi usuariosList
    this.usuariosList = await usuariosService.getUsuarios();
    setState(() {});

    //await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();

  }

}