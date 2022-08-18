import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gri_client/HealthClaim.dart';
import 'package:gri_client/MotorClaim.dart';
import 'package:gri_client/Notifications.dart';
import 'package:gri_client/Policies.dart';
import 'package:gri_client/SearchPolicy.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/DashboardResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late SharedPreferences sharedPreferences;
  bool load = false;
  DateTime refresh = DateTime.now();
  List<Dashboard> dashboard = [];
  Map<String, double> dataMap = {};

  @override
  void initState() {
    start();
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return load ? Scaffold(
        backgroundColor: MyColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MySize.size5(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getDivision1(),
                      getLabel("Search Policy"),
                      getDivision2("search.png", "General\nInsurance", "search.png", "Life\nInsurance"),
                      getLabel("Claim Intimation"),
                      getDivision2("health.png", "Health", "motor.png", "Motor"),
                      getLabel("Insurance"),
                    ],
                  ),
                ),
                getDuoLabel("Type/Sub Type", "Policies"),
                getPolicies()
              ],
            ),
          )
        )
    )
    : Center(
      child: CircularProgressIndicator(),
    );
  }

  getDivision1() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              color: MyColors.white,
              margin: EdgeInsets.only(right: 10),
              child: Image.asset(
                "assets/logo/logo.jpg",
                height: 50,
                width: 50,
              ),
            ),
          ),
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "GRASS ROOT INVESTORS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: MyColors.colorPrimary
                    )
                ),


              // Container(
                //   width: MySize.size100(context),
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   padding: EdgeInsets.symmetric(vertical: 5),
                //   alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //       color: MyColors.white,
                //       borderRadius: BorderRadius.circular(5),
                //       border: Border.all(color: MyColors.grey10),
                //       boxShadow: const [
                //         BoxShadow(
                //           color: Colors.grey,
                //           offset: Offset(0.0, 1.0), //(x,y)
                //           blurRadius: 1.0,
                //         ),
                //       ]
                //   ),
                //   child: Text(
                //       "Last Sync:   "+DateFormat("dd-MMM-yyyy  HH:mm:ss").format(refresh),
                //       style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w600,
                //           color: MyColors.colorLightPrimary
                //       )
                //   ),
                // ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Notifications()));
              },
              child: Container(
                color: MyColors.white,
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  "assets/dashboard/notification.png",
                  height: 25,
                  width: 25,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getLabel(String label) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MyColors.colorLightPrimary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
                label,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: MyColors.white
                )
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SizedBox(),
        )
      ],
    );
  }

  getDuoLabel(String label1 ,String label2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: MySize.size3(context)),
      decoration: BoxDecoration(
        color: MyColors.colorLightSecondary.withOpacity(0.2),
        border: Border(
          bottom: BorderSide(
            color: MyColors.colorPrimary
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label1,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: MyColors.colorPrimary
            )
          ),
          Text(
            label2,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: MyColors.colorPrimary
            )
          )
        ],
      ),
    );
  }

  getDivision2(String icon1, String title1, String icon2, String title2) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
              if(title1=="Health") {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HealthClaim()));
              }
              else {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SearchPolicy(category: "GENERAL")));
              }
            },
            child: Container(
              height: MySize.size35(context),
              margin: EdgeInsets.only(bottom: 20, right: 5, left: 5),
              padding: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: MyColors.grey10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 1.0,
                    ),
                  ]
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Image.asset(
                      "assets/dashboard/"+icon1,
                    ),
                  ),
                  SizedBox(
                    height: MySize.size1(context),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          title1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.colorLightPrimary
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
              if(title2=="Motor") {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MotorClaim()));
              }
              else {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SearchPolicy(category: "LIFE")));
              }
            },
            child: Container(
              height: MySize.size35(context),
              margin: EdgeInsets.only(bottom: 20, right: 5, left: 5),
              padding: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: MyColors.grey10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 1.0,
                    ),
                  ]
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Image.asset(
                      "assets/dashboard/"+icon2,
                    ),
                  ),
                  SizedBox(
                    height: MySize.size1(context),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          title2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.colorLightPrimary
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  getPolicies() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySize.size2(context), vertical: 10),
      child: ListView.separated(
        itemCount: dashboard.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext buildContext, index) {
          return index!=dashboard.length-1 ? getPolicyCard(dashboard[index]) : getTotalCard(dashboard[index]);
        },
        separatorBuilder: (BuildContext buildContext, index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }

  getPolicyCard(Dashboard dashboard) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => Policies(act: APIConstant.getByPlanType, data: dashboard.id??"")));
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: MySize.size2(context)),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: MyColors.grey10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (dashboard.plan??"")+" ("+(dashboard.total??"")+")",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: MyColors.black
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  dashboard.total??"",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyColors.black
                  )
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: MyColors.colorSecondary,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getTotalCard(Dashboard dashboard) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => Policies(act: APIConstant.getAll, data: "",)));
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: MySize.size2(context)),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: MyColors.grey10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                  text: dashboard.plan??"",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: MyColors.black
                  ),
                  children: [
                    TextSpan(
                      text: " ("+(dashboard.total??"")+")",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ]
              ),
            ),
            if(dataMap.isNotEmpty)
              getPieChart(dashboard.total??"0")
          ],
        ),
      ),
    );
  }

  getPieChart(String total) {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: MySize.size3(context)),
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: 30,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 30,
        // centerText: total,
        legendOptions: const LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: false,
          legendShape: BoxShape.circle,
        ),
        chartValuesOptions: const ChartValuesOptions(
          showChartValueBackground: false,
          showChartValues: false,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 1,
        ),
      ),
    );
  }

  getDashboard() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getDashboard,
      "id" : sharedPreferences.getString("id")??"",
    };
    DashboardResponse dashboardResponse = await APIService().getDashboard(queryParameters);

    dashboard = dashboardResponse.dashboard ?? [];
    int total = 0;

    dashboard.forEach((element) {
      total += int.parse(element.total??"0");
      dataMap.addAll({element.plan??"" : double.parse(element.total??"0")});
    });
    dashboard.add(Dashboard.fromJson({"plan" : "Total", "total": total.toString()}));
    refresh = DateTime.now();
    load = true;

    setState(() {

    });
  }
}
