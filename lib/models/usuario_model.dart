

// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

UsuarioModel usuarioFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    String? nombre;
    String? email;
    bool? online;
    String? uid;

    UsuarioModel({
        this.nombre,
        this.email,
        this.online,
        this.uid,
    });


    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        nombre: json["nombre"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "email": email,
        "online": online,
        "uid": uid,
    };
}
