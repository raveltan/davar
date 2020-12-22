import 'package:davar/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // nav
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.blue, // status bar color
  ));
  runApp(Bootstrap());
}

class Bootstrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Davar',
      debugShowCheckedModeBanner: true,
      home: HomePage(),
    );
  }
}
