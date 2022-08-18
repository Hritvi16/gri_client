/// calendar_renewal : [{"nop":"1","install_premium":"100","annual_premium":"100","category":"LIFE"},{"nop":"1","install_premium":"100","annual_premium":"100","category":"GENERAL"}]

class CalendarRenewalResponse {
  CalendarRenewalResponse({
      List<CalendarRenewal>? calendarRenewal,});

  CalendarRenewalResponse.fromJson(dynamic json) {
    if (json['calendar_renewal'] != null) {
      calendarRenewal = [];
      json['calendar_renewal'].forEach((v) {
        calendarRenewal?.add(CalendarRenewal.fromJson(v));
      });
    }
  }
  List<CalendarRenewal>? calendarRenewal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (calendarRenewal != null) {
      map['calendar_renewal'] = calendarRenewal?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// nop : "1"
/// install_premium : "100"
/// annual_premium : "100"
/// category : "LIFE"

class CalendarRenewal {
  CalendarRenewal({
      String? nop, 
      String? installPremium, 
      String? annualPremium, 
      String? category,});

  CalendarRenewal.fromJson(dynamic json) {
    nop = json['nop'];
    installPremium = json['install_premium'];
    annualPremium = json['annual_premium'];
    category = json['category'];
  }
  String? nop;
  String? installPremium;
  String? annualPremium;
  String? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nop'] = nop;
    map['install_premium'] = installPremium;
    map['annual_premium'] = annualPremium;
    map['category'] = category;
    return map;
  }

}