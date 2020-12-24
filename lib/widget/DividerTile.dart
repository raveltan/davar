import 'package:flutter/material.dart';

class DividerTile extends StatelessWidget {
  String text;
  DividerTile(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 0),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: 10),
            child: Text(
              text,
              style:
              TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}
