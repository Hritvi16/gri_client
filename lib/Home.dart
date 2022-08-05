import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/size/MySize.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool load = true;
  DateTime refresh = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: MyColors.generateMaterialColor(MyColors.colorPrimary),
          dividerColor: Colors.transparent,
          textTheme: GoogleFonts.latoTextTheme()
      ),
      home: load ? DefaultTabController(
          length: 2,
          child: Scaffold(
              backgroundColor: MyColors.white,
              appBar: AppBar(
                title: Row(
                  children: [
                    Container(
                      color: MyColors.white,
                      margin: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        "assets/logo/logo.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                    Text(
                      "Client Desk",
                    ),
                  ],
                ),
                leading: GestureDetector(
                  onTap: () {
                  },
                  child: Icon(
                      Icons.menu
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Icons.notifications
                    ),
                  )
                ],
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      color: MyColors.grey10,
                      child: TabBar(
                        labelColor: MyColors.colorPrimary,
                        indicatorColor: MyColors.colorPrimary,
                        unselectedLabelColor: MyColors.black,
                        labelStyle: TextStyle(
                          fontSize: 14
                        ),
                        tabs: [
                          Tab(
                            text:"Networth Report",
                          ),
                          Tab(
                            text: "Family Needs Report",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          getNRBody(),
                          getNRBody()
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getNRBody() {
    return Container(
      height: MySize.sizeh100(context),
      color: MyColors.white,
      child: Column(
        children: [
          Text(
            "Last Updated on : "
          )
        ],
      ),
    );
  }
}
