class Contact{

  Contact({
    this.id,
    this.trackingId,
    this.leadId,
    this.contactType,
    this.contact,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? trackingId;
  String? leadId;
  String? contactType;
  String? contact;
  String? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  int? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"],
    trackingId: json["tracking_id"],
    leadId: json["lead_id"],
    contactType: json["contact_type"],
    contact: json["contact"],
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
    "lead_id": leadId,
    "contact_type": contactType,
    "contact": contact,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "is_deleted": isDeleted,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };

}