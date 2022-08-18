import 'package:flutter/material.dart';
import 'package:gri_client/HealthClaimForm.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/api/Environment.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/HealthClaimResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthClaim extends StatefulWidget {
  const HealthClaim({Key? key}) : super(key: key);

  @override
  State<HealthClaim> createState() => _HealthClaimState();
}

class _HealthClaimState extends State<HealthClaim> {

  late SharedPreferences sharedPreferences;
  bool load = false;
  List<HealthClaims> healthClaims = [];

  @override
  void initState() {
    start();
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getHealthClaims();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.white,
        elevation: 0,
        title: Text(
          "HEALTH CLAIMS",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: MyColors.colorPrimary
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          "assets/dashboard/health.png",
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                HealthClaimForm())).then((value) {
                  getHealthClaims();
          });
        },
      ),
      body: load ? healthClaims.isNotEmpty ? getHealthClaimsList()
        : Center(
          child: Text(
            "No Health Claims"
          ),
        )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getHealthClaimsList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySize.size2(context), vertical: 10),
      child: ListView.separated(
        itemCount: healthClaims.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext buildContext, index) {
          return getClaimCard(healthClaims[index]);
        },
        separatorBuilder: (BuildContext buildContext, index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }

  getClaimCard(HealthClaims healthClaim) {
    String status = healthClaim.status??"";
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: MySize.size2(context)),
      decoration: BoxDecoration(
        color: status=="PENDING" ? MyColors.white : status=="APPROVED" ?
        MyColors.colorPrimary.withOpacity(0.3) : status=="UNDER PROCESS" ?
        MyColors.colorSecondary.withOpacity(0.3)  : status=="CLAIMED" ?
        MyColors.green500.withOpacity(0.3)  : MyColors.red.withOpacity(0.3) ,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: MyColors.grey10),
      ),
      child: Column(
        children: [
          getData("Client", healthClaim.accName??""),
          SizedBox(
            height: 7,
          ),
          getData("Patient", healthClaim.client??""),
          SizedBox(
            height: 7,
          ),
          getData("Policy No", healthClaim.policyNumber??""),
          SizedBox(
            height: 7,
          ),
          getData("Company", healthClaim.companyName??""),
          SizedBox(
            height: 7,
          ),
          getData("Product", healthClaim.planName??""),
          SizedBox(
            height: 7,
          ),
          getData("Claim Date", DateFormat("dd-MMM-yyyy").format(DateTime.parse(healthClaim.claimDate??""))),
          SizedBox(
            height: 7,
          ),
          getData("Claim Amount", Environment.rupee + (healthClaim.amount??"")),
          SizedBox(
            height: 7,
          ),
          getData("Status", (healthClaim.status??"").toUpperCase()),
        ],
      ),
    );
  }

  getData(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MySize.size35(context),
          child: Text(
            title+" : ",
            style: TextStyle(
                fontWeight: FontWeight.w600
            ),
          ),
        ),
        Expanded(
          child: Text(info),
        )
      ],
    );
  }

  Future<void> getHealthClaims() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getHealthClaims,
      "id" : sharedPreferences.getString("id")??"",
    };

    HealthClaimResponse healthClaimResponse = await APIService().getHealthClaims(queryParameters);

    healthClaims = healthClaimResponse.healthClaims ?? [];

    if(!load)
      load = true;

    setState(() {

    });
  }
}
