import 'package:flutter/material.dart';
import 'package:gri_client/Essential.dart';
import 'package:gri_client/PolicyDetail.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/PolicyResponse.dart';
import 'package:gri_client/models/TollFreeResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TollFreeList extends StatefulWidget {
  const TollFreeList({Key? key}) : super(key: key);

  @override
  State<TollFreeList> createState() => _TollFreeListState();
}

class _TollFreeListState extends State<TollFreeList> {

  late SharedPreferences sharedPreferences;
  bool load = false;
  List<TollFree> tollfrees = [];

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
      appBar: AppBar(
        title: Text(
            "TOLL FREE",
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
      body: SafeArea(
        child: load ? tollfrees.isNotEmpty ? getTollFreeList()
          : Center(
            child: Text(
              "No Toll Free Numbers"
            ),
          )
        : Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
  
  getTollFreeList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySize.size2(context), vertical: 10),
      child: ListView.separated(
        itemCount: tollfrees.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext buildContext, index) {
          return getTollFreeCard(tollfrees[index]);
        },
        separatorBuilder: (BuildContext buildContext, index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }

  getTollFreeCard(TollFree tollfree) {
    return Container(
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
      child: Column(
        children: [
          getData("Company", tollfree.company??"", "name"),
          SizedBox(
            height: 10,
          ),
          getData(tollfree.tag1??"", tollfree.mobile1??"", "mobile"),
          if(tollfree.mobile2!=null)
            SizedBox(
              height: 10,
            ),
          if(tollfree.mobile2!=null)
            getData(tollfree.tag2??"", tollfree.mobile2??"", "mobile"),
          if(tollfree.mobile3!=null)
            SizedBox(
              height: 10,
            ),
          if(tollfree.mobile3!=null)
            getData(tollfree.tag3??"", tollfree.mobile3??"", "mobile"),
        ],
      ),
    );
  }

  getData(String title, String info, String label) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(info),
              if(label=="mobile")
                GestureDetector(
                  onTap: () {
                    Essential().call(info);
                  },
                  child: Image.asset(
                    "assets/tollfree/call.png",
                    height: 20,
                  ),
                )
            ],
          ),
        )
      ],
    );
  }

  Future<void> getPolicies() async {
    TollFreeResponse tollFreeResponse = await APIService().getTollFree();

    tollfrees = tollFreeResponse.tollfree ?? [];

    if(!load)
      load = true;

    setState(() {

    });
  }
}
