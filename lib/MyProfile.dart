import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gri_client/FamilyMember.dart';
import 'package:gri_client/ImageViewer.dart';
import 'package:gri_client/PDFViewer.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/api/Environment.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/AccountResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  bool load = false;
  late SharedPreferences sharedPreferences;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Account account = Account();
  List<Account> family = [];

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  DateTime? dob;
  DateTime? anniversary;

  @override
  void initState() {
    start();
    super.initState();
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
            "MY PROFILE",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: MyColors.colorPrimary
            )
        ),
      ),
      body: load ? SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundColor: MyColors.colorPrimary,
                  radius: 71,
                  child: CircleAvatar(
                    foregroundColor: Colors.transparent,
                    radius: 70,
                    child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: Environment.accountUrl + (account.image??""),
                          errorWidget: (context, url, error) {
                            return ClipOval(
                              child: Icon(
                                Icons.account_circle,
                                size: 120,
                              ),
                            );
                          },
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              getGeneralDetails(),
              SizedBox(
                height: 20,
              ),
              getSpecialDates(),
              SizedBox(
                height: 20,
              ),
              getProofs(),
              SizedBox(
                height: 20,
              ),
              getFamilyMembers(),
            ],
          ),
        ),
      )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getCardLabel(String label) {
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
        title=="Date of Birth" ? getBirthDate(info) : getAnniversaryDate(info)
      ],
    );
  }

  getBirthDate(String info) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now(),
              //   firstDate: DateTime.now(),
              //   lastDate: DateTime(DateTime.now().year+30),
              // ).then((value) {
              //   if(value!=null) {
              //     dob = value;
              //     setState(() {
              //
              //     });
              //   }
              // });
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

  getAnniversaryDate(String info) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now(),
              //   firstDate: DateTime.now(),
              //   lastDate: DateTime(DateTime.now().year+30),
              // ).then((value) {
              //   if(value!=null) {
              //     anniversary = value;
              //     setState(() {
              //
              //     });
              //   }
              // });
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

  getInfoImageDesign(String title, String info) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitle(title),
        getInfoImage(title, info)
      ],
    );
  }

  getInfoViewDesign(Account account) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitle(account.name??""),
        getInfoView(account.id??"")
      ],
    );
  }

  getInfoImage(String title, String info) {
    print(Environment.proofUrl+info);
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => ImageViewer(url: Environment.proofUrl+info,)));
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

  getInfoView(String id) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => FamilyMember(id: id, act: APIConstant.update)));
        },
        child: Text(
          "View Details",
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

  getController(String title, TextEditingController controller) {
    print(title);
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: TextFormField(
        controller: controller,
        enabled: false,
        readOnly: true,
        keyboardType: title=="Phone" ? TextInputType.phone : title=="Phone" ?  TextInputType.emailAddress : TextInputType.text,
        inputFormatters: [
          if(title=="Phone")
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

  getGeneralDetails() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getCardLabel("General Details"),
          SizedBox(
            height: 10,
          ),
          getInfoController("Name", name),
          SizedBox(
            height: 15,
          ),
          getInfoController("Email", email),
          SizedBox(
            height: 15,
          ),
          getInfoController("Phone", phone),
        ],
      ),
    );
  }

  getSpecialDates() {
    print(dob);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getCardLabel("Special Dates"),
          SizedBox(
            height: 10,
          ),
          getInfoDate("Date of Birth", dob!=null ? DateFormat("dd-MMM-yyyy").format(dob??DateTime.now()) : "No Date"),
          SizedBox(
            height: 15,
          ),
          getInfoDate("Anniversary Date", anniversary!=null ? DateFormat("dd-MMM-yyyy").format(anniversary??DateTime.now()) : "No Date"),
        ],
      ),
    );
  }

  getProofs() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getCardLabel("Proofs"),
          SizedBox(
            height: 10,
          ),
          getInfoImageDesign(account.proofType1??"", account.proofId1??""),
          if(account.proofId2!=null)
            SizedBox(
              height: 15,
            ),
          if(account.proofId2!=null)
            getInfoImageDesign(account.proofType2??"", account.proofId2??""),
        ],
      ),
    );
  }

  getFamilyMembers() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getCardLabel("Family Members"),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
            itemCount: family.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext buildContext, index) {
              return getInfoViewDesign(family[index]);
            },
            separatorBuilder: (BuildContext buildContext, index) {
              return SizedBox(
                height: 10,
              );
            },
          )
        ],
      ),
    );
  }

  getProfile() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByID,
      "id" : sharedPreferences.getString("id")??"",
    };
    print(queryParameters);

    AccountResponse accountResponse = await APIService().getProfile(queryParameters);
    print(accountResponse.toJson());

    account = accountResponse.account ?? Account();
    family = accountResponse.family ?? [];

    setState(() {

    });

    setData();

  }

  void setData() {

    name.text = account.name??"";
    email.text = account.email??"";
    phone.text = account.phone??"";
    print(account.dob??"");
    dob = account.dob!=null ? DateTime.parse(account.dob??"") : null;
    anniversary = account.anniversary!=null ? DateTime.parse(account.anniversary??"") : null;

    load = true;

  }
}
