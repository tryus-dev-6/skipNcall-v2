class User {
  int? id;
  String? userId;
  dynamic roleId;
  String? firstName;
  String? lastName;
  String? userType;
  dynamic proPic;
  String? email;
  String? phone;
  dynamic note;
  dynamic bio;
  int? isConnected;
  dynamic notificationToken;
  String? pass;
  String? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  int? isVerified;
  int? isActive;
  int? isDeactive;
  dynamic deactivationCause;
  int? isDeleted;
  int? isAdmin;
  int? isLoggedin;
  dynamic emailVerifiedAt;
  String? clientBalance;
  int? totalZip;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.userId,
    this.roleId,
    this.firstName,
    this.lastName,
    this.userType,
    this.proPic,
    this.email,
    this.phone,
    this.note,
    this.bio,
    this.totalZip,
    this.isConnected,
    this.notificationToken,
    this.pass,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.isVerified,
    this.isActive,
    this.isDeactive,
    this.deactivationCause,
    this.isDeleted,
    this.isAdmin,
    this.isLoggedin,
    this.emailVerifiedAt,
    this.createdAt,
    this.clientBalance,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userId: json["user_id"],
        roleId: json["role_id"],
        totalZip: json["client_zip"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userType: json["user_type"],
        proPic: json["pro_pic"],
        email: json["email"],
        phone: json["phone"],
        note: json["note"],
        bio: json["bio"],
        isConnected: json["is_connected"],
        notificationToken: json["notification_token"],
        pass: json["pass"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        isVerified: json["is_verified"],
        isActive: json["is_active"],
        isDeactive: json["is_deactive"],
        deactivationCause: json["deactivation_cause"],
        isDeleted: json["is_deleted"],
        isAdmin: json["is_admin"],
        clientBalance: json!["balance"],
        isLoggedin: json["is_loggedin"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "role_id": roleId,
        "first_name": firstName,
        "last_name": lastName,
        "user_type": userType,
        "pro_pic": proPic,
        "email": email,
        "phone": phone,
        "note": note,
        "bio": bio,
        "client_zip": totalZip,
        "is_connected": isConnected,
        "notification_token": notificationToken,
        "pass": pass,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "is_verified": isVerified,
        "is_active": isActive,
        "is_deactive": isDeactive,
        "deactivation_cause": deactivationCause,
        "is_deleted": isDeleted,
        "is_admin": isAdmin,
        "is_loggedin": isLoggedin,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "balance": clientBalance,
      };
}
