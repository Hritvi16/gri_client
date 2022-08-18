/// motor_claims : [{"id":"1","acc_id":"1","name":"1","policy":"22","place":"Bhagal","address":"Rampura","garage":"Maddie Ke Paas","surveyor":"Hum Khud","estimate":"1000000","remarks":"Jaldi Thik Karna","accident":"2022-08-09 18:25:00","status":"PENDING","created_at":"2022-08-09 05:55:25","acc_name":"Cust","client":"Cust","policy_number":"6544","plan_name":"Tata AIG Two Wheeler Bundled","company_name":"Tata AIG General Insurance Company Limited"},{"id":"2","acc_id":"1","name":"1","policy":"22","place":"Bhagal","address":"Rampura","garage":"Maddie Ke Paas","surveyor":"Hum Khud","estimate":"1000000","remarks":"Jaldi Thik Karna","accident":"2022-08-09 18:25:00","status":"PENDING","created_at":"2022-08-09 05:55:36","acc_name":"Cust","client":"Cust","policy_number":"6544","plan_name":"Tata AIG Two Wheeler Bundled","company_name":"Tata AIG General Insurance Company Limited"}]

class MotorClaimResponse {
  MotorClaimResponse({
      List<MotorClaims>? motorClaims,});

  MotorClaimResponse.fromJson(dynamic json) {
    if (json['motor_claims'] != null) {
      motorClaims = [];
      json['motor_claims'].forEach((v) {
        motorClaims?.add(MotorClaims.fromJson(v));
      });
    }
  }
  List<MotorClaims>? motorClaims;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (motorClaims != null) {
      map['motor_claims'] = motorClaims?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// acc_id : "1"
/// name : "1"
/// policy : "22"
/// place : "Bhagal"
/// address : "Rampura"
/// garage : "Maddie Ke Paas"
/// surveyor : "Hum Khud"
/// estimate : "1000000"
/// remarks : "Jaldi Thik Karna"
/// accident : "2022-08-09 18:25:00"
/// status : "PENDING"
/// created_at : "2022-08-09 05:55:25"
/// acc_name : "Cust"
/// client : "Cust"
/// policy_number : "6544"
/// plan_name : "Tata AIG Two Wheeler Bundled"
/// company_name : "Tata AIG General Insurance Company Limited"

class MotorClaims {
  MotorClaims({
      String? id, 
      String? accId, 
      String? name, 
      String? policy, 
      String? place, 
      String? address, 
      String? garage, 
      String? surveyor, 
      String? estimate, 
      String? remarks, 
      String? accident, 
      String? amount,
      String? status,
      String? createdAt,
      String? accName, 
      String? client, 
      String? policyNumber, 
      String? planName, 
      String? companyName,});

  MotorClaims.fromJson(dynamic json) {
    id = json['id'];
    accId = json['acc_id'];
    name = json['name'];
    policy = json['policy'];
    place = json['place'];
    address = json['address'];
    garage = json['garage'];
    surveyor = json['surveyor'];
    estimate = json['estimate'];
    remarks = json['remarks'];
    accident = json['accident'];
    status = json['status'];
    amount = json['amount'];
    createdAt = json['created_at'];
    accName = json['acc_name'];
    client = json['client'];
    policyNumber = json['policy_number'];
    planName = json['plan_name'];
    companyName = json['company_name'];
  }
  String? id;
  String? accId;
  String? name;
  String? policy;
  String? place;
  String? address;
  String? garage;
  String? surveyor;
  String? estimate;
  String? remarks;
  String? accident;
  String? amount;
  String? status;
  String? createdAt;
  String? accName;
  String? client;
  String? policyNumber;
  String? planName;
  String? companyName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['acc_id'] = accId;
    map['name'] = name;
    map['policy'] = policy;
    map['place'] = place;
    map['address'] = address;
    map['garage'] = garage;
    map['surveyor'] = surveyor;
    map['estimate'] = estimate;
    map['remarks'] = remarks;
    map['accident'] = accident;
    map['status'] = status;
    map['amount'] = amount;
    map['created_at'] = createdAt;
    map['acc_name'] = accName;
    map['client'] = client;
    map['policy_number'] = policyNumber;
    map['plan_name'] = planName;
    map['company_name'] = companyName;
    return map;
  }

}