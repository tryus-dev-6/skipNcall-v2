import 'Contact.dart';
import 'Questonaire.dart';

class LeadList {
  LeadList({
    this.id,
    this.leadId,
    this.paymentId,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.phoneNumber,
    this.zipCode,
    this.propertyAddress,
    this.mailingAddress,
    this.ownerVerified,
    this.warmLead,
    this.isPurchased,
    this.isApproved,
    this.purchasedBy,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.questonaire,
    this.contactPhone,
    this.contactEmail,
    this.question,
    this.answer,
  });

  int? id;
  String? leadId;
  dynamic paymentId;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? phoneNumber;
  String? zipCode;
  String? propertyAddress;
  String? mailingAddress;
  int? ownerVerified;
  int? warmLead;
  int? isPurchased;
  int? isApproved;
  dynamic purchasedBy;
  String? createdBy;
  String? updatedBy;
  dynamic deletedBy;
  int? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Questonaire>? questonaire;
  List<Contact>? contactPhone;
  List<Contact>? contactEmail;
  String? question;
  String? answer;

  factory LeadList.fromJson(Map<String, dynamic> json) => LeadList(
    id: json["id"],
    leadId: json["lead_id"],
    paymentId: json["payment_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    emailAddress: json["email_address"],
    phoneNumber: json["phone_number"],
    zipCode: json["zip_code"],
    propertyAddress: json["property_address"],
    mailingAddress: json["mailing_address"],
    ownerVerified: json["owner_verified"],
    warmLead: json["warm_lead"],
    isPurchased: json["is_purchased"],
    isApproved: json["is_approved"],
    purchasedBy: json["purchased_by"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    isDeleted: json["is_deleted"],
    question: json["question"],
    answer: json["answer"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    questonaire: List<Questonaire>.from(json["questonaire"].map((x) => Questonaire.fromJson(x))),
    contactPhone: List<Contact>.from(json["contact_phone"].map((x) => Contact.fromJson(x))),
    contactEmail: List<Contact>.from(json["contact_email"].map((x) => Contact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "payment_id": paymentId,
    "first_name": firstName,
    "last_name": lastName,
    "email_address": emailAddress,
    "phone_number": phoneNumber,
    "zip_code": zipCode,
    "property_address": propertyAddress,
    "mailing_address": mailingAddress,
    "owner_verified": ownerVerified,
    "warm_lead": warmLead,
    "is_purchased": isPurchased,
    "is_approved": isApproved,
    "purchased_by": purchasedBy,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "is_deleted": isDeleted,
    "question": question,
    "answer": answer,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "questonaire": List<dynamic>.from(questonaire!.map((x) => x.toJson())),
    "contact_phone": List<dynamic>.from(contactPhone!.map((x) => x.toJson())),
    "contact_email": List<dynamic>.from(contactEmail!.map((x) => x.toJson())),
  };
}