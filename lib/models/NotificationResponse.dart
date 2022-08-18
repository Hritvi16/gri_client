/// notification : [{"id":"3","title":"test","message":"testing","image":"1660308801.jpeg","noti_date":"2022-08-12","created_at":"2022-08-12 05:53:21"},{"id":"2","title":"test","message":"test","image":"1660308512.jpeg","noti_date":"2022-08-12","created_at":"2022-08-12 05:48:32"},{"id":"1","title":"testing","message":"testing from snehal batra","image":"1660308363.jpeg","noti_date":"2022-08-12","created_at":"2022-08-12 05:46:03"}]

class NotificationResponse {
  NotificationResponse({
      List<Notification>? notification,});

  NotificationResponse.fromJson(dynamic json) {
    if (json['notification'] != null) {
      notification = [];
      json['notification'].forEach((v) {
        notification?.add(Notification.fromJson(v));
      });
    }
  }
  List<Notification>? notification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (notification != null) {
      map['notification'] = notification?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3"
/// title : "test"
/// message : "testing"
/// image : "1660308801.jpeg"
/// noti_date : "2022-08-12"
/// created_at : "2022-08-12 05:53:21"

class Notification {
  Notification({
      String? id, 
      String? title, 
      String? message, 
      String? image, 
      String? notiDate, 
      String? createdAt,});

  Notification.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    image = json['image'];
    notiDate = json['noti_date'];
    createdAt = json['created_at'];
  }
  String? id;
  String? title;
  String? message;
  String? image;
  String? notiDate;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['message'] = message;
    map['image'] = image;
    map['noti_date'] = notiDate;
    map['created_at'] = createdAt;
    return map;
  }

}