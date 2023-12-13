class Questonaire{

  Questonaire({
    this.id,
    this.questionaireId,
    this.leadId,
    this.question,
    this.answer,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? questionaireId;
  String? leadId;
  String? question;
  String? answer;
  String? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  int? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Questonaire.fromJson(Map<String, dynamic> json) => Questonaire(
    id: json["id"],
    questionaireId: json["questionaire_id"],
    leadId: json["lead_id"],
    question: json["question"],
    answer: json["answer"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    isDeleted: json["is_deleted"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionaire_id": questionaireId,
    "lead_id": leadId,
    "question": question,
    "answer": answer,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "is_deleted": isDeleted,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };

}