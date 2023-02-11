import 'dart:async';
import 'dart:convert';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:hopleaders/models/businessLayer/global.dart' as global;

import '../models/businessLayer/base.dart';
import '../models/response/login_response.dart';

import '../widget/bottomNavigationWidget.dart';
import 'introScreen.dart';


class SplashScreen extends Base {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState {

  GlobalKey<ScaffoldState> _scaffoldKey =   GlobalKey<ScaffoldState>() ;
  bool isloading = true;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return promptExit();
      },
      child: sc(
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).primaryColor,
          body: Center(
            child: Image.asset(
              'assets/logowhite.png',
               width: 250,
              // height: double.infinity,
              // fit: BoxFit.cover,

            ),
          ),

          // Stack(
          //   fit: StackFit.expand,
          //   children: [
          //     Image.asset(
          //       'assets/logowhite.png',
          //       // width: double.infinity,
          //       // height: double.infinity,
          //       // fit: BoxFit.cover,
          //       filterQuality: FilterQuality.high,
          //     ),
          //     BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
          //       child: Container(
          //         width: double.infinity,
          //         height: double.infinity,
          //         color: Colors.black.withOpacity(0.5),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 100),
          //       child: Align(
          //         alignment: Alignment.topCenter,
          //         child: Column(
          //           children: [
          //             CircleAvatar(
          //               radius: 70,
          //               backgroundImage: AssetImage(
          //                 'assets/logowhite.png',
          //               ),
          //             ),
          //
          //           ],
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(bottom: 70, left: 10, right: 10),
          //       child: Align(
          //         alignment: Alignment.bottomCenter,
          //         child: RichText(
          //             textAlign: TextAlign.center,
          //             text: TextSpan(style: TextStyle(color: Colors.black45, fontSize: 18), children: [
          //               TextSpan(text: " Welcome to Agric Health",style: TextStyle(color: Colors.black45, fontSize: 18)),
          //               TextSpan(
          //                 text: "Get sponsor for your project",
          //                 style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
          //               ),
          //               TextSpan(text: " Let's go there", style: TextStyle(color: Colors.black, fontSize: 18))
          //             ])),
          //       ),
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }

  void init() async {
    try {
      await br?.getSharedPreferences();

      var duration = Duration(seconds: 3);

      Timer(duration, () async {
       // await _getMapBox();
        //global.appDeviceId = await FirebaseMessaging.instance.getToken();
       // await _getCurrency();
        bool isConnected = await br!.checkConnectivity();

        if (isConnected) {
          if (global.sp!.getString('currentUser') != null) {
            global.user = CurrentUser.fromJson(json.decode(global.sp?.getString("currentUser")??""));


              nextScreen(context, 'home');

            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) =>
            //         BottomNavigationWidget(
            //
            //         )
            //
            // ));



            // await getCurrentPosition().then((_) async {
            //   if (global.lat != null && global.lng != null) {
            //     setState(() {});
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) =>
            //             BottomNavigationWidget(
            //
            //         )
            //
            //     ));
            //   } else {
            //     hideLoader();
            //     showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please enable location permission to use this App');
            //   }
            // });
          } else {
           // await getCurrentPosition();

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IntroScreen(

                )));
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      });
    } catch (e) {
      print("Exception - splashScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }
}
