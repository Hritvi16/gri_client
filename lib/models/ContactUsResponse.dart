/// contact_us : {"mobile":"9090909090","email":"greentrootinvestors@gmail.com","city":"Surat, Gujarat"}

class ContactUsResponse {
  ContactUsResponse({
      ContactUs? contactUs,});

  ContactUsResponse.fromJson(dynamic json) {
    contactUs = json['contact_us'] != null ? ContactUs.fromJson(json['contact_us']) : null;
  }
  ContactUs? contactUs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (contactUs != null) {
      map['contact_us'] = contactUs?.toJson();
    }
    return map;
  }

}

/// mobile : "9090909090"
/// email : "greentrootinvestors@gmail.com"
/// city : "Surat, Gujarat"

class ContactUs {
  ContactUs({
      String? mobile, 
      String? email, 
      String? city,}){
    _mobile = mobile;
    _email = email;
    _city = city;
}

  ContactUs.fromJson(dynamic json) {
    _mobile = json['mobile'];
    _email = json['email'];
    _city = json['city'];
  }
  String? _mobile;
  String? _email;
  String? _city;

  String? get mobile => _mobile;
  String? get email => _email;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['city'] = _city;
    return map;
  }

}