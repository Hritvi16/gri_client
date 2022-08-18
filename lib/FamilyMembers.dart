import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gri_client/FamilyMember.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/api/Environment.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/AccountResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FamilyMembers extends StatefulWidget {
  const FamilyMembers({Key? key}) : super(key: key);

  @override
  State<FamilyMembers> createState() => _FamilyMembersState();
}

class _FamilyMembersState extends State<FamilyMembers> {
  late SharedPreferences sharedPreferences;
  bool load = false;
  List<Account> family = [];

  @override
  void initState() {
    start();
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getFamilyMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: Text(
            "FAMILY MEMBERS",
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
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          "assets/settings/family.png",
        ),
        onPressed: () {

          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => FamilyMember(id:sharedPreferences.getString("id")??"", act: APIConstant.add))).then((value) {
            getFamilyMembers();
          });
        },
      ),
      body: SafeArea(
          child: load ? family.isNotEmpty ? getFamilyList()
              : Center(
            child: Text(
                "No Family Members"
            ),
          )
              : Center(
            child: CircularProgressIndicator(),
          )
      ),
    );
  }

  getFamilyList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySize.size2(context), vertical: 10),
      child: ListView.separated(
        itemCount: family.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext buildContext, index) {
          return getFamilyCard(family[index]);
        },
        separatorBuilder: (BuildContext buildContext, index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }

  getFamilyCard(Account account) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => FamilyMember(id: account.id??"", act: APIConstant.update))).then((value) {
          getFamilyMembers();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: MySize.size2(context)),
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
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: MyColors.colorPrimary,
                radius: 41,
                child: CircleAvatar(
                  foregroundColor: Colors.transparent,
                  radius: 40,
                  child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: Environment.accountUrl + (account.image??""),
                        errorWidget: (context, url, error) {
                          return ClipOval(
                            child: Icon(
                              Icons.account_circle,
                              size: 90,
                            ),
                          );
                        },
                      )
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getInfo(account.name??""),
                  SizedBox(
                    height: 10,
                  ),
                  getData("Relation", account.relation??""),
                  SizedBox(
                    height: 10,
                  ),
                  getData("Mobile", account.phone??""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getInfo(String info) {
    return Text(
      info,
      style: TextStyle(
          fontWeight: FontWeight.w600
      ),);
  }

  getData(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            title+" : ",
            style: TextStyle(
                fontWeight: FontWeight.w600
            ),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(info),
        )
      ],
    );
  }

  getFamilyMembers() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByID,
      "id" : sharedPreferences.getString("id")??"",
    };
    print(queryParameters);

    AccountResponse accountResponse = await APIService().getProfile(queryParameters);
    print(accountResponse.toJson());

    family = accountResponse.family ?? [];
    load = true;

    setState(() {

    });

  }

}
