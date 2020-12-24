import 'package:davar/pages/bible_selection_page.dart';
import 'package:davar/pages/reading_page.dart';
import 'package:davar/utils/editions.dart';
import 'package:davar/widget/divider_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _startReading() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (x) => ReadingPage(_box)));

  void setNotification(Duration d) async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    await _notificationsPlugin.zonedSchedule(
        0,
        'Davar',
        'Time for daily Bible reading 😁',
        tz.TZDateTime.now(tz.local).add(d),
        const NotificationDetails(
            android: AndroidNotificationDetails('net.lightbear.davar',
                'Bible Notification', 'Notify user to read Bible',enableLights: true,
            channelShowBadge: true,
              enableVibration: true,
              priority: Priority.max,
              color: Colors.blue,
              importance: Importance.max,
              playSound: true,
            )),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  bool _isLoading = false;

  FlutterLocalNotificationsPlugin _notificationsPlugin;

  Future<void> selectNotification(String payload) async =>
      await _startReading();

  @override
  void initState() {
    super.initState();
    setupStorageAndNotificationChannel();
  }

  Box _box;
  String _version;

  void setupStorageAndNotificationChannel() async {
    setState(() {
      _isLoading = true;
    });
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.white, // nav
    //   systemNavigationBarIconBrightness: Brightness.dark,
    //   statusBarColor: Colors.blue, // status bar color
    // ));
    var packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version + '+' + packageInfo.buildNumber;
    await Hive.initFlutter();
    _box = await Hive.openBox('davar_data');
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
              child: ValueListenableBuilder(
                valueListenable: _box.listenable(),
                builder: (c, box, w) {
                  List<int> _rt = _box.get('time', defaultValue: [8, 0]);
                  var _reminderTimeString =
                      (_rt[0] < 10 ? '0' + '${_rt[0]}' : '${_rt[0]}') +
                          ':' +
                          (_rt[1] < 10 ? '0' + '${_rt[1]}' : '${_rt[1]}');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(bottom: 16, left: 24, right: 24),
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
                              onChanged: _enableNotification,
                              value: _box.get('notification_enabled',
                                  defaultValue: false),
                            ),
                            Divider(
                              height: 0,
                            ),
                            ListTile(
                              title: Text('Reminder Time'),
                              subtitle: Text('Set the reading reminder time'),
                              trailing: Chip(
                                label: Text(
                                  _reminderTimeString,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.blue,
                              ),
                              onTap: _selectReminderTime,
                            ),
                            DividerTile('Bible'),
                            ListTile(
                              title: Text("Select Bible Edition"),
                              subtitle: Text(bibleEditions[
                                      _box.get('edition', defaultValue: 0)]
                                  .name),
                              trailing: Icon(Icons.book),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (x) => BibleSelection(_box))),
                            ),
                            ListTile(
                              title: Text("Bible Source"),
                              trailing: Text(
                                'JW.org',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () => launch('https://jw.org'),
                            ),
                            DividerTile('About Davar'),
                            ListTile(
                              title: Text("Support Davar"),
                              subtitle: Text('Submit code or bug request'),
                              trailing: Icon(Icons.bug_report),
                              onTap: () =>
                                  launch('https://github.com/raveltan/davar'),
                            ),
                            ListTile(
                              title: Text('Version'),
                              subtitle: Text(_version),
                            ),
                            Divider(height: 0),
                            Container(
                              height: 75,
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
    );
  }

  void _enableNotification(bool value) async {
    await _notificationsPlugin.cancelAll();
    if (!value) {
      print('cancel notification');
    } else {
      print('enable notification');
      var scheduledTime = _box.get('time', defaultValue: [8, 0]);
      var now = DateTime.now();
      var next = DateTime(
          now.year, now.month, now.day, scheduledTime[0], scheduledTime[1]);
      next = next.add(Duration(days: 1));
      var diff = next.difference(now);
      setNotification(diff);
    }
    _box.put('notification_enabled', value);
  }

  void _selectReminderTime() async {
    var st = _box.get('time', defaultValue: [8, 0]);
    final result = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: st[0], minute: st[1]));
    if (result == null) return;
    await _box.put("time", [result.hour, result.minute]);
    _enableNotification(
        await _box.get('notification_enabled', defaultValue: false));
  }
}
