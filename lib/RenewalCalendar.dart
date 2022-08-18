import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/CalendarRenewalResponse.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RenewalCalendar extends StatefulWidget {
  final DateTime date;
  const RenewalCalendar({Key? key, required this.date}) : super(key: key);

  @override
  State<RenewalCalendar> createState() => _RenewalCalendarState();
}

class _RenewalCalendarState extends State<RenewalCalendar> {
  String selectedCategory = "General";
  DateTime? currentDate;
  late DateTime selectedMonth;

  late SharedPreferences sharedPreferences;

  CalendarRenewal general = CalendarRenewal();
  CalendarRenewal life = CalendarRenewal();

  @override
  void initState() {
    start();
    selectedMonth = widget.date;
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getCalendarPolicy(APIConstant.getMonthRenewal, selectedMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: Text(
          "RENEWAL",
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
        child: SingleChildScrollView(
          child: Container(
            height: MySize.sizeh100(context),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    getCategoryDesign("General"),
                    SizedBox(
                      width: 10,
                    ),
                    getCategoryDesign("Life")
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                getCalendar(),
                SizedBox(
                  height: 15,
                ),
                getMonthLabel(),
                SizedBox(
                  height: 15,
                ),
                getRenewalsDesign(selectedCategory=='Life' ? life : general)
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCategoryDesign(String title) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          selectedCategory = title;
          setState(() {

          });
        },
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: selectedCategory==title ? BoxDecoration(
            border: Border.all(
              color: MyColors.colorSecondary,
            ),
            borderRadius: BorderRadius.circular(10)
          ) : null,
          child: Text(
            title+" Insurance",
            style: TextStyle(
              fontSize: 14,
              color: MyColors.colorPrimary,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
      ),
    );
  }

  getCalendar() {
    return Card(
      elevation: 2,
      shadowColor: MyColors.colorSecondary,
      surfaceTintColor: MyColors.colorSecondary,
      child: CalendarCarousel(
        height: 420,
        onDayPressed: (DateTime date, List<Event> events) {
          if(currentDate!=date) {
            currentDate = date;
            general = life = CalendarRenewal();
            setState(() {

            });
            getCalendarPolicy(APIConstant.getDateRenewal, date);
          }
        },
        selectedDateTime: currentDate,
        targetDateTime: selectedMonth,
        headerTextStyle: TextStyle(
            color: MyColors.colorPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 16
        ),
        iconColor: MyColors.colorLightPrimary,
        weekdayTextStyle: TextStyle(
            color: MyColors.colorSecondary,
            fontWeight: FontWeight.w600
        ),
        daysTextStyle: TextStyle(
            color: MyColors.colorPrimary,
            fontWeight: FontWeight.w600
        ),
        weekendTextStyle: TextStyle(
            color: MyColors.colorPrimary,
            fontWeight: FontWeight.w600
        ),
        daysHaveCircularBorder: true,
        showOnlyCurrentMonthDate: true,
        todayTextStyle: TextStyle(
          color: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)==currentDate ? MyColors.colorPrimary : MyColors.white
        ),
        todayButtonColor: MyColors.colorDarkPrimary,
        todayBorderColor: MyColors.colorDarkPrimary,
        selectedDayButtonColor: MyColors.colorPrimary.withOpacity(0.3),
        selectedDayBorderColor: MyColors.colorPrimary.withOpacity(0.3),
        onCalendarChanged: (value) {
          if(selectedMonth.month!=value.month) {
            selectedMonth = value;
            general = life = CalendarRenewal();
            setState(() {

            });
            print("selectedMonth");
            print(selectedMonth);
            getCalendarPolicy(APIConstant.getMonthRenewal, selectedMonth);
          }
        }
      ),
    );
  }

  getMonthLabel() {
    return Container(
      width: MySize.size100(context),
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: MyColors.colorPrimary,
          borderRadius: BorderRadius.circular(5)
      ),
      child: getLabel("Month  -  "+DateFormat(DateFormat.MONTH).format(selectedMonth))
    );
  }

  getRenewalsDesign(CalendarRenewal calendarRenewal) {
    return Column(
      children: [
        Container(
          width: MySize.size100(context),
          padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: MyColors.colorPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5)
              )
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: getLabel("NOP"),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: getLabel("Install\nPremium"),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: getLabel("Annual\nPremium"),
              ),
            ],
          ),
        ),
        Container(
          width: MySize.size100(context),
          padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
          alignment: Alignment.center,
          color: MyColors.colorLightSecondary.withOpacity(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getInfo(calendarRenewal.nop??"0"),
              getInfo(calendarRenewal.installPremium??"0"),
              getInfo(calendarRenewal.annualPremium??"0")
            ],
          ),
        ),
      ],
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

  getInfo(String label) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Future<void> getCalendarPolicy(String act, DateTime dateTime) async {
    Map<String,String> queryParameters = {
      APIConstant.act : act,
      "id" : sharedPreferences.getString("id")??"",
      "date" : DateFormat("yyyy-MM-dd").format(dateTime),
    };

    print(queryParameters);

    CalendarRenewalResponse calendarRenewalResponse = await APIService().getCalendarRenewals(queryParameters);

    print(calendarRenewalResponse.toJson());

    calendarRenewalResponse.calendarRenewal?.forEach((element) {
      if(element.category=='LIFE')
        life = element;
      else
        general = element;
    });

    setState(() {

    });


  }
}
