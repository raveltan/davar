import 'package:davar/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(Bootstrap());

class Bootstrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Davar',
      home: HomePage(),
    );
  }
}
