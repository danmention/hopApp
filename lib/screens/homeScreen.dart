import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hopleaders/models/response/hopdigest_response.dart';
import 'package:hopleaders/screens/digestDetailScreen.dart';
import 'package:hopleaders/screens/eventDetailScreen.dart';
import 'package:hopleaders/screens/prayForHopScreen.dart';
import 'package:shimmer/shimmer.dart';

import '../models/DigestModel.dart';
import '../models/businessLayer/base.dart';
import '../models/eventModel.dart';
import '../utils/flutter_local_notification.dart';

import '../utils/notification_service.dart';
import '../widget/buttonWidget.dart';
import '../widget/navbar.dart';
import '../widget/top_container_widget.dart';

class HomeScreen extends Base {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState{

  final StreamController<String?> selectNotificationStream =
  StreamController<String?>.broadcast();
  //late final LocalNotificationService service;
  DateTime scheduleTime = DateTime.now();


  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();



  bool _notificationsEnabled = false;



  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<HopDigestResponse> _hopDigestList = [];
  bool _isDataLoaded = false;
  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  ScrollController _scrollController = ScrollController();
  int pageNumber = 0;
  List<Event>  eventlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
    // _isAndroidPermissionGranted();
    // _requestPermissions();
   // service = LocalNotificationService();
   // service.intialize();
   // _init();
   // _configureDidReceiveLocalNotificationSubject();
 // _configureSelectNotificationSubject();

  }






  // Future<void> _isAndroidPermissionGranted() async {
  //   if (Platform.isAndroid) {
  //     final bool granted = await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //         ?.areNotificationsEnabled() ??
  //         false;
  //
  //     setState(() {
  //       _notificationsEnabled = granted;
  //     });
  //   }
  // }
  // Future<void> _requestPermissions() async {
  //   if (Platform.isIOS || Platform.isMacOS) {
  //     await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //         IOSFlutterLocalNotificationsPlugin>()
  //         ?.requestPermissions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  //     await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //         MacOSFlutterLocalNotificationsPlugin>()
  //         ?.requestPermissions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  //   } else if (Platform.isAndroid) {
  //     final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
  //     flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>();
  //
  //     final bool? granted = await androidImplementation?.requestPermission();
  //     setState(() {
  //       _notificationsEnabled = granted ?? false;
  //     });
  //   }
  // }

  // void _configureDidReceiveLocalNotificationSubject() {
  //   didReceiveLocalNotificationStream.stream
  //       .listen((ReceivedNotification receivedNotification) async {
  //     await showDialog(
  //       context: context,
  //       builder: (BuildContext context) => CupertinoAlertDialog(
  //         title: receivedNotification.title != null
  //             ? Text(receivedNotification.title!)
  //             : null,
  //         content: receivedNotification.body != null
  //             ? Text(receivedNotification.body!)
  //             : null,
  //         actions: <Widget>[
  //           CupertinoDialogAction(
  //             isDefaultAction: true,
  //             onPressed: () async {
  //               Navigator.of(context, rootNavigator: true).pop();
  //               await Navigator.of(context).push(
  //                 MaterialPageRoute<void>(
  //                   builder: (BuildContext context) =>
  //                       SecondPage(receivedNotification.payload),
  //                 ),
  //               );
  //             },
  //             child: const Text('Ok'),
  //           )
  //         ],
  //       ),
  //     );
  //   });
  // }



