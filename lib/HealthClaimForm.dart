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

class HealthClaimForm extends StatefulWidget {
  final String? in_id;
  const HealthClaimForm({Key? key, this.in_id}) : super(key: key);

  @override
  State<HealthClaimForm> createState() => _HealthClaimFormState();
}

class _HealthClaimFormState extends State<HealthClaimForm> {

  late SharedPreferences sharedPreferences;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController patient = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController photo_id = TextEditingController();
  TextEditingController hospital = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController doctor = TextEditingController();
  TextEditingController disease = TextEditingController();
  TextEditingController room = TextEditingController();
  TextEditingController remarks = TextEditingController();

  List<Account> accounts = [];
  List<String> accountsString = [];
  String? name;

  List<Policy> policies = [];
  List<String> policiesString = [];
  String? policy;

  DateTime claim_date = DateTime.now();
  DateTime admission = DateTime.now();

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
            "HEALTH CLAIM",
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
                getPatientDetails(),
                SizedBox(
                  height: 20,
                ),
                getHospitalDetails(),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      addHealthClaim();
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

  getPatientDetails() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.colorPrimary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getMonthLabel("Patient Details"),
          SizedBox(
            height: 10,
          ),
          getInfoController("Name", patient),
          SizedBox(
            height: 15,
          ),
          getInfoController("Age", age),
          SizedBox(
            height: 15,
          ),
          getInfoDate("Claim Date", DateFormat("dd-MMM-yyyy").format(claim_date)),
          SizedBox(
            height: 15,
          ),
          getInfoController("Photo Id", photo_id),
        ],
      ),
    );
  }

  getHospitalDetails() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.colorPrimary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getMonthLabel("Hospital Details"),
          SizedBox(
            height: 10,
          ),
          getInfoController("Name", hospital),
          SizedBox(
            height: 15,
          ),
          getInfoController("Address", address),
          SizedBox(
            height: 15,
          ),
          getInfoController("Contact No", contact),
          SizedBox(
            height: 15,
          ),
          getInfoDate("Admission Date & Time", DateFormat("dd-MMM-yyyy").format(admission)),
          SizedBox(
            height: 15,
          ),
          getInfoController("Dr. Name", doctor),
          SizedBox(
            height: 15,
          ),
          getInfoController("Type of Diseases", disease),
          SizedBox(
            height: 15,
          ),
          getInfoController("Room Category", room),
          SizedBox(
            height: 15,
          ),
          getInfoController("Remarks", remarks),
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
        title=="Claim Date" ? getClaimDate(info) : getAdmissionDate(info)
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

  getClaimDate(String info) {
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
                  claim_date = value;
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

  getAdmissionDate(String info) {
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
                  admission = value;
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
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: TextFormField(
        controller: controller,
        maxLength: title=="Age" ? 3 : title=="Contact No" ? 12 : null,
        keyboardType: title=="Age" ? TextInputType.number : title=="Contact No" ? TextInputType.phone : TextInputType.text,
        inputFormatters: [
          if(title=="Age" || title=="Contact No")
            FilteringTextInputFormatter.digitsOnly
        ],
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
      "claim" : "HEALTH"
    };


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

  Future<void> addHealthClaim() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.addHealthClaim,
      "id" : sharedPreferences.getString("id")??"",
      "name" : accounts[accountsString.indexOf(name??"")].id??"",
      "policy" : policies[policiesString.indexOf(policy??"")].id??"",
      "patient" : patient.text,
      "age" : age.text,
      "claim_date" : claim_date.toString(),
      "photo_id" : photo_id.text,
      "hospital" : hospital.text,
      "address" : address.text,
      "contact" : contact.text,
      "admission" : admission.toString(),
      "doctor" : doctor.text,
      "disease" : disease.text,
      "room" : room.text,
      "remarks" : remarks.text,
    };


    Response response = await APIService().addClaim(queryParameters);


    if(response.message=="Health Claim Added") {
      name = policy = null;
      claim_date = admission = DateTime.now();
      patient.text = age.text = photo_id.text = hospital.text = address.text = contact.text =
      doctor.text = disease.text = room.text = remarks.text = "";

      setState(() {

      });
    }
    Toast.sendToast(context, response.message??"");

  }
}
