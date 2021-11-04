import 'dart:convert';
import 'package:chatapp/models/usuario_model.dart';

LoginResponde loginRespondeFromJson(String str) => LoginResponde.fromJson(json.decode(str));

String loginRespondeToJson(LoginResponde data) => json.encode(data.toJson());

class LoginResponde {
    bool? ok;
    UsuarioModel? usuario;
    String? token;

    LoginResponde({
        this.ok,
        this.usuario,
        this.token,
    });


    factory LoginResponde.fromJson(Map<String, dynamic> json) => LoginResponde(
        ok: json["ok"],
        usuario: UsuarioModel.fromJson(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario!.toJson(),
        "token": token,
    };
}

