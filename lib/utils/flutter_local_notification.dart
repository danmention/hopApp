// import 'dart:async';
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
//
//
// class LocalNotificationService {
//   LocalNotificationService();
//
//   final _localNotificationService = FlutterLocalNotificationsPlugin();
//
//
//   // final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
//   // StreamController<ReceivedNotification>.broadcast();
//
//   final StreamController<String?> selectNotificationStream =
//   StreamController<String?>.broadcast();
//
//   //final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
//   static const String darwinNotificationCategoryText = 'textCategory';
//
//
//   // Future<void> _configureLocalTimeZone() async {
//   //      tz.initializeTimeZones();
//   //   final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
//   //   tz.setLocalLocation(tz.getLocation(timeZoneName!));
//   // }
//   Future<void> intialize() async {
//     tz.initializeTimeZones();
//     const AndroidInitializationSettings androidInitializationSettings =
//     AndroidInitializationSettings('@drawable/ic_notice');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//     DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//
//
//     // IOSInitializationSettings iosInitializationSettings =
//     // IOSInitializationSettings(
//     //   requestAlertPermission: true,
//     //   requestBadgePermission: true,
//     //   requestSoundPermission: true,
//     //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     // );
//
//     final InitializationSettings settings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: initializationSettingsDarwin,
//     );
//
//
//
//     // await _localNotificationService.initialize(
//     //   settings,
//     //   onSelectNotification: onSelectNotification,
//     // );
//
//     await _localNotificationService.initialize(settings,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
//
//
//   }
//
//   Future<NotificationDetails> _notificationDetails() async {
//     const AndroidNotificationDetails androidNotificationDetails =
//     AndroidNotificationDetails('channel_id', 'channel_name',
//         channelDescription: 'description',
//         importance: Importance.max,
//         priority: Priority.max,
//         playSound: true,
//       sound: RawResourceAndroidNotificationSound('alarm')
//
//     );
//
//     const DarwinNotificationDetails iosNotificationDetails =
//     DarwinNotificationDetails(
//       categoryIdentifier: darwinNotificationCategoryText,
//     );
//     // const IOSNotificationDetails iosNotificationDetails =
//     // IOSNotificationDetails();
//
//     return const NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: iosNotificationDetails,
//     );
//   }
//   var time = Time(21, 45, 00);
//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//   }) async {
//     final details = await _notificationDetails();
//     await _localNotificationService.show(id, title, body, details);
//   }
//
//
//   tz.TZDateTime _nextInstanceOfTenAM() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//     tz.TZDateTime(tz.local, now.year, now.month, now.day, 15,43,0,0);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
//
//
//   tz.TZDateTime get9pmWAT() {
//     final location = tz.getLocation('Africa/Lagos');
//     final now = tz.TZDateTime.now(location);
//     final ninePM = tz.TZDateTime(location, now.year, now.month, now.day, 16,26);
//     print("It is currently in West Africa Time (WAT)");
//     return ninePM;
//   }
//   Future<void> showScheduledNotification(
//       {required int id,
//         required String title,
//         required String body,
//         required int seconds}) async {
//     final details = await _notificationDetails();
//     await _localNotificationService.zonedSchedule(
//       id,
//       title,
//       body,
//         get9pmWAT(),
//       //_nextInstanceOfTenAM(),
//        // var time = Time(21, 45, 00);
//     // tz.TZDateTime.from(
//       //   DateTime.now().add(Duration(seconds: seconds)),
//       //   tz.local,
//       // ),
//       details,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time
//     );
//   }
//
//   Future<void> showNotificationWithPayload(
//       {required int id,
//         required String title,
//         required String body,
//         required String payload}) async {
//     final details = await _notificationDetails();
//     await _localNotificationService.show(id, title, body, details,
//         payload: payload);
//   }
//
//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     print('id $id');
//   }
//
//   void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       print('notification payload: $payload');
//     }
//
//     // await Navigator.push(
//     //   context,
//     //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
//     // );
//   }
//
//   void configureSelectNotificationSubject() {
//     selectNotificationStream.stream.listen((String? payload) async {
//       // await Navigator.of(context).push(MaterialPageRoute<void>(
//       //   builder: (BuildContext context) => SecondPage(payload),
//       // ));
//     });
//   }
//
//   void onSelectNotification(String? payload) {
//     print('payload $payload');
//     if (payload != null && payload.isNotEmpty) {
//      // onNotificationClick.add(payload);
//     }
//   }
// }