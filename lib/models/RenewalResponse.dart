/// renewals : [{"total":"1","year":"2022","month":"8","category":"LIFE"},{"total":"1","year":"2022","month":"9","category":"LIFE"}]

class RenewalResponse {
  RenewalResponse({
      List<Renewals>? renewals,});

  RenewalResponse.fromJson(dynamic json) {
    if (json['renewals'] != null) {
      renewals = [];
      json['renewals'].forEach((v) {
        renewals?.add(Renewals.fromJson(v));
      });
    }
  }
  List<Renewals>? renewals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (renewals != null) {
      map['renewals'] = renewals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// total : "1"
/// year : "2022"
/// month : "8"
/// category : "LIFE"

class Renewals {
  Renewals({
      String? total, 
      String? year, 
      String? month, 
      String? category,});

  Renewals.fromJson(dynamic json) {
    total = json['total'];
    year = json['year'];
    month = json['month'];
    category = json['category'];
  }
  String? total;
  String? year;
  String? month;
  String? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['year'] = year;
    map['month'] = month;
    map['category'] = category;
    return map;
  }

}