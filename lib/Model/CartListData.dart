class Datum {
  Datum({
    this.id,
    this.trackingId,
    this.paymentId,
    this.packageId,
    this.clientId,
    this.city,
    this.country,
    this.placeName,
    this.state,
    this.zipCode,
    this.isPurchased,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? trackingId;
  dynamic paymentId;
  String? packageId;
  String? clientId;
  String? city;
  String? country;
  String? placeName;
  String? state;
  int? zipCode;
  int? isPurchased;
  String? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  int? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    trackingId: json["tracking_id"],
    paymentId: json["payment_id"],
    packageId: json["package_id"],
    clientId: json["client_id"],
    city: json["city"],
    country: json["country"],
    placeName: json["place_name"],
    state: json["state"],
    zipCode: json["zip_code"],
    isPurchased: json["is_purchased"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    isDeleted: json["is_deleted"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tracking_id": trackingId,
    "payment_id": paymentId,
    "package_id": packageId,
    "client_id": clientId,
    "city": city,
    "country": country,
    "place_name": placeName,
    "state": state,
    "zip_code": zipCode,
    "is_purchased": isPurchased,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "is_deleted": isDeleted,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}