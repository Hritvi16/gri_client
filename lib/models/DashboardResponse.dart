/// dashboard : [{"plan":"HEALTH - LIFE","total":"1"},{"plan":"TERM ASSURANCE","total":"8"},{"plan":"TRADITIONAL","total":"3"},{"plan":"ULIP","total":"2"}]

class DashboardResponse {
  DashboardResponse({
      List<Dashboard>? dashboard,});

  DashboardResponse.fromJson(dynamic json) {
    if (json['dashboard'] != null) {
      dashboard = [];
      json['dashboard'].forEach((v) {
        dashboard?.add(Dashboard.fromJson(v));
      });
    }
  }
  List<Dashboard>? dashboard;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dashboard != null) {
      map['dashboard'] = dashboard?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// plan : "HEALTH - LIFE"
/// total : "1"

class Dashboard {
  Dashboard({
      String? id,
      String? plan,
      String? total,});

  Dashboard.fromJson(dynamic json) {
    id = json['id'];
    plan = json['plan'];
    total = json['total'];
  }
  String? id;
  String? plan;
  String? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['plan'] = plan;
    map['total'] = total;
    return map;
  }

}