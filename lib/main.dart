import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:hopleaders/screens/homeScreen.dart';
import 'package:hopleaders/screens/splashScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopleaders/utils/nativeTheme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';
import 'models/response/login_response.dart';
import 'utils/route.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:hive_flutter/hive_flutter.dart';
// int id = 0;
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();



//
// /// Streams are created so that app can respond to notification-related events
// /// since the plugin is initialised in the `main` function

// final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
// StreamController<ReceivedNotification>.broadcast();


//
final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();
const fetchBackground = "fetchBackground";
//
// const MethodChannel platform =
// MethodChannel('dexterx.dev/flutter_local_notifications_example');
//
// const String portName = 'notification_send_port';
//
// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });
//
//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
// }
// Future<void> _configureLocalTimeZone() async {
//   if (kIsWeb || Platform.isLinux) {
//     return;
//   }
//   tz.initializeTimeZones();
//   final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
//   tz.setLocalLocation(tz.getLocation(timeZoneName!));
// }
// String? selectedNotificationPayload;
//
// /// A notification action which triggers a url launch event
// const String urlLaunchActionId = 'id_1';
//
// /// A notification action which triggers a App navigation event
// const String navigationActionId = 'id_3';
//
// /// Defines a iOS/MacOS notification category for text input actions.
// const String darwinNotificationCategoryText = 'textCategory';
//
// /// Defines a iOS/MacOS notification category for plain actions.
// const String darwinNotificationCategoryPlain = 'plainCategory';
//
// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // ignore: avoid_print
//   print('notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}');
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     // ignore: avoid_print
//     print(
//         'notification action tapped with input: ${notificationResponse.input}');
//   }
// }


@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Native called background task: backgroundTask"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}


Box? box;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Hive.init((await getApplicationDocumentsDirectory()).path);






  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

  // final repeat = Repeat.daily(hour: 16, minute: 30);
  // return Workmanager.schedule("0", "Alarm", repeat: repeat);

  Workmanager().registerOneOffTask("task-identifier", "simpleTask");


  await Workmanager().registerPeriodicTask(
    "1",
    fetchBackground,
    frequency: Duration(hours: 1),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
 // await _configureLocalTimeZone();

 //  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
 //      Platform.isLinux
 //      ? null
 //      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
 // // String initialRoute = HomeScreen.routeName;
 //  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
 //    selectedNotificationPayload =
 //        notificationAppLaunchDetails!.notificationResponse?.payload;
 //  //  initialRoute = SecondPage.routeName;
 //  }
 //
 //  const AndroidInitializationSettings initializationSettingsAndroid =
 //  AndroidInitializationSettings('app_icon');
 //  final List<DarwinNotificationCategory> darwinNotificationCategories =
 //  <DarwinNotificationCategory>[
 //    DarwinNotificationCategory(
 //      darwinNotificationCategoryText,
 //      actions: <DarwinNotificationAction>[
 //        DarwinNotificationAction.text(
 //          'text_1',
 //          'Action 1',
 //          buttonTitle: 'Send',
 //          placeholder: 'Placeholder',
 //        ),
 //      ],
 //    ),
 //    DarwinNotificationCategory(
 //      darwinNotificationCategoryPlain,
 //      actions: <DarwinNotificationAction>[
 //        DarwinNotificationAction.plain('id_1', 'Action 1'),
 //        DarwinNotificationAction.plain(
 //          'id_2',
 //          'Action 2 (destructive)',
 //          options: <DarwinNotificationActionOption>{
 //            DarwinNotificationActionOption.destructive,
 //          },
 //        ),
 //        DarwinNotificationAction.plain(
 //          navigationActionId,
 //          'Action 3 (foreground)',
 //          options: <DarwinNotificationActionOption>{
 //            DarwinNotificationActionOption.foreground,
 //          },
 //        ),
 //        DarwinNotificationAction.plain(
 //          'id_4',
 //          'Action 4 (auth required)',
 //          options: <DarwinNotificationActionOption>{
 //            DarwinNotificationActionOption.authenticationRequired,
 //          },
 //        ),
 //      ],
 //      options: <DarwinNotificationCategoryOption>{
 //        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
 //      },
 //    )
 //  ];
 //  final DarwinInitializationSettings initializationSettingsDarwin =
 //  DarwinInitializationSettings(
 //    requestAlertPermission: false,
 //    requestBadgePermission: false,
 //    requestSoundPermission: false,
 //    onDidReceiveLocalNotification:
 //        (int id, String? title, String? body, String? payload) async {
 //      didReceiveLocalNotificationStream.add(
 //        ReceivedNotification(
 //          id: id,
 //          title: title,
 //          body: body,
 //          payload: payload,
 //        ),
 //      );
 //    },
 //    notificationCategories: darwinNotificationCategories,
 //  );
 //
 //  final InitializationSettings initializationSettings = InitializationSettings(
 //    android: initializationSettingsAndroid,
 //    iOS: initializationSettingsDarwin,
 //
 //  );
 //  await flutterLocalNotificationsPlugin.initialize(
 //    initializationSettings,
 //    onDidReceiveNotificationResponse:
 //        (NotificationResponse notificationResponse) {
 //      switch (notificationResponse.notificationResponseType) {
 //        case NotificationResponseType.selectedNotification:
 //          selectNotificationStream.add(notificationResponse.payload);
 //          break;
 //        case NotificationResponseType.selectedNotificationAction:
 //          if (notificationResponse.actionId == navigationActionId) {
 //            selectNotificationStream.add(notificationResponse.payload);
 //          }
 //          break;
 //      }
 //    },
 //    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
 //  );


  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//0063DB
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hop App',
     onGenerateRoute: RouteGenerator.generateRoute,
      //initialRoute: "login",
      theme: nativeTheme(),
      home: SplashScreen(),
    );
  }
}


