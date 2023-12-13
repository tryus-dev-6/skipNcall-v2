
class Data {
  int? id;
  String? transactionId;
  String? transactionType;
  String? clientId;
  dynamic packageId;
  String? paymentId;
  String? paidAmount;
  dynamic leadbatch;
  String? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.transactionId,
    this.transactionType,
    this.clientId,
    this.packageId,
    this.paymentId,
    this.paidAmount,
    this.leadbatch,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    transactionId: json["transaction_id"],
    transactionType: json["transaction_type"],
    clientId: json["client_id"],
    packageId: json["package_id"],
    paymentId: json["payment_id"],
    paidAmount: json["paid_amount"],
    leadbatch: json["leadbatch"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    isDeleted: json["is_deleted"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "transaction_type": transactionType,
    "client_id": clientId,
    "package_id": packageId,
    "payment_id": paymentId,
    "paid_amount": paidAmount,
    "leadbatch": leadbatch,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "is_deleted": isDeleted,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}