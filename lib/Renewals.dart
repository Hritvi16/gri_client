import 'package:flutter/material.dart';
import 'package:gri_client/Policies.dart';
import 'package:gri_client/RenewalCalendar.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/RenewalResponse.dart' as rr;
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Renewals extends StatefulWidget {
  const Renewals({Key? key}) : super(key: key);

  @override
  State<Renewals> createState() => _RenewalsState();
}

class _RenewalsState extends State<Renewals> {
  
  late SharedPreferences sharedPreferences;
  bool load = false;
  List<rr.Renewals> renewals = [];
  List<DateTime> dates = [];
  List<String> gen = [];
  List<String> life = [];
  DateTime now = DateTime.now();

  @override
  void initState() {
    start();
    super.initState();
  }
  
  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    for(int i=0; i<12; i++) {
      dates.add(DateTime(now.year, now.month+i));
      life.add("0");
      gen.add("0");
    }
    setState(() {

    });
    getRenewals();
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
          "MY RENEWALS DUE",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: MyColors.colorPrimary
            )
        ),
      ),
      body: load ? Container(
        width: MySize.size100(context),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: MyColors.grey10
            )
          )
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: dates.length,
          itemBuilder: (BuildContext context, index) {
            if(index%2==0)
              return getDatesRow(index, index+1);
            else
              return Container();
          },
        ),
      )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getDatesRow(int ind1, int ind2) {
    return Row(
      children: [
        getDatesCard(dates[ind1], gen[ind1], life[ind1]),
        getDatesCard(dates[ind2], gen[ind2], life[ind2])
      ],
    );
  }

  getDatesCard(DateTime d, String gen, String life) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => RenewalCalendar(date: d)));
          // Navigator.of(context).push(
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => Policies(act: APIConstant.getByDate, data: "", date: d)));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20, right: 5, left: 5),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          alignment: Alignment.center,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  DateFormat("MMM - yyyy").format(d),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: MyColors.colorPrimary
                  )
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
               "General - "+gen,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: MyColors.colorSecondary
                )
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Life - "+life,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: MyColors.colorSecondary
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  getRenewals() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getRenewal,
      "id" : sharedPreferences.getString("id")??"",
      "start" : DateFormat("yyyy-MM-dd").format(DateTime(dates[0].year, dates[0].month, 1)),
      "end" : DateFormat("yyyy-MM-dd").format(DateTime(dates[11].year, dates[11].month+1).subtract(Duration(days: 1)))
    };

    rr.RenewalResponse renewalResponse = await APIService().getRenewals(queryParameters);

    renewals = renewalResponse.renewals ?? [];

    int j = 0;
    // DateTime date = dates[j];

    for(int i=0; i< renewals.length; i++) {
      if (dates[j] == DateTime(int.parse(renewals[i].year ?? "0"), int.parse(renewals[i].month ?? "0"))) {
        if (renewals[i].category == 'LIFE') {
          life[j] = renewals[i].total ?? "0";
        }
        else {
          gen[j] = renewals[i].total ?? "0";
        }
      }

      while(i<renewals.length-1 && dates[j].month!=int.parse(renewals[i+1].month??"0")) {
        j++;
      }
    }

    load = true;

    setState(() {

    });
  }
}
