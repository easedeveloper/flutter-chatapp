import 'package:chatapp/models/modes.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);


  final usuariosList = [
    UsuarioModel(uid: '01', nombre: 'Andrei', email: 'andy@gmail.com',   online: true),
    UsuarioModel(uid: '02', nombre: 'Moncho', email: 'moncho@gmail.com', online: false),
    UsuarioModel(uid: '03', nombre: 'Yui',    email: 'yui@gmail.com',    online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MI NOMBRE', style: TextStyle( color: Colors.black54 ),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.black54 ),
          onPressed: (){},
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( right: 10 ),
            //child: Icon( Icons.check_circle, color: Colors.red[400],),
            child: Icon( Icons.check_circle, color: Colors.green[400],),
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

  //**** USUARIO LISTLE 
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
      );
  }

  _cargarUsuarios() async { 

    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();

  }

}