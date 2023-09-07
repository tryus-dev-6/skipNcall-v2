
import 'dart:convert';

import 'User.dart';

CommonResponse allDataFromJson(String str) => CommonResponse.fromJson(json.decode(str));
String allDatumToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  bool? status;
  String? token;
  User? user;
  String? message;

  CommonResponse({this.status, this.token, this.user, this.message});

  factory CommonResponse.fromJson(Map<String, dynamic>? json) => CommonResponse(

    status: json!["status"],
    user: json!["user"] == null ? null : User.fromJson(json!["user"]),
    token: json!["token"],
    message: json!["message"],

  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "user": user?.toJson(),
    "message": message
  };

}
