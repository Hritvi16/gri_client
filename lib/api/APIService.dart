import 'dart:convert';
import 'package:gri_client/api/Environment.dart';
import 'package:gri_client/models/AccountResponse.dart';
import 'package:gri_client/models/CalendarRenewalResponse.dart';
import 'package:gri_client/models/HealthClaimResponse.dart';
import 'package:gri_client/models/ContactUsResponse.dart';
import 'package:gri_client/models/DashboardResponse.dart';
import 'package:gri_client/models/LoginResponse.dart';
import 'package:gri_client/models/NotificationResponse.dart';
import 'package:gri_client/models/PolicyResponse.dart';
import 'package:gri_client/models/RelationResponse.dart';
import 'package:gri_client/models/RenewalResponse.dart';
import 'package:gri_client/models/Response.dart';
import 'package:gri_client/models/TollFreeResponse.dart';
import 'package:http/http.dart' as http;
import '../models/MotorClaimResponse.dart';
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


  Future<Response> insertUserFCM(Map<String, dynamic> data) async {
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.insertUserFCM);
    var result = await http.post(url, body: data);

    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }


  Future<LoginResponse> login(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageCustomer);
    var result = await http.post(url, body: data);
    LoginResponse loginResponse = LoginResponse.fromJson(json.decode(result.body));
    return loginResponse;
  }

  Future<DashboardResponse> getDashboard(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.managePolicies, queryParameters);
    var result = await http.get(url);
    DashboardResponse dashboardResponse = DashboardResponse.fromJson(json.decode(result.body));
    return dashboardResponse;
  }

  Future<RenewalResponse> getRenewals(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.managePolicies, queryParameters);
    var result = await http.get(url);
    RenewalResponse renewalResponse = RenewalResponse.fromJson(json.decode(result.body));
    return renewalResponse;
  }

  Future<CalendarRenewalResponse> getCalendarRenewals(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.managePolicies, queryParameters);
    print(url);
    var result = await http.get(url);
    print(result.body);
    CalendarRenewalResponse calendarRenewalResponse = CalendarRenewalResponse.fromJson(json.decode(result.body));
    return calendarRenewalResponse;
  }

  Future<PolicyResponse> getPolicies(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.managePolicies, queryParameters);
    var result = await http.get(url);
    PolicyResponse policyResponse = PolicyResponse.fromJson(json.decode(result.body));
    return policyResponse;
  }

  Future<PolicyDetailResponse> getPolicyDetails(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.managePolicies, queryParameters);
    var result = await http.get(url);
    PolicyDetailResponse policyDetailResponse = PolicyDetailResponse.fromJson(json.decode(result.body));
    return policyDetailResponse;
  }

  Future<ContactUsResponse> getContactUs() async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.getContactUs);
    var result = await http.get(url);
    ContactUsResponse contactUsResponse = ContactUsResponse.fromJson(json.decode(result.body));
    return contactUsResponse;
  }

  Future<TollFreeResponse> getTollFree() async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.getTollFree);
    var result = await http.get(url);
    TollFreeResponse tollFreeResponse = TollFreeResponse.fromJson(json.decode(result.body));
    return tollFreeResponse;
  }

  Future<NotificationResponse> getNotifications() async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.getNotifications);
    var result = await http.get(url);
    NotificationResponse notificationResponse = NotificationResponse.fromJson(json.decode(result.body));
    return notificationResponse;
  }

  Future<RelationResponse> getRelations() async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.getRelations);
    var result = await http.get(url);
    RelationResponse relationResponse = RelationResponse.fromJson(json.decode(result.body));
    return relationResponse;
  }

  Future<AccountListResponse> getAccounts(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCustomer, queryParameters);
    var result = await http.get(url);
    print(result.body);
    AccountListResponse accountListResponse = AccountListResponse.fromJson(json.decode(result.body));
    return accountListResponse;
  }

  Future<AccountResponse> getProfile(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCustomer, queryParameters);
    var result = await http.get(url);
    print(result.body);
    AccountResponse accountResponse = AccountResponse.fromJson(json.decode(result.body));
    return accountResponse;
  }

  Future<Response> addFamilyMember(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageCustomer);
    var request = await http.MultipartRequest('POST', url);
    if(data['image'].toString().isNotEmpty)
      request.files.add(
          await http.MultipartFile.fromPath(
              'image', data['image']
          )
      );
    if(data['proof_id_1'].toString().isNotEmpty)
      request.files.add(
          await http.MultipartFile.fromPath(
              'proof_id_1', data['proof_id_1']
          )
      );
    if(data['proof_id_2'].toString().isNotEmpty)
      request.files.add(
          await http.MultipartFile.fromPath(
              'proof_id_2', data['proof_id_2']
          )
      );

    request.fields['act'] = data['act'];
    request.fields['acc_id'] = data['acc_id'];
    request.fields['r_id'] = data['r_id'];
    request.fields['type'] = data['type'];
    request.fields['name'] = data['name'];
    request.fields['email'] = data['email'];
    request.fields['phone'] = data['phone'];
    request.fields['dob'] = data['dob'];
    request.fields['anniversary'] = data['anniversary'];
    request.fields['proof_type_1'] = data['proof_type_1'];
    request.fields['proof_type_2'] = data['proof_type_2'];
    request.fields['status'] = data['status'];
    if(data['act']==APIConstant.update) {
      request.fields['id'] = data['id'];
      request.fields['image'] = data['image'];
      request.fields['proof_id_1'] = data['proof_id_1'];
      request.fields['proof_id_2'] = data['proof_id_2'];
      request.fields['image_path'] = data['image_path'];
      request.fields['image_pt1'] = data['image_pt1'];
      request.fields['image_pt2'] = data['image_pt2'];
    }
    var res = await request.send();
    print(res.reasonPhrase);
    //Convert Stream to String
    final respStr = await res.stream.bytesToString();
    print(respStr);
    print(respStr);
    //Convert String to Json and Json to Object
    Response response = Response.fromJson(jsonDecode(respStr));
    return response;
  }

  Future<HealthClaimResponse> getHealthClaims(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageClaims, queryParameters);
    var result = await http.get(url);
    print(result.body);
    HealthClaimResponse healthClaimResponse = HealthClaimResponse.fromJson(json.decode(result.body));
    return healthClaimResponse;
  }

  Future<MotorClaimResponse> getMotorClaims(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageClaims, queryParameters);
    var result = await http.get(url);
    print(result.body);
    MotorClaimResponse motorClaimResponse = MotorClaimResponse.fromJson(json.decode(result.body));
    return motorClaimResponse;
  }

  Future<Response> addClaim(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageClaims);
    var result = await http.post(url, body: data);
    print(result.body);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }
}
