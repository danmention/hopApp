import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hopleaders/models/request/login_request.dart';
import 'package:hopleaders/screens/signupScreen.dart';
import 'package:hopleaders/widget/buttonWidget.dart';
import 'package:hopleaders/models/businessLayer/global.dart' as global;
import '../models/businessLayer/base.dart';

import '../utils/constants.dart';
import '../widget/input_widget.dart';
import 'homeScreen.dart';

class SignInScreen extends Base {


  @override
  _SignInScrrenState createState() => _SignInScrrenState();
}

class _SignInScrrenState extends BaseState{




  //final _scaffoldKey2 = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> _scaffoldKey  = GlobalKey<ScaffoldState>();



  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  FocusNode _fEmail = new FocusNode();
  FocusNode _fPassword = new FocusNode();
  bool _isRemember = false;
  bool _isPasswordVisible = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return promptExit();
      },
      child: sc(
         Scaffold(
          // backgroundColor: Theme.of(context).primaryColor,
         // key: _scaffoldKey,
          body: Container(
            child: Stack(

              children: [

                Positioned(
                  right: 0.0,
                  top: -20.0,
                  child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      "assets/bg.png",
                    ),
                  ),
                ),
                SingleChildScrollView(child:
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                     key: _formkey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //SizedBox(height: 70,),

                          // Text(
                          //   "Welcome to HOP APP",
                          //   style: Theme.of(context).primaryTextTheme.caption,
                          // ),
                          SizedBox(height: 30.0),
                        Text(
                        "LogIn",
                          style: Theme.of(context).primaryTextTheme.caption,
                        ),
                          SizedBox(height: 70.0),
                          InputWidget(
                            textEditingController: _cEmail,

                            topLabel: "Email",
                            hintText: "Enter your email address",

                          ),



                    SizedBox(
                      height: 25.0,
                    ),
                    InputWidget(
                      textEditingController: _cPassword,
                      topLabel: "Password",
                      obscureText: true,
                      hintText: "Enter your password",
                    ),
                          SizedBox(
                            height: 65.0,
                          ),
                    Button(btnText:" Sign In ",onClick: (){

                      login();

                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (context) => HomeScreen()));

                      //nextScreen(context, 'home ');
                    },),
                    SizedBox(
                      height: 15.0,
                    ),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: GestureDetector(
                    //       onTap: () {},
                    //       child: Text(
                    //         "Forgot Password?",
                    //         textAlign: TextAlign.right,
                    //         style: TextStyle(
                    //           color: Theme.of(context).primaryColorLight,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),),
                    // ),
                        ]
                    ),
                  ),
                )
                  ,),
              ],
            ),
          ),
           bottomNavigationBar: Padding(
               padding: const EdgeInsets.only(top: 10, bottom: 10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(txt_you_dont_have_an_account, style: Theme.of(context).primaryTextTheme.subtitle1),
                   GestureDetector(
                       onTap: () {
                         FocusScope.of(context).unfocus();
                         Navigator.of(context).push(
                           MaterialPageRoute(builder: (context) => SignUpScreen()),
                         );
                       },
                       child: Text(lbl_sign_up, style: Theme.of(context).primaryTextTheme.headline5))
                 ],
               )),
        ),
      ),
    );
  }

  void login() async{
    try {
      Loginrequest _user = new Loginrequest();
      _user.email = _cEmail.text.trim();
      _user.password = _cPassword.text.trim();


    if (_cEmail.text.isNotEmpty && _cPassword.text.isNotEmpty && EmailValidator.validate(_cEmail.text) && _cPassword.text.trim().length >=6 ) {
        bool isConnected = await br!.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!.loginWithEmail(_user).then((result) async {
            if (result != null) {
              if (result.resp_code == "00") {
                global.user = result.recordList.user;
                global.token = result.recordList.tokenData;


                global.sp?.setString('currentUser', json.encode(global.user.toJson()));
                global.sp?.setString('currentToken', json.encode(global.token.toJson()));


                 hideLoader();
                // nextScreen(context, 'home');

                Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
                // if (_isRemember) {
                //   global.sp.setString('isRememberMeEmail', global.user.email);
                // }
                // await getCurrentPosition().then((_) async {
                //   if (global.lat != null && global.lng != null) {
                //     hideLoader();
                //
                //   } else {
                //     hideLoader();
                //     showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enablet_location_permission_to_use_app);
                //   }
                // });
              } else if(result.resp_code =="01" && result.resp_message.contains("please complete registration process"))
              {
                nextScreen(context, 'hopcategory');
              }

              else {
                hideLoader();



                if(result.errors[0].message != null){
                  showSnackBar(key: _scaffoldKey, snackBarMessage: result.errors[0].message.toString());
                }else{
                  showSnackBar(key: _scaffoldKey, snackBarMessage: result.message.toString());
                }
              }
            }
          });
        } else {
          //showNetworkErrorSnackBar(_scaffoldKey);
          showSnack(snackBarMessage:" No network connection" );
        }
      } else if (_cEmail.text.isEmpty) {
        //showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_email);
        //ScaffoldMessenger.of(context).showSnackBar(_snackBar);
        showSnack(snackBarMessage:txt_please_enter_your_email );

      } else if (_cEmail.text.isNotEmpty && !EmailValidator.validate(_cEmail.text)) {
       showSnack(snackBarMessage:txt_please_enter_your_valid_email );

       // showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_valid_email);
      } else if (_cPassword.text.isEmpty || _cPassword.text.trim().length < 5) {
        showSnack(
            snackBarMessage: txt_password_should_be_of_minimum_8_character);
       }
    } catch (e) {
      print("Exception - signInScreen.dart - _loginWithEmail():" + e.toString());
    }
  }
}
