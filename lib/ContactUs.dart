import 'package:flutter/material.dart';
import 'package:gri_client/Essential.dart';
import 'package:gri_client/models/ContactUsResponse.dart' as cp;
import 'package:gri_client/size/MySize.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUs extends StatefulWidget {
  final cp.ContactUs contactUs;
  const ContactUs({Key? key, required this.contactUs}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MySize.size100(context),
        height: MySize.sizeh100(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: MySize.sizeh5(context)),
                child: Image.asset(
                  "assets/logo/logo.jpg",
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: getDesign("mobile.png", widget.contactUs.mobile??""),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: getDesign("email.png", widget.contactUs.email??""),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: getDesign("city.png", widget.contactUs.city??""),
            )
          ],
        ),
      ),
    );
  }

  getDesign(String icon, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
              print(icon.contains("mobile"));
              print(icon);
              if(icon.contains("mobile"))
                Essential().call(info);
              else if(icon.contains("email"))
                Essential().email(info);
              else
                Essential().link("https://www.google.com/search?q="+info);
            },
            child: Image.asset(
              "assets/contact_us/"+icon,
              height: MySize.sizeh5(context),
              width: MySize.sizeh5(context),
            ),
          ),
        ),
        SizedBox(
          height: MySize.sizeh3(context),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
              print(icon.contains("mobile"));
              if(icon.contains("mobile"))
                Essential().call(info);
              else if(icon.contains("email"))
                Essential().email(info);
              else
                Essential().link("https://www.google.com/search?q="+info);
            },
            child: Text(
              info,
            ),
          ),
        )
      ],
    );
  }
}
