import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gri_client/api/Environment.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/photoView/PhotoView.dart';
import 'models/NotificationResponse.dart' as n;

class NotificationDetails extends StatefulWidget {
  final n.Notification notification;
  const NotificationDetails({Key? key, required this.notification}) : super(key: key);

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {

  late n.Notification notification;
  @override
  void initState() {
    notification = widget.notification;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhotoView(
                              images: [notification.image??""],
                            )));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: Environment.notificationUrl + (notification.image??""),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          "assets/dashboard/notification.png",
                          height: 50,
                          width: 50,
                        );
                      },
                    )
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                getDetailCard1(),
                SizedBox(
                  height: 20,
                ),
                getDetailCard2(),
                SizedBox(
                  height: 20,
                ),
                getDetailCard3()
              ],
            ),
          ),
        ),
      )
    );
  }

  getDetailCard1() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Text(
          (notification.title??"").trim(),
          style: TextStyle(
              color: MyColors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20
          ),
          overflow: TextOverflow.ellipsis,
        )
    );
  }

  getDetailCard2() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextDesign("Notification Date: ", (notification.notiDate??"").trim()),
            SizedBox(
              height: 10,
            ),
            getTextDesign("Posted Date: ", (notification.createdAt??"").trim().substring(0, (notification.createdAt??"").trim().indexOf(" ")),),
          ],
        )
    );
  }


  getDetailCard3() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Text(
          (notification.message??"").trim(),
          // overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: MyColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16
          ),
        ),
    );
  }


  getTextDesign(String title, String data) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          text: title,
          style: TextStyle(
            color: MyColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18
          ),
          children: [
            TextSpan(
              text: data,
              style: TextStyle(
                  fontWeight: FontWeight.w400
              ),
            )
          ]
      ),
    );
  }
}
