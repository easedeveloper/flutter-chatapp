// To parse this JSON data, do
//
//     final usuariosListResponse = usuariosListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chatapp/models/usuario_model.dart';

UsuariosListResponse usuariosListResponseFromJson(String str) => UsuariosListResponse.fromJson(json.decode(str));

String usuariosListResponseToJson(UsuariosListResponse data) => json.encode(data.toJson());

class UsuariosListResponse {
    bool? ok;
    List<UsuarioModel>? usuarios;

    UsuariosListResponse({
        this.ok,
        this.usuarios,
    });


    factory UsuariosListResponse.fromJson(Map<String, dynamic> json) => UsuariosListResponse(
        ok: json["ok"],
        usuarios: List<UsuarioModel>.from(json["usuarios"].map((x) => UsuarioModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios!.map((x) => x.toJson())),
    };
}



