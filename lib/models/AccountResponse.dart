class AccountListResponse {
  AccountListResponse({
    List<Account>? accounts,});

  AccountListResponse.fromJson(dynamic json) {
    if (json['accounts'] != null) {
      accounts = [];
      json['accounts'].forEach((v) {
        accounts?.add(Account.fromJson(v));
      });
    }
  }

  List<Account>? accounts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (accounts != null) {
      map['accounts'] = accounts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AccountResponse {
  AccountResponse({
    Account? account,
    List<Account>? family,});

  AccountResponse.fromJson(dynamic json) {
    account = Account.fromJson(json['account']);
    if (json['family'] != null) {
      family = [];
      json['family'].forEach((v) {
        family?.add(Account.fromJson(v));
      });
    }
  }

  Account? account;
  List<Account>? family;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account'] = account?.toJson();
    if (family != null) {
      map['family'] = family?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Account {
  Account({
    String? id,
    String? accId,
    String? rId,
    String? type,
    String? name,
    String? email,
    String? phone,
    String? dob,
    String? anniversary,
    String? image,
    String? proofType1,
    String? proofId1,
    String? proofType2,
    String? proofId2,
    String? status,
    String? createdAt,
    String? createdBy,
    String? updatedAt,
    String? updatedBy,
    String? isDelete,
    String? relation,
  });

  Account.fromJson(dynamic json) {
    id = json['id'];
    accId = json['acc_id'];
    rId = json['r_id'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    dob = json['dob'];
    anniversary = json['anniversary'];
    image = json['image'];
    proofType1 = json['proof_type_1'];
    proofId1 = json['proof_id_1'];
    proofType2 = json['proof_type_2'];
    proofId2 = json['proof_id_2'];
    status = json['status'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    isDelete = json['is_delete'];
    relation = json['relation'];
  }
  String? id;
  String? accId;
  String? rId;
  String? type;
  String? name;
  String? email;
  String? phone;
  String? dob;
  String? anniversary;
  String? image;
  String? proofType1;
  String? proofId1;
  String? proofType2;
  String? proofId2;
  String? status;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? isDelete;
  String? relation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['acc_id'] = accId;
    map['r_id'] = rId;
    map['type'] = type;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['dob'] = dob;
    map['anniversary'] = anniversary;
    map['image'] = image;
    map['proof_type_1'] = proofType1;
    map['proof_id_1'] = proofId1;
    map['proof_type_2'] = proofType2;
    map['proof_id_2'] = proofId2;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['created_by'] = createdBy;
    map['updated_at'] = updatedAt;
    map['updated_by'] = updatedBy;
    map['is_delete'] = isDelete;
    map['relation'] = relation;
    return map;
  }

}