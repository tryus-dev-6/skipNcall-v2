import 'dart:convert';

import 'package:skip_n_call/Model/PackageResponse.dart';

import 'ZipDetails.dart';
import 'TransactionList.dart';
import 'User.dart';

CommonResponse allDataFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String allDatumToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  bool? status;
  String? token;
  User? user;
  String? message;
  String? currentBalance;
  TransactionList? transactionList;
  Data? data;
  Package? packageResponse;

  CommonResponse(
      {this.status,
      this.token,
      this.user,
      this.message,
      this.currentBalance,
      this.transactionList,
      this.packageResponse,
      this.data});

  factory CommonResponse.fromJson(Map<String, dynamic>? json) => CommonResponse(
      status: json!["status"],
      user: json!["user"] == null ? null : User.fromJson(json!["user"]),
      token: json!["token"],
      message: json!["message"],
      currentBalance: json!['current_balance'],
      transactionList: json['transaction_list'] != null ? TransactionList.fromJson(json['transaction_list']) : null,
      packageResponse: json['package'] != null ? Package.fromJson(json['package']) : null,
      data: json['data'] != null ? Data.fromJson(json['data']) : null);

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "user": user?.toJson(),
        "message": message,
        "current_balance": currentBalance,
        "package": packageResponse!.toJson(),
        'transaction_list': transactionList!.toJson()
      };
}
