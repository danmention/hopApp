import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hopleaders/models/response/hopdigest_response.dart';
import 'package:hopleaders/screens/digestDetailScreen.dart';
import 'package:hopleaders/screens/prayForHopScreen.dart';
import 'package:shimmer/shimmer.dart';

import '../models/DigestModel.dart';
import '../models/businessLayer/base.dart';
import '../models/eventModel.dart';
import '../utils/flutter_local_notification.dart';

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _isAndroidPermissionGranted();
    // _requestPermissions();
   // service = LocalNotificationService();
   // service.intialize();
    _init();
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





    var image = new Image.network("http://www.gstatic.com/webp/gallery/1.jpg");

var containerList = [
  TopMenu(title: 'Events', subtitle: ' View events', color: Colors.green, route: 'event', iconData: FontAwesomeIcons.bell),
  TopMenu(title: 'Latest Hop', subtitle: ' New Hop Near you', color: Colors.orange,route: 'allhop', iconData: FontAwesomeIcons.addressBook),
  TopMenu(title: 'Testify', subtitle: ' Share Testimony', color: Colors.red,route: 'sharetestimony', iconData: FontAwesomeIcons.bible,)
,
  TopMenu(title: 'Questions', subtitle: ' Send us a feedback', color: Colors.brown, route: '',iconData: FontAwesomeIcons.question,),

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
          Text('Top 5 Hop Winners of the week. ', style: Theme.of(context).primaryTextTheme.headline3,) ,
          SizedBox(height: 10,),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal:18.0),
            child: Button(btnText: 'See Monthly Winner\'s',onClick: (){
             // service.showNotification(id: 2, title: " we are here", body: " Building universal life" );
             nextScreen(context, 'winner');
            },),
          )
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




        // Container(
        //   child: SingleChildScrollView(
        //     scrollDirection: Axis.horizontal,
        //     child: Row(children: [
        //       winner,winner,winner,winner,winner
        //     ],),
        //   ),
        // ),

        Container(
            height: 1,
            width: 500,
            color: Colors.black12

        ),
        SizedBox(height: 6,),

        Align(
          alignment: Alignment.topLeft,
          // padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('Hop Digest', style: Theme.of(context).textTheme.bodyText1,),
          ),
        ) ,
        // GestureDetector(
        //     onTap: (){
        //
        //     // service.showNotification(id: 2, title: " we are here", body: " Building universal life" );
        //       service.showScheduledNotification(id: 2, title: " we are here", body: " Building universal life" , seconds: 5);
        //     }
        //     ,
        //     child: Text('Hop Digest')),

        // Container( height:
        //   size.height * 0.3,
        // ),
        SizedBox(height: 10),

        _isDataLoaded
            ? _hopDigestList.length > 0
            ?
        Expanded(
          // height: size.height * 0.3,
          // margin: EdgeInsets.only(top: 0),
          child: ListView.builder(
              itemCount: _hopDigestList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
                return InkWell(

                 onTap: (){
                   Navigator.of(context).push(
                     MaterialPageRoute(builder: (context) => DigestDetailScreen(_hopDigestList[index])),
                   );
                 },
                  child: ListTile(
                    leading: CircleAvatar(
                      //backgroundColor: Colors.purple,
                      child: Image.asset('assets/logo.png'),
                    ),
                    title: Text(_hopDigestList[index].title!, overflow: TextOverflow.ellipsis, ),
                    subtitle: Container(
                        width:200, child: Text(_hopDigestList[index].desc!, overflow: TextOverflow.ellipsis, )),
                    trailing: const Icon(Icons.house),
                  ),
                );
               // return CardDigest(heading: digesttList[index].name,cardImage: 'assets/logo.png',subheading: digesttList[index].description,);
              }),
        )

            :

        Center(
          child: Text(
            "No Hop Digest ",
            style: Theme.of(context).primaryTextTheme.subtitle2,
          ),
        )
            : _shimmer()
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


  _getHopDigest() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        if (_isRecordPending) {
          setState(() {
            _isMoreDataLoaded = true;
          });

          if (_hopDigestList.isEmpty) {
            pageNumber = 1;
          } else {
            pageNumber++;
          }
          await apiHelper!.getHopDigest(pageNumber, ).then((result) {
            if (result != null) {
              if (result.resp_code == "00") {
                List<HopDigestResponse> _tList = result.recordList;

                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }

                _hopDigestList.addAll(_tList);
                setState(() {
                  _isMoreDataLoaded = false;
                });
              } else {
                _hopDigestList = [];
              }
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - homeScreen.dart - _getServices():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getHopDigest();
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isMoreDataLoaded) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          await _getHopDigest();
          setState(() {
            _isMoreDataLoaded = false;
          });
        }
      });
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - barberListScreen.dart - _initFinal():" + e.toString());
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
