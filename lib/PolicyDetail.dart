import 'package:flutter/material.dart';
import 'package:gri_client/HealthClaimForm.dart';
import 'package:gri_client/MotorClaimForm.dart';
import 'package:gri_client/PDFViewer.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/api/Environment.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/PolicyResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyDetail extends StatefulWidget {
  final String id;
  const PolicyDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<PolicyDetail> createState() => _PolicyDetailState();
}

class _PolicyDetailState extends State<PolicyDetail> {

  Policy policy = Policy();
  List<Holders> holders = [];

  bool load = false;

  @override
  void initState() {
    getPolicyDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: Text(
            "POLICY DETAILS",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )
        ),
        centerTitle: false,
        iconTheme: IconThemeData(
            size: 18
        ),
        elevation: 0,
        backgroundColor: MyColors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: MySize.size3(context)),
        child: load ? SingleChildScrollView(
          child: Column(
            children: [
              getPolicyDetailsCard(),
              SizedBox(
                height: 20,
              ),
              getPremiumDetailsCard(),
              SizedBox(
                height: 20,
              ),
              getPolicyHoldersDetailsCard(),
              SizedBox(
                height: 20,
              ),
              getPolicyDocumentsCard(),
              if(policy.plan?.contains("HEALTH")==true || policy.plan?.contains("MOTOR")==true)
              GestureDetector(
                onTap: () {
                  if(policy.plan?.contains("HEALTH")==true) {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HealthClaimForm(in_id: policy.id??"")));
                  }
                  else {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MotorClaimForm(in_id: policy.id??"")));
                  }
                },
                child: Container(
                    width: MySize.size100(context),
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: MyColors.colorPrimary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: getLabel("CLAIM")
                ),
              )
            ],
          ),
        )
        : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  getLabelCard(String label) {
    return Container(
        width: MySize.size100(context),
        padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MyColors.colorPrimary,
        ),
        child: getLabel(label)
    );
  }

  getLabel(String label) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: MyColors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600
      ),
    );
  }

  getInfoDesign(String title, String info) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitle(title),
        getInfo(info)
      ],
    );
  }

  getInfoDocDesign(String title, String info) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitle(title),
        getInfoDoc(title, info)
      ],
    );
  }

  getTitle(String title) {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: MyColors.black,
            fontSize: 13,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  getInfo(String info) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Text(
        info,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: MyColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }

  getInfoDoc(String title, String info) {
    print(Environment.url1+info);
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => PDFViewer(url: Environment.url1+info,)));
        },
        child: Text(
          "View "+title,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: MyColors.colorDarkPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline
          ),
        ),
      ),
    );
  }

  getPolicyDetailsCard() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getLabelCard("Policy Details"),
          SizedBox(
            height: 10,
          ),
          getInfoDesign("Category", policy.category??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Plan Type", policy.plan??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Insurance Company", policy.companyName??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Plan Name", policy.planName??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Sum Assured", policy.sumAssured??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Risk Date", DateFormat("dd-MM-yyyy").format(DateTime.parse(policy.riskDate??""))),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Policy Term", policy.policyTerm??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Maturity Date", DateFormat("dd-MM-yyyy").format(DateTime.parse(policy.maturityDate??""))),
        ],
      ),
    );
  }

  getPremiumDetailsCard() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getLabelCard("Premium Details"),
          SizedBox(
            height: 10,
          ),
          getInfoDesign("Premium Amount", policy.amount??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Frequency", policy.frequency??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Premium Payment Mode", policy.paymentMode??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Payment Term", policy.paymentTerm??""),
        ],
      ),
    );
  }

  getPolicyHoldersDetailsCard() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getLabelCard("Premium Holders Details"),
          SizedBox(
            height: 10,
          ),
          getInfoDesign("Proposer", policy.proposerName??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Insured Person", holders[0].name??""),
          if(holders.length>1)
            SizedBox(
              height: 5,
            ),
          if(holders.length>1)
            ListView.separated(
              itemCount: holders.length-1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (BuildContext buildContext, index) {
                return SizedBox(
                  height: 5,
                );
              },
              itemBuilder: (BuildContext buildContext, index) {
                return getInfoDesign("", holders[index+1].name??"");
              },
            )
        ],
      ),
    );
  }

  getPolicyDocumentsCard() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getLabelCard("Policy Documents"),
          SizedBox(
            height: 10,
          ),
          getInfoDocDesign("Policy", policy.policyDoc??""),
          SizedBox(
            height: 15,
          ),
          getInfoDocDesign("Receipt", policy.receipt??""),
        ],
      ),
    );
  }

  Future<void> getPolicyDetails() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByID,
      "id" : widget.id,
    };

    PolicyDetailResponse policyDetailResponse = await APIService().getPolicyDetails(queryParameters);

    policy = policyDetailResponse.policy ?? Policy();
    holders = policyDetailResponse.holders ?? [];

    load = true;

    setState(() {

    });
  }
}
