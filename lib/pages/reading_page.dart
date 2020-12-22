import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadingPage extends StatefulWidget {
  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  Future<bool> _saveAndGoBack() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('End Reading'),
            content: Text('Do you want to exit and save the reading progress?'),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                child: ListTile(
                  tileColor: Colors.blue,
                  title: Text(
                    'Save progress',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Press back to save progress and exit",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 2.0,
                color: Colors.white,
              ),
              Expanded(
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl:
                      'https://www.jw.org/en/library/bible/study-bible/books/',
                ),
              ),
            ],
          ),
        ),
        onWillPop: _saveAndGoBack,
      ),
    );
  }
}
