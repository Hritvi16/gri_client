/// policy : [{"id":"18","acc_id":"1","category":"LIFE","pt_id":"5","com_id":"1","pn_id":"1","policy_number":"627627727272","sum_assured":"1000000","risk_date":"2022-08-13","policy_term":"10","maturity_date":"2022-08-25","amount":"100","frequency":"Yearly","payment_mode":"NON ECS","payment_term":"10","proposer":"1","policy_doc":"assets/policy/1659785120.pdf","receipt":"assets/receipt/1659785120.pdf","created_at":"2022-08-06 16:55:20","created_by":"1","created_by_u":null,"updated_at":"2022-08-06 16:55:20","updated_by":"1","status":"1","plan":"HEALTH - LIFE","plan_name":"BSLI Cancer Shield Plan"},{"id":"19","acc_id":"1","category":"LIFE","pt_id":"5","com_id":"1","pn_id":"1","policy_number":"627627727271","sum_assured":"1000000","risk_date":"2022-08-13","policy_term":"10","maturity_date":"2022-09-16","amount":"100","frequency":"Yearly","payment_mode":"NON ECS","payment_term":"10","proposer":"1","policy_doc":"assets/policy/1659785120.pdf","receipt":"assets/receipt/1659785120.pdf","created_at":"2022-08-06 16:55:20","created_by":"1","created_by_u":null,"updated_at":"2022-08-06 16:55:20","updated_by":"1","status":"1","plan":"HEALTH - LIFE","plan_name":"BSLI Cancer Shield Plan"}]

class PolicyResponse {
  PolicyResponse({
      List<Policy>? policy,});

  PolicyResponse.fromJson(dynamic json) {
    if (json['policy'] != null) {
      policy = [];
      json['policy'].forEach((v) {
        policy?.add(Policy.fromJson(v));
      });
    }
  }
  List<Policy>? policy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (policy != null) {
      map['policy'] = policy?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PolicyDetailResponse {
  PolicyDetailResponse({
      Policy? policy,
      List<Holders>? holders,
  });

  PolicyDetailResponse.fromJson(dynamic json) {
    policy = Policy.fromJson(json['policy']);
    if (json['holders'] != null) {
      holders = [];
      json['holders'].forEach((v) {
        holders?.add(Holders.fromJson(v));
      });
    }
  }

  Policy? policy;
  List<Holders>? holders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['policy'] = policy?.toJson();
    if (holders != null) {
      map['holders'] = holders?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "18"
/// acc_id : "1"
/// category : "LIFE"
/// pt_id : "5"
/// com_id : "1"
/// pn_id : "1"
/// policy_number : "627627727272"
/// sum_assured : "1000000"
/// risk_date : "2022-08-13"
/// policy_term : "10"
/// maturity_date : "2022-08-25"
/// amount : "100"
/// frequency : "Yearly"
/// payment_mode : "NON ECS"
/// payment_term : "10"
/// proposer : "1"
/// policy_doc : "assets/policy/1659785120.pdf"
/// receipt : "assets/receipt/1659785120.pdf"
/// created_at : "2022-08-06 16:55:20"
/// created_by : "1"
/// created_by_u : null
/// updated_at : "2022-08-06 16:55:20"
/// updated_by : "1"
/// status : "1"
/// plan : "HEALTH - LIFE"
/// plan_name : "BSLI Cancer Shield Plan"

class Policy {
  Policy({
      String? id, 
      String? accId, 
      String? category, 
      String? ptId, 
      String? comId, 
      String? pnId, 
      String? policyNumber, 
      String? sumAssured, 
      String? riskDate, 
      String? policyTerm, 
      String? maturityDate, 
      String? amount, 
      String? frequency, 
      String? paymentMode, 
      String? paymentTerm, 
      String? proposer, 
      String? policyDoc, 
      String? receipt, 
      String? createdAt, 
      String? createdBy, 
      String? createdByU,
      String? updatedAt, 
      String? updatedBy, 
      String? status, 
      String? plan, 
      String? planName,
      String? companyName,
      String? proposerName,
  });

  Policy.fromJson(dynamic json) {
    id = json['id'];
    accId = json['acc_id'];
    category = json['category'];
    ptId = json['pt_id'];
    comId = json['com_id'];
    pnId = json['pn_id'];
    policyNumber = json['policy_number'];
    sumAssured = json['sum_assured'];
    riskDate = json['risk_date'];
    policyTerm = json['policy_term'];
    maturityDate = json['maturity_date'];
    amount = json['amount'];
    frequency = json['frequency'];
    paymentMode = json['payment_mode'];
    paymentTerm = json['payment_term'];
    proposer = json['proposer'];
    policyDoc = json['policy_doc'];
    receipt = json['receipt'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    createdByU = json['created_by_u'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    status = json['status'];
    plan = json['plan'];
    planName = json['plan_name'];
    companyName = json['company_name'];
    proposerName = json['proposer_name'];
  }
  String? id;
  String? accId;
  String? category;
  String? ptId;
  String? comId;
  String? pnId;
  String? policyNumber;
  String? sumAssured;
  String? riskDate;
  String? policyTerm;
  String? maturityDate;
  String? amount;
  String? frequency;
  String? paymentMode;
  String? paymentTerm;
  String? proposer;
  String? policyDoc;
  String? receipt;
  String? createdAt;
  String? createdBy;
  String? createdByU;
  String? updatedAt;
  String? updatedBy;
  String? status;
  String? plan;
  String? planName;
  String? companyName;
  String? proposerName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['acc_id'] = accId;
    map['category'] = category;
    map['pt_id'] = ptId;
    map['com_id'] = comId;
    map['pn_id'] = pnId;
    map['policy_number'] = policyNumber;
    map['sum_assured'] = sumAssured;
    map['risk_date'] = riskDate;
    map['policy_term'] = policyTerm;
    map['maturity_date'] = maturityDate;
    map['amount'] = amount;
    map['frequency'] = frequency;
    map['payment_mode'] = paymentMode;
    map['payment_term'] = paymentTerm;
    map['proposer'] = proposer;
    map['policy_doc'] = policyDoc;
    map['receipt'] = receipt;
    map['created_at'] = createdAt;
    map['created_by'] = createdBy;
    map['created_by_u'] = createdByU;
    map['updated_at'] = updatedAt;
    map['updated_by'] = updatedBy;
    map['status'] = status;
    map['plan'] = plan;
    map['plan_name'] = planName;
    map['company_name'] = companyName;
    map['proposer_name'] = proposerName;
    return map;
  }

}

class Holders {
  Holders({
      String? id,
      String? inId,
      String? insuredPerson,
      String? name,
  });

  Holders.fromJson(dynamic json) {
    id = json['id'];
    inId = json['in_id'];
    insuredPerson = json['insured_person'];
    name = json['name'];
  }
  String? id;
  String? inId;
  String? insuredPerson;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['in_id'] = inId;
    map['insured_person'] = insuredPerson;
    map['name'] = name;
    return map;
  }

}