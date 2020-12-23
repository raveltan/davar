import 'package:davar/pages/home_page.dart';
import 'package:davar/pages/reading_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  runApp(Bootstrap());
  // TODO: CONFIGURE PROGUARD FOR RELEASE (NOTIF)
}


class Bootstrap extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Davar',
      debugShowCheckedModeBanner: true,
      home:  HomePage(),
    );
  }

}
