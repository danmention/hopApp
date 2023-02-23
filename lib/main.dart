import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:hopleaders/screens/homeScreen.dart';
import 'package:hopleaders/screens/splashScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopleaders/utils/nativeTheme.dart';
import 'package:hopleaders/utils/notification_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';
import 'models/response/login_response.dart';
import 'utils/route.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
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
// final StreamController<String?> selectNotificationStream =
// StreamController<String?>.broadcast();
// const fetchBackground = "fetchBackground";
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

//
// @pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//     print("Native called background task: backgroundTask"); //simpleTask will be emitted here.
//     return Future.value(true);
//   });
// }

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true

);


//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//  // await setupFlutterNotifications();
//   showFlutterNotification(message);
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print('Handling a background message ${message.messageId}');
//   print('Handling a background message ${message.notification!.body}/ ${message.notification!.title}');
//
// }














Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showFlutterNotification(message);
  print('A bg message just showed up :  ${message.messageId}');
  print('Handling a background message ${message.notification!.body}/ ${message.notification!.title}');
}


Box? box;




 // bool isFlutterLocalNotificationsInitialized = false;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//
// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
// }

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //     AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
      );
    }
  }




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 // String? token = await FirebaseMessaging.instance.getToken();
  //print("Token:::::;;::::::::::::::::::$token");
  Hive.init((await getApplicationDocumentsDirectory()).path);

  // await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getInitialMessage();
  // NotificationService().initNotification();
  // // Set the background messaging handler early on, as a named top-level function
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //     AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);





  await Firebase.initializeApp();

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      // DO YOUR THING HERE

      print("::::::::::::::::::::: i am loving");
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );





  // Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  // );

  // final repeat = Repeat.daily(hour: 16, minute: 30);
  // return Workmanager.schedule("0", "Alarm", repeat: repeat);

  // Workmanager().registerOneOffTask("task-identifier", "simpleTask");
  //
  //
  // await Workmanager().registerPeriodicTask(
  //   "1",
  //   fetchBackground,
  //   frequency: Duration(hours: 1),
  //   constraints: Constraints(
  //     networkType: NetworkType.connected,
  //   ),
  // );

  //
  // try{
  //   FirebaseApp? app;
  //   List<FirebaseApp> firebase = Firebase.apps;
  //   for (FirebaseApp appd in firebase) {
  //     if (appd.name == 'Gofresha') {
  //       app = appd;
  //       break;
  //     }
  //   }
  //   if (app == null) {
  //     if(Platform.isIOS){
  //       await Firebase.initializeApp(
  //         name: 'Gofresha',
  //         options: const FirebaseOptions(apiKey: 'asdfasdfsadfasdfsaf-Y',
  //             appId: '1:446164616467:ios:jadsfadsfasfs',
  //             messagingSenderId: '446164616467',
  //             projectId: 'demo-e98f0'),
  //       );
  //     }else{
  //       await Firebase.initializeApp();
  //     }
  //   }
  // }finally{
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   await flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  //
  //
  //   runApp(ProviderScope(child: const MyApp()));
  // }




   runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? mtoken = " ";
  @override
  void initState() {
    requestPermission();
    getToken();
    print("FirebaseMessaging token: $mtoken");


    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});








    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

     flutterLocalNotificationsPlugin.initialize(initializationSettings,   onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {

    });







    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message data::::::::::::::::: ${message.data}');

        // Navigator.pushNamed(
        //   context,
        //   'report',
        // );


        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification!.title}');
          // showDialog(
          //     context: context,
          //     builder: (_) {
          //       return AlertDialog(
          //         title: Text(message.notification!.title!),
          //         content: SingleChildScrollView(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [Text(message.notification!.body!)],
          //           ),
          //         ),
          //       );
          //     });


        }
      print('Got hhhhhh:::::::;a message whilst in the foreground!!!!!!!');


      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!${message.notification!.title}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;


      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }




    });




    // TODO: implement initState
    super.initState();
  }


  void showNotification() {

    flutterLocalNotificationsPlugin.show(
        0,
        "Testing ",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }




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



  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;

      });

      savetoken(token);
    });

    print("Token::::::::::::::$mtoken");
  }
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void savetoken(String? token) {

  }
}


