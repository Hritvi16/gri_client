/// relation : [{"id":"1","relation":"Wife","is_delete":"0"},{"id":"2","relation":"Daughter","is_delete":"0"},{"id":"3","relation":"Husband","is_delete":"0"},{"id":"4","relation":"Son","is_delete":"0"},{"id":"5","relation":"Father","is_delete":"0"},{"id":"6","relation":"Mother","is_delete":"0"},{"id":"7","relation":"FATHER IN LAW","is_delete":"0"}]

class RelationResponse {
  RelationResponse({
      List<Relation>? relation,});

  RelationResponse.fromJson(dynamic json) {
    if (json['relation'] != null) {
      relation = [];
      json['relation'].forEach((v) {
        relation?.add(Relation.fromJson(v));
      });
    }
  }
  List<Relation>? relation;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (relation != null) {
      map['relation'] = relation?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// relation : "Wife"
/// is_delete : "0"

class Relation {
  Relation({
      String? id, 
      String? relation, 
      String? isDelete,});

  Relation.fromJson(dynamic json) {
    id = json['id'];
    relation = json['relation'];
    isDelete = json['is_delete'];
  }
  String? id;
  String? relation;
  String? isDelete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['relation'] = relation;
    map['is_delete'] = isDelete;
    return map;
  }

}