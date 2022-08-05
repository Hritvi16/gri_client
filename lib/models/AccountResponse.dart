
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
    String? isDelete,});

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
    return map;
  }

}