
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hopleaders/screens/profileScreen.dart';
import 'package:hopleaders/screens/reportHistoryScreen.dart';
import 'package:hopleaders/screens/viewTestimonyScreen.dart';

import '../models/response/login_response.dart';
import '../screens/signInScreen.dart';
import '../utils/constants.dart';
import 'package:hopleaders/models/businessLayer/global.dart' as global;

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width*0.6,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset('assets/logowhite.png'),
            decoration: BoxDecoration(
                color:  Colors.blue,
                // image: DecorationImage(
                //     fit: BoxFit.fill,
                //     image: AssetImage('assets/images/cover.jpg'))

            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Home'),
            onTap: () => {
            Navigator.pushNamed(context, "home")
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {

              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ProfileScreen()),
              )


            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('History'),
            onTap: () => {
              Navigator.of(context).pop(),
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ReportHistoryScreen()),
            )
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Testimony / Visions'),
            onTap: () => {

              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ViewTestimony()),
              )


            },
          ),

          // ListTile(
          //   leading: Icon(Icons.),
          //   title: Text('Award'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {_signOutDialog(context)},
          ),
        ],
      ),
    );
  }


  _signOutDialog(BuildContext context ) async {
    try {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(dialogBackgroundColor: Colors.white),
              child: CupertinoAlertDialog(
                title: Text(
                  lbl_sign_out,
                ),
                content: Text(
                  txt_confirmation_message_for_sign_out,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      lbl_cancel,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      // Dismiss the dialog but don't
                      // dismiss the swiped item
                      return Navigator.of(context).pop(false);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(btn_sign_out),
                    onPressed: () async {
                      global.sp!.remove("currentUser");

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen()));
                      global.user = new CurrentUser();
                    },
                  ),
                ],
              ),
            );
          });
    } catch (e) {
      print('Exception - profileScreen.dart - exitAppDialog(): ' + e.toString());
    }
  }
}