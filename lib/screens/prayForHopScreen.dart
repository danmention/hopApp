// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hopleaders/screens/winnerScreen.dart';
// import 'dart:async';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'dart:async';
// import 'dart:convert';
//
// import 'dart:typed_data';
//
// import '../main.dart';
// class PrayerPage extends StatefulWidget {
//   final String? payload;
//   PrayerPage({this.payload});
//   @override
//   _AlarmPageState createState() => _AlarmPageState();
// }
//
// class _AlarmPageState extends State<PrayerPage> {
//
//
//   late final NotificationAppLaunchDetails? notificationAppLaunchDetails;
//
//   bool get didNotificationLaunchApp =>
//       notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
//
//
//
//
//
//
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//     static const String darwinNotificationCategoryPlain = 'plainCategory';
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   var initializationSettingsAndroid =
//   //   AndroidInitializationSettings('app_icon');
//   //
//   //   //var initializationSettingsIOS = IOSInitializationSettings();
//   //   const DarwinNotificationDetails iosNotificationDetails =
//   //   DarwinNotificationDetails(
//   //     categoryIdentifier: darwinNotificationCategoryPlain,
//   //   );
//   //
//   //   var initializationSettings = InitializationSettings(
//   //       android: initializationSettingsAndroid, iOS: iosNotificationDetails);
//   //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   // }
//
//
//
//   bool _notificationsEnabled = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _isAndroidPermissionGranted();
//     _requestPermissions();
//     // _configureDidReceiveLocalNotificationSubject();
//     // _configureSelectNotificationSubject();
//   }
//
//   Future<void> _isAndroidPermissionGranted() async {
//     if (Platform.isAndroid) {
//       final bool granted = await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.areNotificationsEnabled() ??
//           false;
//
//       setState(() {
//         _notificationsEnabled = granted;
//       });
//     }
//   }
//
//   Future<void> _requestPermissions() async {
//     if (Platform.isIOS || Platform.isMacOS) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           MacOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//     } else if (Platform.isAndroid) {
//       final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
//       flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>();
//
//       final bool? granted = await androidImplementation?.requestPermission();
//       setState(() {
//         _notificationsEnabled = granted ?? false;
//       });
//     }
//   }
//
//   // void _configureDidReceiveLocalNotificationSubject() {
//   //   didReceiveLocalNotificationStream.stream
//   //       .listen((ReceivedNotification receivedNotification) async {
//   //     await showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) => CupertinoAlertDialog(
//   //         title: receivedNotification.title != null
//   //             ? Text(receivedNotification.title!)
//   //             : null,
//   //         content: receivedNotification.body != null
//   //             ? Text(receivedNotification.body!)
//   //             : null,
//   //         actions: <Widget>[
//   //           CupertinoDialogAction(
//   //             isDefaultAction: true,
//   //             onPressed: () async {
//   //               Navigator.of(context, rootNavigator: true).pop();
//   //               await Navigator.of(context).push(
//   //                 MaterialPageRoute<void>(
//   //                   builder: (BuildContext context) =>
//   //                       //WinnerScreen(receivedNotification.payload),
//   //                       WinnerScreen(),
//   //                 ),
//   //               );
//   //             },
//   //             child: const Text('Ok'),
//   //           )
//   //         ],
//   //       ),
//   //     );
//   //   });
//   // }
//   //
//   // void _configureSelectNotificationSubject() {
//   //   selectNotificationStream.stream.listen((String? payload) async {
//   //     // await Navigator.of(context).push(MaterialPageRoute<void>(
//   //     //   builder: (BuildContext context) => SecondPage(payload),
//   //     // ));
//   //   });
//   // }
//   //
//   // @override
//   // void dispose() {
//   //   didReceiveLocalNotificationStream.close();
//   //   selectNotificationStream.close();
//   //   super.dispose();
//   // }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Alarm"),
//       ),
//       body: Column(
//         children: <Widget>[
//           ElevatedButton(
//             child: Text("Add Alarm"),
//             onPressed: () async {
//               var time = Time(21, 45, 00);
//
//            // 9:45 PM
//
//
//
//
//               tz.TZDateTime _nextInstanceOfTenAM() {
//                 final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//                 tz.TZDateTime scheduledDate =
//                 tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
//                 if (scheduledDate.isBefore(now)) {
//                   scheduledDate = scheduledDate.add(const Duration(days: 1));
//                 }
//                 return scheduledDate;
//               }
//               var androidPlatformChannelSpecifics =
//
//               AndroidNotificationDetails(
//                   'your channel id', 'your channel name', channelDescription: 'your channel description',
//                   importance: Importance.max,
//                   priority: Priority.high,
//                   ticker: 'ticker');
//               const DarwinNotificationDetails iosNotificationDetails =
//               DarwinNotificationDetails(
//                 categoryIdentifier: darwinNotificationCategoryPlain,
//               );
//              // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//               var platformChannelSpecifics = NotificationDetails(
//                   android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
//               await flutterLocalNotificationsPlugin.zonedSchedule(0,
//                   'Pray for your cell',
//                   'Pray at least 15 mins for your cell',
//                   _nextInstanceOfTenAM(),
//                   platformChannelSpecifics,
//                   androidAllowWhileIdle: true,
//                   uiLocalNotificationDateInterpretation:
//                   UILocalNotificationDateInterpretation.absoluteTime,
//                   matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
//
//
//               );
//
//
//
//
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
