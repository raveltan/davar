import 'package:davar/utils/editions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive/hive.dart';

class ReadingPage extends StatefulWidget {
  Box _box;

  ReadingPage(this._box);

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  String _url;

  @override
  void initState() {
    super.initState();
    _url = widget._box.get('progress', defaultValue: bibleEditions[0].url);
  }

  void _setUrl(String url) {
    if (this._url == url) return;
    this._url = url;
    widget._box.put('progress', url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            width: double.infinity,
            color: Color.fromRGBO(55, 52, 51, 1),
          ),
          Expanded(
            child: InAppWebView(
              initialUrl: _url,
              //onLoadStart: (c,s) => print(s),
              onTitleChanged: (c, s) async => _setUrl(await c.getUrl()),
            ),
          ),
          ListTile(
            title: Text(
              'Reading ..',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Your progress is automatically saved',
              style: TextStyle(color: Colors.white),
            ),
            tileColor: Color.fromRGBO(55, 52, 51, 1),
            trailing: IconButton(
              color: Colors.white,
              icon: Icon(Icons.check),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
