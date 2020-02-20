import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:pdf_reader/utils/config.dart';
import 'package:pdf_reader/utils/native.dart';
import 'package:pdf_reader/utils/share_pre.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recently extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Recently();
  }
}

String getname(String s) {
  String res;
  int index = s.lastIndexOf("/");
  res = s.substring(index + 1);
  return res;
}

class _Recently extends State<Recently> {
  SharedPreferencesUtils sharePre = SharedPreferencesUtils();

  _readFile(String path) async {
    ConFig _conFig = await sharePre.getConfig("con");
    PdfViewer.loadFile(
      path,
      config: PdfViewerConfig(
        nightMode: _conFig.nightMode,
        swipeHorizontal: _conFig.swipeHorizontal,
        autoSpacing: _conFig.autoSpacing,
        pageFling: _conFig.pageFling,
        pageSnap: _conFig.pageSnap,
        enableImmersive: _conFig.enableImmersive,
        autoPlay: _conFig.autoPlay,
        forceLandscape: _conFig.forceLandscape,
        slideShow: _conFig.slideShow,
        initialPage: null,
        atExit: (pageIndex) {
          print(">> atExit($pageIndex)");
        },
      ),
    );
  }

  int i = 0;
  List<File> _listThum = [];

  void loadThum(String path) {
    if (i < _listRecently.length) {
      platform.invokeMethod('getThum', {"filePath": path}).then((path) {
        if (i == _listRecently.length - 1) {
          setState(() {
            _listThum.add(File(path));
          });
        } else {
          _listThum.add(File(path));
        }
        i = i + 1;
        loadThum(_listRecently[i]);
      });
    }
  }

  List<String> _listRecently = [];

  @override
  void initState() {
    SharedPreferencesUtils().getList("list").then((list) {
      setState(() {
        _listRecently = list;
      });
      if (list.length > 0) {
        loadThum(_listRecently[0]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            color: Colors.blue[100],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: (_listRecently.length == 0)
                ? Center(
                    child: Text(
                      "No files yet",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: _listRecently.length % 2 == 0
                        ? _listRecently.length
                        : _listRecently.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: index % 2 == 0
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width / 2,
                            child: Center(
                              child: index < _listRecently.length
                                  ? GestureDetector(
                                      onTap: () {
                                        _readFile(_listRecently[index]);
                                        if (_listRecently == null ||
                                            _listRecently.contains(
                                                    _listRecently[index]) ==
                                                false) {
                                          _listRecently.add(
                                              _listRecently[index].toString());
                                          print("length " +
                                              _listRecently.length.toString());
                                          SharedPreferencesUtils()
                                              .setList("list", _listRecently);
                                        }
                                      },
                                      child: Stack(
                                        children: <Widget>[
                                          _listThum.length ==
                                                  _listRecently.length
                                              ? Image.file(
                                                  _listThum[index],
                                                  width: (width / 2 - 51) / 1.4,
                                                  height: (width / 2 - 51),
                                                )
                                              : Container(
                                                  width: (width / 2 - 51) / 1.4,
                                                  height: (width / 2 - 51),
                                                ),
                                          Image.asset(
                                            "assets/images/ic_book_effect_pdf.png",
                                            width: (width / 2 - 51) / 1.4,
                                            height: (width / 2 - 51),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7.0),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width: (width / 2 - 51) / 1.4,
                                                  height:
                                                      (width / 2 - 51) / 4 * 3,
                                                ),
                                                Container(
                                                  width: (width / 2 - 51) / 1.4,
                                                  height: (width / 2 - 51) / 4,
                                                  child: Text(
                                                    getname(
                                                        _listRecently[index]),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: (width / 2 - 51) / 1.4,
                                      height: (width / 2 - 51)),
                            ),
                          ),
                          (index % 2 == 0)
                              ? Image.asset(
                                  "assets/images/ic_book_shelf_start.png",
                                  width: (width / 2 - 10),
                                  height: (width / 2 - 10) * 127 / 490)
                              : Image.asset(
                                  "assets/images/ic_book_shelf_end.png",
                                  width: (width / 2 - 10),
                                  height: (width / 2 - 10) * 127 / 490)
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
