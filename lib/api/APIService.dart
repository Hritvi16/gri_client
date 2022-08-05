import 'dart:convert';
import 'package:gri_client/api/Environment.dart';
import 'package:gri_client/models/LoginResponse.dart';
import 'package:http/http.dart' as http;
import 'APIConstant.dart';

class APIService {
  // getHeader() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Map<String, String> headers = {
  //     APIConstant.authorization : APIConstant.token+(sharedPreferences.getString("token")??"")+"."+base64Encode(utf8.encode(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()))),
  //     "Accept": "application/json",
  //   };
  //   return headers;
  // }

  // getToken() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String token = sharedPreferences.getString("token")??"";
  //   return token;
  // }
  Future<LoginResponse> login(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageCustomer);
    print(url);
    var result = await http.post(url, body: data);
    print(result.body);
    LoginResponse loginResponse = LoginResponse.fromJson(json.decode(result.body));
    return loginResponse;
  }
}
