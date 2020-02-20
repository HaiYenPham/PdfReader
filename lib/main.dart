import 'package:flutter/material.dart';
import 'package:pdf_reader/screens/MainPage.dart';
import 'package:pdf_reader/utils/permission.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