  Widget digest(){
    return  Expanded(
      child: Card(
        elevation: 5,
        child: ListTile(
          leading:  CircleAvatar(
            backgroundColor: Colors.orange,
            child: Image.asset(
              "assets/logo.png",
            ),
          ),
          title: Text('Building the best church leadership'),
          subtitle: Text('managing the difference'),
         trailing: Icon(Icons.edit),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;




var containerList = [
  TopMenu(title: 'Events', subtitle: ' View events', color: Colors.green, route: 'event', iconData: FontAwesomeIcons.bell),
  TopMenu(title: 'Latest Hop', subtitle: ' New Hop Near you', color: Colors.orange,route: 'allhop', iconData: FontAwesomeIcons.addressBook),
  TopMenu(title: 'Hop Digest', subtitle: ' Read Hop Digest', color: Colors.red,route: 'hopdigest', iconData: FontAwesomeIcons.bible,)
,
  TopMenu(title: 'Questions', subtitle: ' Send us a feedback', color: Colors.brown, route: 'feedback',iconData: FontAwesomeIcons.question,),

];










    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          nextScreen(context, 'report');
        },
        icon: const Icon(Icons.edit),
        label: const Text('Submit Report'),
        backgroundColor: Colors.blue,
      ),
      drawer: NavDrawer(),
      body: Column(children: [


        Container(
          height: 160,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(5))
          ),
          child: Column(
            children: [
              Container(
                height:100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: containerList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                        onTap: (){
                          nextScreen(context, containerList[index].route!);
                        },

                        child: TopContainer(title:containerList[index].title , subtitle:containerList[index].subtitle , iconData: containerList[index].iconData,   colors: containerList[index].color,));
                  },),
              ),
            ],
          ),
        ),


        Container(child: Column(children: [
          SizedBox(height: 10,),
          Text('Most outstanding Hop Leader\'s of the week. ', style: Theme.of(context).primaryTextTheme.headline3,) ,
          SizedBox(height: 10,),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal:18.0),
            child: Button(btnText: 'See Outstanding Winner\'s',onClick: (){
             // service.showNotification(id: 2, title: " we are here", body: " Building universal life" );
             nextScreen(context, 'winner');
            },),
          ),

          // TextButton(
          //   onPressed: () {
          //     DatePicker.showDateTimePicker(
          //       context,
          //       showTitleActions: true,
          //       onChanged: (date) => scheduleTime = date,
          //       onConfirm: (date) {},
          //     );
          //   },
          //   child: const Text(
          //     'Select Date Time',
          //     style: TextStyle(color: Colors.blue),
          //   ),
          // ),



        ],), ),
        SizedBox(height: 15,),



        // Container(
        //     height: 1,
        //     width: 500,
        //     color: Colors.black12
        //
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text('Top 5 Hop Winners of the week.  ', style: Theme.of(context).primaryTextTheme.headline3,),
        // ) ,




        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
           //   winner,winner,winner,winner,winner
            ],),
          ),
        ),

        // Container(
        //     height: 1,
        //     width: 500,
        //     color: Colors.black12
        //
        // ),
        SizedBox(height: 6,),

        Align(
          alignment: Alignment.topLeft,
          // padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('Latest Event', style: TextStyle(fontSize: 20)),
          ),
        ) ,

        SizedBox(height: 10),

        Container(
          height: 280,

          child:

          _isDataLoaded
              ? eventlist.length > 0
              ?

          ListView.builder(
              itemCount:  eventlist.length >= 5?5:eventlist.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder:  (BuildContext context, int index) {
                return


                  Padding(

                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),

                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => EventDetailScreen(event:eventlist[index], )),
                          );
                        },
                        child:

                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              eventlist[index].image != ''
                                  ?




                              Center(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: eventlist[index].image??"",
                                  // width: 400,
                                  height: 200,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              )
                                  :

                              Container(
                                height: MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.height * 0.2,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardTheme.color,
                                  borderRadius: new BorderRadius.all(
                                    new Radius.circular(MediaQuery.of(context).size.height * 0.17),
                                  ),
                                  border: new Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 3.0,
                                  ),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                              ),
                              SizedBox(height: 2,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(eventlist[index].title??"",    overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20, color: Colors.black),),
                              ),


                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                        ),
                      ));

              })
              :

          Center(
            child: Text(
              "Latest Event's Will Be Shown Here",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
          )
              : _shimmer(),
        )

      ],),
    );
  }



  // void _configureSelectNotificationSubject() {
  //   selectNotificationStream.stream.listen((String? payload) async {
  //     await Navigator.of(context).push(MaterialPageRoute<void>(
  //       builder: (BuildContext context) => PrayerPage(payload: payload,),
  //     ));
  //   });
  // }

  @override
  void dispose() {

   // selectNotificationStream.close();
    super.dispose();
  }



  // void listenToNotification() =>
  //     service.onNotificationClick.stream.listen(onNoticationListener);

  // void onNoticationListener(String? payload) {
  //   if (payload != null && payload.isNotEmpty) {
  //     print('payload $payload');
  //
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: ((context) => PrayerPage(payload: payload))));
  //   }
  // }

  _getEvent() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        if (_isRecordPending) {
          setState(() {
            _isMoreDataLoaded = true;
          });

          if (eventlist.isEmpty) {
            pageNumber = 1;
          } else {
            pageNumber++;
          }
          await apiHelper?.getEventList( pageNumber).then((result) {
            if (result != null) {
              if (result.resp_code == "00") {

                List<Event> _tList = result.recordList;

                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }

                eventlist.addAll(_tList);
                setState(() {
                  _isMoreDataLoaded = false;
                });
              } else {
                eventlist = [];
              }
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - eventListScreen.dart - _getServices():" + e.toString());
    }
  }



  _init() async {
    try {
      await _getEvent();
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isMoreDataLoaded) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          await _getEvent();
          setState(() {
            _isMoreDataLoaded = false;
          });
        }
      });
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - eventScreen.dart - _initFinal():" + e.toString());
    }
  }



  Widget _shimmer() {
    return Container(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Card(margin: EdgeInsets.only(top: 5, bottom: 5)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 220,
                              height: 20,
                              child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 120,
                              height: 40,
                              child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }









}
