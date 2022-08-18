import 'package:flutter/material.dart';
import 'package:gri_client/Essential.dart';
import 'package:gri_client/FamilyMembers.dart';
import 'package:gri_client/Login.dart';
import 'package:gri_client/LoginPopUp.dart';
import 'package:gri_client/MyProfile.dart';
import 'package:gri_client/TollFreeList.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/ContactUsResponse.dart';
import 'package:gri_client/ContactUs.dart' as cp;
import 'package:gri_client/size/MySize.dart';
import 'package:gri_client/toast/InsuranceForm.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool load = false;
  ContactUs contactUs = ContactUs();
  @override
  void initState() {
    getContactUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.white,
        elevation: 0,
        title: Text(
            "GRASS ROOT INVESTORS",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: MyColors.colorPrimary
            )
        ),
      ),
      body: load ? SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MySize.size100(context),
              height: 150,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: MyColors.grey10
                  )
                )
              ),
              child: Image.asset(
                "assets/logo/logo.jpg",
              ),
            ),
            getInfo(contactUs.mobile??"", "mobile"),
            SizedBox(
              height: 5,
            ),
            getInfo(contactUs.email??"", "email"),
            SizedBox(
              height: 20,
            ),
            getSettingsCard("myprofile.png", "My Profile"),
            getSettingsCard("family.png", "Family Members"),
            getSettingsCard("family.png", "Insurance Form"),
            getSettingsCard("tollfree.png", "Use Toll Free Numbers"),
            getSettingsCard("contactus.png", "Contact Us"),
            getSettingsCard("share.png", "Share App"),
            getSettingsCard("update.png", "Update App"),
            getSettingsCard("logout.png", "Logout")
          ],
        ),
      )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getInfo(String info, String label) {
    return GestureDetector(
      onTap: () {
        if(label=="mobile")
          Essential().call(info);
        else
          Essential().email(info);
      },
      child: Text(
        info,
        style: TextStyle(
          color: MyColors.colorLightPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  getSettingsCard(String icon, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: MySize.size10(context)),
      child: GestureDetector(
        onTap: () {
          if(title=="My Profile") {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MyProfile()));
          }
          if(title=="Family Members") {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        FamilyMembers()));
          }
          if(title=="Insurance Form") {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        InsuranceForm()));
          }
          if(title=="Use Toll Free Numbers") {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        TollFreeList()));
          }
          else if(title=="Contact Us") {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                    cp.ContactUs(contactUs: contactUs,)));
          }
          else if(title=="Share App") {
            Share.share("https://play.google.com/store/apps/details?id=com.spotify.music", subject: 'Hey, looking for an app to manage your insurance?\n Here it is!');
          }
          else if(title=="Update App") {
            launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.spotify.music"));
          }
          else if(title=="Logout") {
            loginPopUp();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/settings/"+icon,
                  height: 25,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: MyColors.colorPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getContactUs() async {
    ContactUsResponse contactUsResponse = await APIService().getContactUs();

    contactUs = contactUsResponse.contactUs ?? ContactUs();

    load = true;

    setState(() {

    });
  }

  loginPopUp() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return LoginPopUp(
          text: "Are you sure you want to logout?",
          btn1 : "Cancel",
          btn2: "Logout",
        );
      },
    ).then((value) {
      if(value=="Logout")
        logout();
    });
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("id", "");
    sharedPreferences.setString("name", "");
    sharedPreferences.setString("mobile", "");
    sharedPreferences.setString("status", "logged out");


    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => const Login()),
            (Route<dynamic> route) => false);
  }
}
