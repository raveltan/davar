import 'package:davar/utils/editions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BibleSelection extends StatelessWidget {
  Box _box;

  BibleSelection(this._box);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Bible Edition'),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: bibleEditions.length,
        itemBuilder: (x, i) => ListTile(
          title: Text(bibleEditions[i].name),
          onTap: () => showDialog(
              context: context,
              builder: (x) => AlertDialog(
                    title: Text('Are you sure'),
                    content:
                        Text('Changing Bible edition will reset your progress'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    actions: [
                      FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () => Navigator.of(x).pop(),
                          child: Text('Cancel')),
                      FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            _box.put('edition', i);
                            _box.put('progress', bibleEditions[i].url);
                            Navigator.of(x).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'))
                    ],
                  )),
        ),
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 0,
        ),
      ),
    );
  }
}
