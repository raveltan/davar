import 'package:flutter/material.dart';
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
              Expanded(
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl:
                      'https://www.jw.org/en/library/bible/study-bible/books/',
                ),
              ),
              Container(
                child: ListTile(
                  title: Text('Save progress'),
                  subtitle: Text("Press back to save progress and exit"),
                  trailing: Icon(Icons.save),
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
