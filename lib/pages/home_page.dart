import 'package:davar/pages/reading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _startReading() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (x) => ReadingPage()));

  void _selectReminderTime() {
    showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 8, minute: 0));
  }

  bool _showNotificationStatus = false;
  bool _isLoading = false;

  FlutterLocalNotificationsPlugin _notificationsPlugin;

  selectNotification(String payload) => _startReading();

  @override
  void initState() {
    super.initState();
    createNotifChannel();
  }

  void createNotifChannel() async {
    setState(() {
      _isLoading = true;
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // nav
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.blue, // status bar color
    ));
    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    // final IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // final MacOSInitializationSettings initializationSettingsMacOS =
    // MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      //iOS: initializationSettingsIOS,
      //macOS: initializationSettingsMacOS
    );
    await _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    setState(() {
      _isLoading = false;
    });
  }

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
              onPressed: _startReading,
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
                    padding: EdgeInsets.only(bottom: 16, left: 24, right: 24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
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
                          height: 12,
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
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SwitchListTile(
                          title: Text('Enable Notification'),
                          subtitle: Text('Remind me to read everyday'),
                          onChanged: (d) =>
                              setState(() => _showNotificationStatus = d),
                          value: _showNotificationStatus,
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
                          onTap: _selectReminderTime,
                        ),
                        Divider(height: 0),
                        ListTile(
                          title: Text("Select Bible Edition"),
                          subtitle: Text('English - Study Bible'),
                          trailing: Icon(Icons.book),
                          onTap: () async {
                            const AndroidNotificationDetails
                                androidPlatformChannelSpecifics =
                                AndroidNotificationDetails(
                                    'net.lightbear.davar',
                                    'Davar',
                                    'Show bible reading notification',
                                    importance: Importance.max,
                                    priority: Priority.high,
                                    showWhen: false);
                            const NotificationDetails platformChannelSpecifics =
                                NotificationDetails(
                                    android: androidPlatformChannelSpecifics);
                            await _notificationsPlugin.show(
                                0,
                                'Hello there',
                                'Time for daily Bible reading.',
                                platformChannelSpecifics,
                                payload: 'item x');

                            // const AndroidNotificationDetails androidPlatformChannelSpecifics =
                            // AndroidNotificationDetails('net.lightbear.davar',
                            //     'Reminder', 'repeating description');
                            // const NotificationDetails platformChannelSpecifics =
                            // NotificationDetails(android: androidPlatformChannelSpecifics);
                            // await widget._notificationsPlugin.periodicallyShow(0, 'repeating title',
                            //     'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics,
                            //     androidAllowWhileIdle: true);
                          },
                        ),
                        Divider(height: 0),
                        ListTile(
                          title: Text("Support Us"),
                          subtitle: Text('Submit code or bug request'),
                          trailing: Icon(Icons.bug_report),
                          onTap: () =>
                              launch('https://github.com/raveltan/davar'),
                        ),
                        Divider(height: 0),
                        ListTile(
                          title: Text('Version'),
                          subtitle: Text('0.0.1 א'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
