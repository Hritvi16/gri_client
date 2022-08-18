import 'package:flutter/material.dart';
import 'package:gri_client/HealthClaimForm.dart';
import 'package:gri_client/MotorClaimForm.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/api/Environment.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/HealthClaimResponse.dart';
import 'package:gri_client/models/MotorClaimResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MotorClaim extends StatefulWidget {
  const MotorClaim({Key? key}) : super(key: key);

  @override
  State<MotorClaim> createState() => _MotorClaimState();
}

class _MotorClaimState extends State<MotorClaim> {

  late SharedPreferences sharedPreferences;
  bool load = false;
  List<MotorClaims> motorClaims = [];

  @override
  void initState() {
    start();
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getMotorClaims();
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
          "MOTOR CLAIMS",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: MyColors.colorPrimary
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          "assets/dashboard/motor.png",
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                MotorClaimForm())).then((value) {
                  getMotorClaims();
          });
        },
      ),
      body: load ? motorClaims.isNotEmpty ? getMotorClaimList()
        : Center(
          child: Text(
            "No Motor Claims"
          ),
        )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getMotorClaimList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySize.size2(context), vertical: 10),
      child: ListView.separated(
        itemCount: motorClaims.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext buildContext, index) {
          return getClaimCard(motorClaims[index]);
        },
        separatorBuilder: (BuildContext buildContext, index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }

  getClaimCard(MotorClaims motorClaim) {
    String status = motorClaim.status??"";
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
          getData("Client", motorClaim.accName??""),
          SizedBox(
            height: 7,
          ),
          getData("Patient", motorClaim.client??""),
          SizedBox(
            height: 7,
          ),
          getData("Policy No", motorClaim.policyNumber??""),
          SizedBox(
            height: 7,
          ),
          getData("Company", motorClaim.companyName??""),
          SizedBox(
            height: 7,
          ),
          getData("Product", motorClaim.planName??""),
          SizedBox(
            height: 7,
          ),
          getData("Accident Date", DateFormat("dd-MMM-yyyy").format(DateTime.parse(motorClaim.accident??""))),
          SizedBox(
            height: 7,
          ),
          getData("Claim Amount", Environment.rupee + (motorClaim.amount??"")),
          SizedBox(
            height: 7,
          ),
          getData("Status", (motorClaim.status??"").toUpperCase()),
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

  Future<void> getMotorClaims() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getMotorClaims,
      "id" : sharedPreferences.getString("id")??"",
    };

    MotorClaimResponse motorClaimResponse = await APIService().getMotorClaims(queryParameters);

    motorClaims = motorClaimResponse.motorClaims ?? [];

    if(!load)
      load = true;

    setState(() {

    });
  }
}
