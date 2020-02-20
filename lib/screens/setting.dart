import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf_reader/utils/config.dart';
import 'package:pdf_reader/utils/share_pre.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  ConFig _conFig = ConFig();
  //  ConFig _conFig = ConFig();

  // if (con != null) {
  //       _conFig = con;
  //       print(con.toString());
  //     } else {
  //       _conFig.nightMode = false;
  //       _conFig.swipeHorizontal = false;
  //       _conFig.autoSpacing = false;
  //       _conFig.pageFling = false;
  //       _conFig.pageSnap = false;
  //       _conFig.enableImmersive = false;
  //       _conFig.autoPlay = false;
  //       _conFig.forceLandscape = false;
  //       _conFig.slideShow = false;
  //     }
  SharedPreferencesUtils sharePre = SharedPreferencesUtils();

  loadSharePre() async {
    ConFig con = await sharePre.getConfig("con");
    setState(() {
      _conFig = con;
    });
  }

  @override
  void initState() {
    loadSharePre();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8,
          left: 30,
          right: 30,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Night mode",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: _conFig.nightMode
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        )
                      : Icon(
                          Icons.check_circle_outline,
                          color: Colors.blueAccent,
                        ),
                  onPressed: () async {
                    setState(() {
                      _conFig.nightMode = !_conFig.nightMode;
                      sharePre.setConfig("con", _conFig);
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Swipe horizontal",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: _conFig.swipeHorizontal
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        )
                      : Icon(
                          Icons.check_circle_outline,
                          color: Colors.blueAccent,
                        ),
                  onPressed: () {
                    setState(() {
                      _conFig.swipeHorizontal = !_conFig.swipeHorizontal;
                      // _conFigswipeHorizontal = _conFig.swipeHorizontal;
                    });
                    sharePre.setConfig("con", _conFig);
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Auto spacing",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    icon: _conFig.autoSpacing
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.blueAccent,
                          )
                        : Icon(
                            Icons.check_circle_outline,
                            color: Colors.blueAccent,
                          ),
                    onPressed: () {
                      setState(() {
                        _conFig.autoSpacing = !_conFig.autoSpacing;
                        // _conFigautoSpacing = _conFig.autoSpacing;
                      });
                      sharePre.setConfig("con", _conFig);
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Page fling",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: _conFig.pageFling
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        )
                      : Icon(
                          Icons.check_circle_outline,
                          color: Colors.blueAccent,
                        ),
                  onPressed: () {
                    setState(() {
                      _conFig.pageFling = !_conFig.pageFling;
                      // _conFigpageFling = _conFig.pageFling;
                    });
                    sharePre.setConfig("con", _conFig);
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Page snap",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: _conFig.pageSnap
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        )
                      : Icon(
                          Icons.check_circle_outline,
                          color: Colors.blueAccent,
                        ),
                  onPressed: () {
                    setState(() {
                      _conFig.pageSnap = !_conFig.pageSnap;
                      // _conFigpageSnap = _conFig.pageSnap;
                    });
                    sharePre.setConfig("con", _conFig);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Enable immersive",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: _conFig.enableImmersive
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        )
                      : Icon(
                          Icons.check_circle_outline,
                          color: Colors.blueAccent,
                        ),
                  onPressed: () {
                    setState(() {
                      _conFig.enableImmersive = !_conFig.enableImmersive;
                      // _conFigenableImmersive = _conFig.enableImmersive;
                    });
                    sharePre.setConfig("con", _conFig);
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Auto play",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: _conFig.autoPlay
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        )
                      : Icon(
                          Icons.check_circle_outline,
                          color: Colors.blueAccent,
                        ),
                  onPressed: () {
                    setState(() {
                      _conFig.autoPlay = !_conFig.autoPlay;
                      // _conFigautoPlay = _conFig.autoPlay;
                    });
                    sharePre.setConfig("con", _conFig);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Slide show",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: _conFig.slideShow
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        )
                      : Icon(
                          Icons.check_circle_outline,
                          color: Colors.blueAccent,
                        ),
                  onPressed: () {
                    setState(() {
                      _conFig.slideShow = !_conFig.slideShow;
                      // _conFigslideShow = _conFig.slideShow;
                    });
                    sharePre.setConfig("con", _conFig);
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Force landscape",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: _conFig.forceLandscape
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        )
                      : Icon(
                          Icons.check_circle_outline,
                          color: Colors.blueAccent,
                        ),
                  onPressed: () {
                    setState(() {
                      _conFig.forceLandscape = !_conFig.forceLandscape;
                      // _conFigforceLandscape = _conFig.forceLandscape;
                    });
                    sharePre.setConfig("con", _conFig);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
