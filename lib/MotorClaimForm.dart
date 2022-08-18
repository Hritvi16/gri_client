import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/AccountResponse.dart';
import 'package:gri_client/models/Response.dart';
import 'package:gri_client/models/PolicyResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:gri_client/toast/Toast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MotorClaimForm extends StatefulWidget {
  final String? in_id;
  const MotorClaimForm({Key? key, this.in_id}) : super(key: key);

  @override
  State<MotorClaimForm> createState() => _MotorClaimFormState();
}

class _MotorClaimFormState extends State<MotorClaimForm> {

  late SharedPreferences sharedPreferences;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController place = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController garage = TextEditingController();
  TextEditingController surveyor = TextEditingController();
  TextEditingController estimate = TextEditingController();
  TextEditingController remarks = TextEditingController();

  List<Account> accounts = [];
  List<String> accountsString = [];
  String? name;

  List<Policy> policies = [];
  List<String> policiesString = [];
  String? policy;

  DateTime accident = DateTime.now();

  @override
  void initState() {
    start();
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: Text(
            "MOTOR CLAIM",
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
        child: SingleChildScrollView(
          child: Form(
            key: formkey, 
            child: Column(
              children: [
                getClientDetails(),
                SizedBox(
                  height: 20,
                ),
                getCompanyDetails(),
                SizedBox(
                  height: 20,
                ),
                getVehicleDetails(),
                SizedBox(
                  height: 20,
                ),
                getAccidentDetails(),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      addMotorClaim();
                    }
                  },
                  child: Container(
                    width: MySize.size100(context),
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyColors.colorPrimary,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: getLabel("View")
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getMonthLabel(String label) {
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
  
  getClientDetails() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.colorPrimary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getMonthLabel("Client Details"),
          SizedBox(
            height: 10,
          ),
          getInfoDropdown("Name"),
          SizedBox(
            height: 15,
          ),
          getInfoDropdown("Policy No"),
        ],
      ),
    );
  }

  getCompanyDetails() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.colorPrimary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getMonthLabel("Company Details"),
          SizedBox(
            height: 10,
          ),
          getInfoDesign("Company", policy==null ? "" : policies[policiesString.indexOf(policy??"")].companyName??""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Product", policy==null ? "" : policies[policiesString.indexOf(policy??"")].planName??""),
        ],
      ),
    );
  }

  getVehicleDetails() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.colorPrimary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getMonthLabel("Vehicle Details"),
          SizedBox(
            height: 10,
          ),
          getInfoDesign("Registration No", ""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Manufacturing Year", ""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Model", ""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("IDV", ""),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Policy Start Date", policy==null ? "" : DateFormat("dd-MMM-yyyy").format(DateTime.parse(policies[policiesString.indexOf(policy??"")].riskDate??""))),
          SizedBox(
            height: 15,
          ),
          getInfoDesign("Policy End Date", policy==null ? "" : DateFormat("dd-MMM-yyyy").format(DateTime.parse(policies[policiesString.indexOf(policy??"")].maturityDate??""))),
        ],
      ),
    );
  }

  getAccidentDetails() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.colorPrimary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getMonthLabel("Accident Details"),
          SizedBox(
            height: 10,
          ),
          getInfoController("Place of Accident", place),
          SizedBox(
            height: 15,
          ),
          getInfoController("Address", address),
          SizedBox(
            height: 15,
          ),
          getInfoController("Garage/Workshop", garage),
          SizedBox(
            height: 15,
          ),
          getInfoController("Surveyor", surveyor),
          SizedBox(
            height: 15,
          ),
          getInfoController("Estimate Amount", estimate),
          SizedBox(
            height: 15,
          ),
          getInfoController("Remarks", remarks),
          SizedBox(
            height: 15,
          ),
          getInfoDate("Accident Date & Time", DateFormat("dd-MMM-yyyy").format(accident)),
        ],
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


  getInfoDropdown(String title) {
    return Row(
      children: [
        getTitle(title),
        title=="Name" ? getAccountDropdown() : getPolicyDropdown()
      ],
    );
  }

  getInfoController(String title, TextEditingController controller) {
    return Row(
      children: [
        getTitle(title),
        getController(title, controller)
      ],
    );
  }

  getInfoDate(String title, String info) {
    return Row(
      children: [
        getTitle(title),
        getAccidentDate(info)
      ],
    );
  }

  getTitle(String title) {
    return Flexible(
      flex: 1,
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

  getAccidentDate(String info) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year+30),
              ).then((value) {
                if(value!=null) {
                  accident = value;
                  setState(() {

                  });
                }
              });
            },
            child: Image.asset(
              "assets/claim/calendar.png",
              height: 30,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                info,
                style: TextStyle(
                    color: MyColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getAccountDropdown() {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          //disabledItemFn: (String s) => s.startsWith('A'),
          showSearchBox: true,
        ),
        items: accountsString,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Select",
          ),
        ),
        validator: (value) {
          String message = "";
          if (value==null) {
            return "* Required";
          }  else {
            return null;
          }

        },
        onChanged: (value) {
          name = value;
          setState(() {});

          if(widget.in_id==null)
            getPolicies();
        },
        selectedItem: name,
      ),
    );
  }

  getPolicyDropdown() {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          //disabledItemFn: (String s) => s.startsWith('A'),
          showSearchBox: true,
        ),
        items: policiesString,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Select",
          ),
        ),
        validator: (value) {
          String message = "";
          if (value==null) {
            return "* Required";
          }  else {
            return null;
          }

        },
        onChanged: (value) {
          policy = value;
          setState(() {});
        },
        selectedItem: policy,
      ),
    );
  }

  getController(String title, TextEditingController controller) {
    print(title);
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: TextFormField(
        controller: controller,
        keyboardType: title=="Estimate Amount" ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.colorPrimary
            )
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10)
        ),
        validator: (value) {
          String message = "";
          if (value!.isEmpty) {
            return "* Required";
          }  else {
            return null;
          }

        },
      ),
    );
  }

  getAccounts() async {
    Map<String,String> queryParameters = {
      APIConstant.act : widget.in_id!=null ? APIConstant.getByINID : APIConstant.getByAcc,
      "id" :widget.in_id ?? sharedPreferences.getString("id")??"",
    };

    AccountListResponse accountListResponse = await APIService().getAccounts(queryParameters);

    accounts = accountListResponse.accounts ?? [];

    accounts.forEach((element) {
      accountsString.add(element.name!);
    });

    setState(() {

    });

    if(widget.in_id!=null)
      getPolicies();
  }

  getPolicies() async {
    Map<String,String> queryParameters = {
      APIConstant.act : widget.in_id!=null ? APIConstant.getByINID : APIConstant.getByAcc,
      "id" : widget.in_id ?? accounts[accountsString.indexOf(name??"")].id??"",
      "claim" : "MOTOR"
    };

    print(queryParameters);

    PolicyResponse policyResponse = await APIService().getPolicies(queryParameters);

    policies = policyResponse.policy ?? [];
    policiesString = [];
    policy = null;

    policies.forEach((element) {
      policiesString.add(element.policyNumber!);
    });

    if(widget.in_id!=null) {
      name = accountsString[0];
      policy = policiesString[0];
    }

    setState(() {

    });
  }

  Future<void> addMotorClaim() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.addMotorClaim,
      "id" : sharedPreferences.getString("id")??"",
      "name" : accounts[accountsString.indexOf(name??"")].id??"",
      "policy" : policies[policiesString.indexOf(policy??"")].id??"",
      "place" : place.text,
      "address" : address.text,
      "garage" : garage.text,
      "accident" : accident.toString(),
      "surveyor" : surveyor.text,
      "estimate" : estimate.text,
      "remarks" : remarks.text,
    };

    print(queryParameters);

    Response response = await APIService().addClaim(queryParameters);


    if(response.message=="Motor Claim Added") {
      name = policy = null;
      accident = DateTime.now();
      place.text = address.text = garage.text =
      surveyor.text = estimate.text = remarks.text = "";

      setState(() {

      });
    }
    Toast.sendToast(context, response.message??"");

  }
}
