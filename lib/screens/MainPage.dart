import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:pdf_reader/constants/constants.dart';
import 'package:pdf_reader/screens/All.dart';
import 'package:pdf_reader/screens/Recently.dart';
import 'package:pdf_reader/screens/setting.dart';
import 'package:pdf_reader/utils/native.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  void _showSetting() {
    slideDialog.showSlideDialog(
      context: context,
      child: Setting(),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.red,
      backgroundColor: Colors.white,
    );
  }

  @override
  void initState() {
    platform.invokeListMethod("rate");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(52, 170, 235, 1),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "PDF Reader",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showSetting();
                },
                child: Image.asset("assets/images/setting.gif"),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "All"),
              Tab(text: "Recently"),
            ],
          ),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue[50],
          ),
          child: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: null,
                  accountEmail: null,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/banner.png"),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await FlutterShare.share(
                      title: "Share app",
                      linkUrl: LINK_APP,
                    );
                  },
                  leading: Icon(
                    Icons.share,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    "Share",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    platform.invokeListMethod("rate");
                  },
                  leading: Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.yellow,
                  ),
                  title: Text(
                    "Rate",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            All(),
            Recently(),
          ],
        ),
      ),
    );
  }
}
