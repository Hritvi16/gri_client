import 'package:flutter/material.dart';
import 'package:gri_client/Home.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/LoginResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:gri_client/toast/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mobile = TextEditingController();
  bool ignore = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      "assets/logo/logo.png",
                      height: 120,
                      width: 120
                  ),
                  SizedBox(
                    height: MySize.size10(context),
                  ),
                  Text(
                      "Green Root Investors",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          foreground: Paint()..shader = LinearGradient(
                            colors: <Color>[
                              MyColors.colorDarkPrimary,
                              MyColors.colorDarkSecondary,
                            ],
                          ).createShader(Rect.fromLTWH(0.0, 0.0, MediaQuery.of(context).size.width, 100.0))
                      )
                  ),
                  SizedBox(
                    height: MySize.sizeh5(context),
                  ),
                  Text(
                    "Client Panel Login",
                      style: TextStyle(
                        fontSize: 22,
                        color: MyColors.colorDarkSecondary
                      )
                  ),
                  SizedBox(
                    height: MySize.sizeh15(context),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: mobile,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Mobile No.",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  IgnorePointer(
                    ignoring: ignore,
                    child: SizedBox(
                      height: 45,
                      width: 120,
                      child: ElevatedButton(
                          onPressed: () {
                            if (mobile.text.length==10) {
                              print("Validated");

                              ignore = true;
                              setState(() {

                              });
                              login();
                            } else {
                              print("Not Validated");
                            }
                          },
                          child: const Text("Login")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  start() async {
   sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> login() async {
    Map<String, dynamic> data = new Map();
    data['mobile'] = mobile.text;
    data.addAll({APIConstant.act : APIConstant.login});
    LoginResponse loginResponse = await APIService().login(data);
    print(data);
    print(loginResponse.toJson());

    ignore = false;
    setState(() {

    });
    Toast.sendToast(context, loginResponse.message??"");

    if(loginResponse.status=="Success" && loginResponse.message=="Logged In") {
      sharedPreferences.setString("id", loginResponse.account?.id??"");
      sharedPreferences.setString("name", loginResponse.account?.name??"");
      sharedPreferences.setString("mobile", mobile.text);
      sharedPreferences.setString("status", "logged in");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const Home()),
              (Route<dynamic> route) => false);
    }
  }
}
