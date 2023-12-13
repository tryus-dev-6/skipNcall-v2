
class NotificationData{

  NotificationData({
    this.id,
    this.notificationId,
    this.type,
    this.referenceId,
    this.notificableUser,
    this.referredUser,
    this.data,
    this.routePanel,
    this.routePath,
    this.perameters,
    this.icon,
    this.isSeen,
    this.isNotified,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? notificationId;
  String? type;
  String? referenceId;
  String? notificableUser;
  String? referredUser;
  String? data;
  dynamic routePanel;
  String? routePath;
  dynamic perameters;
  dynamic icon;
  int? isSeen;
  int? isNotified;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["id"],
    notificationId: json["notification_id"],
    type: json["type"],
    referenceId: json["reference_id"],
    notificableUser: json["notificable_user"],
    referredUser: json["referred_user"],
    data: json["data"],
    routePanel: json["route_panel"],
    routePath: json["route_path"],
    perameters: json["perameters"],
    icon: json["icon"],
    isSeen: json["is_seen"],
    isNotified: json["is_notified"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notification_id": notificationId,
    "type": type,
    "reference_id": referenceId,
    "notificable_user": notificableUser,
    "referred_user": referredUser,
    "data": data,
    "route_panel": routePanel,
    "route_path": routePath,
    "perameters": perameters,
    "icon": icon,
    "is_seen": isSeen,
    "is_notified": isNotified,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

}