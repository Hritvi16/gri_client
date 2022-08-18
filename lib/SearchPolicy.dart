import 'package:flutter/material.dart';
import 'package:gri_client/PolicyDetail.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/PolicyResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPolicy extends StatefulWidget {
  final String category;
  const SearchPolicy({Key? key, required this.category}) : super(key: key);

  @override
  State<SearchPolicy> createState() => _SearchPolicyState();
}

class _SearchPolicyState extends State<SearchPolicy> {

  late SharedPreferences sharedPreferences;
  List<Policy> policies = [];

  TextEditingController search = TextEditingController();
  bool load = false;

  @override
  void initState() {
    start();
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getSearchPolicies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150), // here the desired height
          child: SafeArea(
            child: Container(
              height: 100,
              color: MyColors.white,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: MySize.size5(context)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo/logo.jpg",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "GRASS ROOT INVESTORS",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: MyColors.colorPrimary
                        )
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12, right: 10, left: 10),
                    height: 50.0,
                    child: TextField(
                      onChanged: (value) {
                        getSearchPolicies();
                      },
                      controller: search,
                      decoration: InputDecoration(
                        hintText: "Search Policy",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.colorPrimary
                          )
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)
                      ),
                      cursorColor: MyColors.black,
                    ),
                  )
                ],
              ),
            ),
          )
      ),
      body: SafeArea(
        child: load ?
          policies.isNotEmpty ? getPoliciesList()
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
            color: policy.status=="0" ? MyColors.red.withOpacity(0.2) : MyColors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: MyColors.grey10),
            boxShadow: policy.status=="0" ? []
            : [
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

  Future<void> getSearchPolicies() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getBySearch,
      "id" : sharedPreferences.getString("id")??"",
      "category" : widget.category,
      "search" : search.text,
    };

    PolicyResponse policyResponse = await APIService().getPolicies(queryParameters);

    policies = policyResponse.policy ?? [];

    if(!load)
      load = true;

    setState(() {

    });
  }
}
