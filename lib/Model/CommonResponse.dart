import 'dart:convert';

import 'package:skip_n_call/Model/PackageResponse.dart';
import 'package:skip_n_call/Model/PurchasedZipList.dart';

import 'CartList.dart';
import 'Leads.dart';
import 'Notification.dart';
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
  String? clientPackageId;
  String? purchasedPackage;
  TransactionList? transactionList;
  Data? data;
  Package? packageResponse;
  CartList? cartList;
  ZipList? zipList;
  int? cartCount;
  int? totalCartPrice;
  Notifications? notifications;
  int? rawLeadsCount;
  int? warmLeadsCount;
  int? hovlLeadsCount;
  int? rawLeadsCost;
  int? warmLeadsCost;
  int? hovlLeadsCost;
  int? totalLeadCount;
  Leads? leads;

  CommonResponse(
      {this.status,
      this.token,
      this.user,
      this.message,
      this.currentBalance,
      this.transactionList,
      this.packageResponse,
      this.clientPackageId,
      this.purchasedPackage,
      this.cartList,
      this.cartCount,
      this.totalCartPrice,
      this.zipList,
      this.notifications,
      this.rawLeadsCount,
      this.warmLeadsCount,
      this.hovlLeadsCount,
      this.totalLeadCount,
      this.rawLeadsCost,
      this.hovlLeadsCost,
      this.warmLeadsCost,
      this.leads,
      this.data});

  factory CommonResponse.fromJson(Map<String, dynamic>? json) => CommonResponse(
      status: json!["status"],
      user: json!["user"] == null ? null : User.fromJson(json!["user"]),
      token: json!["token"],
      message: json!["message"],
      clientPackageId: json!["client_package_id"],
      purchasedPackage: json!["selectd_package"],
      currentBalance: json!['current_balance'],
      totalCartPrice: json!['total_price'],
      transactionList: json['transaction_list'] != null
          ? TransactionList.fromJson(json['transaction_list'])
          : null,
      packageResponse:
          json['package'] != null ? Package.fromJson(json['package']) : null,
      cartList: json['cart_list'] != null
          ? CartList.fromJson(json["cart_list"])
          : null,
      zipList: json['list'] != null ? ZipList.fromJson(json["list"]) : null,
      cartCount: json["cart_count"],
      rawLeadsCount: json["raw_leads_count"],
      warmLeadsCount: json["warm_leads_count"],
      hovlLeadsCount: json["hovl_leads_count"],
      rawLeadsCost: json['raw_leads_cost'],
      hovlLeadsCost: json['hovl_leads_cost'],
      warmLeadsCost: json['warm_leads_cost'],
      totalLeadCount: json["total_lead_count"],
      notifications: json['notifications'] != null
          ? Notifications.fromJson(json["notifications"])
          : null,
      leads: json['leads'] != null ? Leads.fromJson(json["leads"]) : null,
      data: json['data'] != null ? Data.fromJson(json['data']) : null);

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "user": user?.toJson(),
        "message": message,
        "total_price": totalCartPrice,
        "current_balance": currentBalance,
        "client_package_id": clientPackageId,
        "selectd_package": purchasedPackage,
        "package": packageResponse!.toJson(),
        "cart_list": cartList?.toJson(),
        "list": zipList?.toJson(),
        "cart_count": cartCount,
        'transaction_list': transactionList!.toJson(),
        "notifications": notifications!.toJson(),
        "raw_leads_count": rawLeadsCount,
        "warm_leads_count": warmLeadsCount,
        "hovl_leads_count": hovlLeadsCount,
        "total_lead_count": totalLeadCount,
        "warm_leads_cost": warmLeadsCost,
        "hovl_leads_cost": hovlLeadsCost,
        "raw_leads_cost": rawLeadsCost,
        "leads": leads?.toJson(),
      };
}
