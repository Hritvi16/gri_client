import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gri_client/Home.dart';
import 'package:gri_client/Renewals.dart';
import 'package:gri_client/Settings.dart';
import 'package:gri_client/colors/MyColors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Widget> screens = [
    Home(),
    Renewals(),
    Settings()
  ];

  List<Widget> items = [
    Icon(
      Icons.home,
      color: MyColors.colorSecondary,
    ),
    Icon(
      Icons.calendar_month,
      color: MyColors.colorSecondary,
    ),
    Icon(
      Icons.settings,
      color: MyColors.colorSecondary,
    ),
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: MyColors.colorPrimary,
        height: 85,
        child: CurvedNavigationBar(
          backgroundColor: MyColors.colorPrimary,
          height: 75,
          items: items,
          onTap: (index) {
            this.index = index;
            setState(() {

            });
          },
        ),
      ),
      body: screens[index],
    );
  }
}
