import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _checkJWLibInstalled() async {
    return DeviceApps.isAppInstalled('org.jw.jwlibrary.mobile');
  }

  void _openJWLib() async {
    await DeviceApps.openApp('org.jw.jwlibrary.mobile');
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Davar'),
        elevation: 0,
        brightness: Brightness.dark,
      ),
      floatingActionButton: _isLoading
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.book),
              onPressed: _openJWLib,
            ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text('Loading ...')
                  ],
                ),
              ),
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 24, left: 24, right: 24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                        color: Colors.blue),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          '“They continued reading aloud from the book, from the Law of the true God, clearly explaining it and putting meaning into it; so they helped the people to understand what was being read.”',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Nehemiah 8:8",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        SwitchListTile(
                          title: Text('Enable Notification'),
                          subtitle: Text('Remind me to read everyday'),
                          onChanged: (d) {},
                          value: true,
                        ),
                        Divider(
                          height: 0,
                        ),
                        ListTile(
                          title: Text('Reminder Time'),
                          subtitle: Text('Set the reading reminder time'),
                          trailing: Chip(
                            label: Text(
                              '09.00 AM',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('About Davar'),
                          onTap: (){
                            showAboutDialog(context: context,
                            applicationName: 'Davar',);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
