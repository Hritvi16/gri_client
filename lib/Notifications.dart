import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'NotificationDetails.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/api/Environment.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/NotificationResponse.dart' as n;
import 'package:gri_client/size/MySize.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  late SharedPreferences sharedPreferences;
  bool load = false;
  List<n.Notification> notifications = [];

  @override
  void initState() {
    start();
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.white,
        elevation: 0,
        title: Text(
          "Notifications",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: MyColors.colorPrimary
            )
        ),
      ),
      body: load ? notifications.isNotEmpty ? getNotificationList()
        : Center(
          child: Text(
            "No Notifications"
          ),
        )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getNotificationList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySize.size2(context), vertical: 10),
      child: ListView.separated(
        itemCount: notifications.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext buildContext, index) {
          return getNotificationCard(notifications[index]);
        },
        separatorBuilder: (BuildContext buildContext, index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }

  getNotificationCard(n.Notification notification) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    NotificationDetails(notification: notification)));
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: MySize.size2(context)),
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
            CachedNetworkImage(
              imageUrl: Environment.notificationUrl + (notification.image??""),
              errorWidget: (context, url, error) {
                return Image.asset(
                  "assets/dashboard/notification.png",
                  width: 100,
                  height: 80,
                );
              },
              width: 100,
              height: 80,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTitle(notification.title??""),
                  SizedBox(
                    height: 7,
                  ),
                  getData("Notifiation Date", DateFormat("dd-MMM-yyyy").format(DateTime.parse(notification.notiDate??""))),
                  SizedBox(
                    height: 7,
                  ),
                  getData("Date", DateFormat("dd-MMM-yyyy").format(DateTime.parse(notification.createdAt??""))),
                  SizedBox(
                    height: 7,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getData(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MySize.size35(context),
          child: getTitle(title+" : "),
        ),
        Expanded(
          child: getInfo(info),
        )
      ],
    );
  }

  getTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w600
      ),
    );
  }

  getInfo(String info) {
    return Text(info);
  }

  Future<void> getNotifications() async {

    n.NotificationResponse notificationResponse = await APIService().getNotifications();

    notifications = notificationResponse.notification ?? [];

    if(!load)
      load = true;

    setState(() {

    });
  }
}
