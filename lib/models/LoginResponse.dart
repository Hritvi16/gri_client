import 'AccountResponse.dart';

class LoginResponse {
  LoginResponse({
      String? message, 
      String? status, 
      Account? account,});

  LoginResponse.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
    account = json['account'] != null ? Account.fromJson(json['account']) : null;
  }
  String? message;
  String? status;
  Account? account;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    if (account != null) {
      map['account'] = account?.toJson();
    }
    return map;
  }

}
