

class Data{

  Data({
    this.id,
    this.packageId,
    this.packageName,
    this.packagePrice,
    this.minZip,
    this.maxZip,
    this.hovLeadPrice,
    this.warmLeadPrice,
    this.rawLeadPrice,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? packageId;
  String? packageName;
  String? packagePrice;
  int? minZip;
  int? maxZip;
  int? hovLeadPrice;
  int? warmLeadPrice;
  int? rawLeadPrice;
  String? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  int? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    packageId: json["package_id"],
    packageName: json["package_name"],
    packagePrice: json["package_price"],
    minZip: json["min_zip"],
    maxZip: json["max_zip"],
    hovLeadPrice: json["hov_lead_price"],
    warmLeadPrice: json["warm_lead_price"],
    rawLeadPrice: json["raw_lead_price"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    isDeleted: json["is_deleted"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "package_id": packageId,
    "package_name": packageName,
    "package_price": packagePrice,
    "min_zip": minZip,
    "max_zip": maxZip,
    "hov_lead_price": hovLeadPrice,
    "warm_lead_price": warmLeadPrice,
    "raw_lead_price": rawLeadPrice,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "is_deleted": isDeleted,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

}