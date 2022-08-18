/// healthClaims : [{"id":"1","acc_id":"1","name":"1","policy":"18","patient":"dd","age":"9","claim_date":"2022-08-12","photo_id":"dd","hospital":"s","address":"s","contact":"026126625532","admission":"2022-08-24 00:00:00","doctor":"s","disease":"s","room":"s","remarks":"ss","status":"PENDING","created_at":"2022-08-09 04:56:17","acc_name":"Cust","client":"Cust","policy_number":"627627727272"},{"id":"2","acc_id":"1","name":"1","policy":"18","patient":"dd","age":"9","claim_date":"2022-08-12","photo_id":"dd","hospital":"s","address":"s","contact":"026126625532","admission":"2022-08-24 00:00:00","doctor":"s","disease":"s","room":"s","remarks":"ss","status":"PENDING","created_at":"2022-08-09 04:56:27","acc_name":"Cust","client":"Cust","policy_number":"627627727272"},{"id":"3","acc_id":"1","name":"1","policy":"18","patient":"dd","age":"9","claim_date":"2022-08-12","photo_id":"dd","hospital":"s","address":"s","contact":"026126625532","admission":"2022-08-24 00:00:00","doctor":"s","disease":"s","room":"s","remarks":"ss","status":"PENDING","created_at":"2022-08-09 04:56:45","acc_name":"Cust","client":"Cust","policy_number":"627627727272"},{"id":"4","acc_id":"1","name":"1","policy":"18","patient":"dd","age":"9","claim_date":"2022-08-12","photo_id":"dd","hospital":"s","address":"s","contact":"026126625532","admission":"2022-08-24 00:00:00","doctor":"s","disease":"s","room":"s","remarks":"ss","status":"PENDING","created_at":"2022-08-09 04:57:07","acc_name":"Cust","client":"Cust","policy_number":"627627727272"},{"id":"5","acc_id":"1","name":"1","policy":"18","patient":"dd","age":"9","claim_date":"2022-08-12","photo_id":"dd","hospital":"s","address":"s","contact":"026126625532","admission":"2022-08-24 00:00:00","doctor":"s","disease":"s","room":"s","remarks":"ss","status":"PENDING","created_at":"2022-08-09 04:57:44","acc_name":"Cust","client":"Cust","policy_number":"627627727272"}]

class HealthClaimResponse {
  HealthClaimResponse({
      List<HealthClaims>? healthClaims,});

  HealthClaimResponse.fromJson(dynamic json) {
    if (json['health_claims'] != null) {
      healthClaims = [];
      json['health_claims'].forEach((v) {
        healthClaims?.add(HealthClaims.fromJson(v));
      });
    }
  }

  List<HealthClaims>? healthClaims;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (healthClaims != null) {
      map['health_claims'] = healthClaims?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// acc_id : "1"
/// name : "1"
/// policy : "18"
/// patient : "dd"
/// age : "9"
/// claim_date : "2022-08-12"
/// photo_id : "dd"
/// hospital : "s"
/// address : "s"
/// contact : "026126625532"
/// admission : "2022-08-24 00:00:00"
/// doctor : "s"
/// disease : "s"
/// room : "s"
/// remarks : "ss"
/// status : "PENDING"
/// created_at : "2022-08-09 04:56:17"
/// acc_name : "Cust"
/// client : "Cust"
/// policy_number : "627627727272"

class HealthClaims {
  HealthClaims({
      String? id, 
      String? accId, 
      String? name, 
      String? policy, 
      String? patient, 
      String? age, 
      String? claimDate, 
      String? photoId, 
      String? hospital, 
      String? address, 
      String? contact, 
      String? admission, 
      String? doctor, 
      String? disease, 
      String? room, 
      String? remarks, 
      String? amount,
      String? status,
      String? createdAt,
      String? accName, 
      String? client, 
      String? policyNumber,
      String? planName,
      String? companyName,});

  HealthClaims.fromJson(dynamic json) {
    id = json['id'];
    accId = json['acc_id'];
    name = json['name'];
    policy = json['policy'];
    patient = json['patient'];
    age = json['age'];
    claimDate = json['claim_date'];
    photoId = json['photo_id'];
    hospital = json['hospital'];
    address = json['address'];
    contact = json['contact'];
    admission = json['admission'];
    doctor = json['doctor'];
    disease = json['disease'];
    room = json['room'];
    remarks = json['remarks'];
    amount = json['amount'];
    status = json['status'];
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
  String? patient;
  String? age;
  String? claimDate;
  String? photoId;
  String? hospital;
  String? address;
  String? contact;
  String? admission;
  String? doctor;
  String? disease;
  String? room;
  String? remarks;
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
    map['patient'] = patient;
    map['age'] = age;
    map['claim_date'] = claimDate;
    map['photo_id'] = photoId;
    map['hospital'] = hospital;
    map['address'] = address;
    map['contact'] = contact;
    map['admission'] = admission;
    map['doctor'] = doctor;
    map['disease'] = disease;
    map['room'] = room;
    map['remarks'] = remarks;
    map['amount'] = amount;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['acc_name'] = accName;
    map['client'] = client;
    map['policy_number'] = policyNumber;
    map['plan_name'] = planName;
    map['company_name'] = companyName;
    return map;
  }

}