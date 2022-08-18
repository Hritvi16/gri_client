/// tollfree : [{"id":"1","company":"Company 1","tag1":"Sales","mobile1":"9090909090","tag2":"Hello","mobile2":null,"tag3":null,"mobile3":null,"is_delete":"0"}]

class TollFreeResponse {
  TollFreeResponse({
      List<TollFree>? tollfree,});

  TollFreeResponse.fromJson(dynamic json) {
    if (json['tollfree'] != null) {
      tollfree = [];
      json['tollfree'].forEach((v) {
        tollfree?.add(TollFree.fromJson(v));
      });
    }
  }
  List<TollFree>? tollfree;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tollfree != null) {
      map['tollfree'] = tollfree?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// company : "Company 1"
/// tag1 : "Sales"
/// mobile1 : "9090909090"
/// tag2 : "Hello"
/// mobile2 : null
/// tag3 : null
/// mobile3 : null
/// is_delete : "0"

class TollFree {
  TollFree({
      String? id, 
      String? company, 
      String? tag1, 
      String? mobile1, 
      String? tag2, 
      String? mobile2,
      String? tag3,
      String? mobile3,
      String? isDelete,});

  TollFree.fromJson(dynamic json) {
    id = json['id'];
    company = json['company'];
    tag1 = json['tag1'];
    mobile1 = json['mobile1'];
    tag2 = json['tag2'];
    mobile2 = json['mobile2'];
    tag3 = json['tag3'];
    mobile3 = json['mobile3'];
    isDelete = json['is_delete'];
  }
  String? id;
  String? company;
  String? tag1;
  String? mobile1;
  String? tag2;
  String? mobile2;
  String? tag3;
  String? mobile3;
  String? isDelete;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company'] = company;
    map['tag1'] = tag1;
    map['mobile1'] = mobile1;
    map['tag2'] = tag2;
    map['mobile2'] = mobile2;
    map['tag3'] = tag3;
    map['mobile3'] = mobile3;
    map['is_delete'] = isDelete;
    return map;
  }

}