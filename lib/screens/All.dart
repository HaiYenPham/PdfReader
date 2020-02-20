import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:pdf_reader/utils/admob_ads.dart';
import 'package:pdf_reader/utils/config.dart';
import 'package:pdf_reader/utils/native.dart';
import 'package:pdf_reader/utils/permission.dart';
import 'package:pdf_reader/utils/share_pre.dart';
import 'package:permission_handler/permission_handler.dart';

class All extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _All();
  }
}

String getname(String s) {
  String res;
  int index = s.lastIndexOf("/");
  res = s.substring(index + 1);
  return res;
}

class _All extends State<All> {
  SharedPreferencesUtils sharePre = SharedPreferencesUtils();
  int i = 0;
  List<String> _listFile = [];

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
          // print(">> atExit($pageIndex)");
        },
      ),
    );
  }

  List<File> _listThum = [];

  void loadThum(String path) {
    if (i < _listFile.length) {
      platform.invokeMethod('getThum', {"filePath": path}).then((path) {
        if (i == _listFile.length - 1) {
          setState(() {
            _listThum.add(File(path));
          });
        } else {
          _listThum.add(File(path));
        }
        i = i + 1;
        loadThum(_listFile[i]);
      });
    }
  }

  getPermissionAndRun() {
    PermissionUtil.requestPermission(PermissionGroup.storage).then((value) {
      if (value) {
        platform.invokeMethod('loadFile').then((list) {
          i = 0;
          setState(() {
            list.forEach((e) {
              _listFile.add(e.toString());
            });
            if (list.length > 0) {
              loadThum(_listFile[0]);
            }
          });
        });
      } else {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Permission"),
              content: const Text(
                  'Allow PDF Reader to read storage device, please!'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      getPermissionAndRun();
                    });
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  bool isHide = true;
  List<String> _listRecently = [];
  @override
  void initState() {
    // TODO: implement initState
    getPermissionAndRun();

    SharedPreferencesUtils().getList("list").then((list) {
      _listRecently = list;
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
            child: (_listFile.length == 0)
                ? Center(
                    child: Text(
                      "No files yet",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: _listFile.length % 2 == 0
                        ? _listFile.length
                        : _listFile.length + 1,
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
                              child: index < _listFile.length
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHide = false;
                                        });
                                        AdmobAds.createInterstitialAd(70, () {
                                          setState(() {
                                            isHide = true;
                                          });
                                          _readFile(_listFile[index]);
                                          if (_listRecently == null ||
                                              _listRecently.contains(
                                                      _listFile[index]) ==
                                                  false) {
                                            _listRecently.add(
                                                _listFile[index].toString());
                                            SharedPreferencesUtils()
                                                .setList("list", _listRecently);
                                          }
                                        });
                                      },
                                      child: Stack(
                                        children: <Widget>[
                                          _listThum.length == _listFile.length
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
                                                    getname(_listFile[index]),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                                color: Colors.red[400],
                                              ),
                                              width: 35,
                                              height: 35,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Uint8List bytes =
                                                      Uint8List.fromList(File(
                                                              _listFile[index])
                                                          .readAsBytesSync());
                                                  await Share.file(
                                                      "PDF Reader",
                                                      getname(_listFile[index]),
                                                      bytes,
                                                      "*/*");
                                                },
                                                child: Icon(
                                                  Icons.share,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
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
          isHide
              ? Container()
              : Container(
                  width: width,
                  height: height,
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
        ],
      ),
    );
  }
}
