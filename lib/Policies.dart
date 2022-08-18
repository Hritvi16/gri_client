import 'package:flutter/material.dart';
import 'package:gri_client/PolicyDetail.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/PolicyResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Policies extends StatefulWidget {
  final String act, data;
  final DateTime? date;
  const Policies({Key? key, required this.act, required this.data, this.date}) : super(key: key);

  @override
  State<Policies> createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {

  late SharedPreferences sharedPreferences;
  bool load = false;
  List<Policy> policies = [];

  @override
  void initState() {
    start();
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getPolicies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: load ? policies.isNotEmpty ? getPoliciesList()
          : Center(
            child: Text(
              "No Policies"
            ),
          )
        : Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
  
  getPoliciesList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySize.size2(context), vertical: 10),
      child: ListView.separated(
        itemCount: policies.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext buildContext, index) {
          return getPolicyCard(policies[index]);
        },
        separatorBuilder: (BuildContext buildContext, index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }

  getPolicyCard(Policy policy) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    PolicyDetail(id: policy.id??"")));
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
        child: Column(
          children: [
            getData("Category", policy.category??""),
            SizedBox(
              height: 7,
            ),
            getData("Policy No.", policy.policyNumber??""),
            SizedBox(
              height: 7,
            ),
            getData("Plan Type", policy.plan??""),
            SizedBox(
              height: 7,
            ),
            getData("Company", policy.companyName??""),
            SizedBox(
              height: 7,
            ),
            getData("Risk Date", DateFormat("dd-MM-yyyy").format(DateTime.parse(policy.riskDate??""))),
            SizedBox(
              height: 7,
            ),
            getData("Maturity Date", DateFormat("dd-MM-yyyy").format(DateTime.parse(policy.maturityDate??""))),
            SizedBox(
              height: 7,
            ),
            getData("Plan", policy.planName??""),
            SizedBox(
              height: 7,
            ),
            getData("Premium Term", policy.paymentTerm??""),
            SizedBox(
              height: 7,
            ),
            getData("Policy Term", policy.policyTerm??""),
            SizedBox(
              height: 7,
            ),
            getData("Premium Frequency", policy.frequency??""),
            SizedBox(
              height: 7,
            ),
            getData("Premium", policy.amount??""),
          ],
        ),
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

  Future<void> getPolicies() async {
    Map<String,String> queryParameters = {
      APIConstant.act : widget.act,
      "id" : sharedPreferences.getString("id")??"",
      "data" : widget.data,
    };

    if(widget.act==APIConstant.getByDate) {
      queryParameters.addAll({
        "start" : DateFormat("yyyy-MM-dd").format(DateTime(widget.date!.year, widget.date!.month, 1)),
        "end" : DateFormat("yyyy-MM-dd").format(DateTime(widget.date!.year, widget.date!.month+1).subtract(Duration(days: 1)))
      });
    }

    PolicyResponse policyResponse = await APIService().getPolicies(queryParameters);

    policies = policyResponse.policy ?? [];

    if(!load)
      load = true;

    setState(() {

    });
  }
}
