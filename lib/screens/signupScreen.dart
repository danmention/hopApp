import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hopleaders/models/request/signup_request.dart';
import 'package:hopleaders/models/response/megazone_response.dart';
import 'package:hopleaders/screens/signInScreen.dart';
import 'package:hopleaders/viewmodel/app_provider.dart';
import 'package:hopleaders/widget/input_dropdown.dart';

import '../models/businessLayer/base.dart';
import '../utils/constants.dart';
import '../widget/buttonWidget.dart';
import '../widget/input_widget.dart';
import 'hopCategoryScreen.dart';

class SignUpScreen extends Base {


  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends BaseState{

  GlobalKey<ScaffoldState>? _scaffoldKey;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  String? _selectedValue;
  List<String> listOfValue = ['1', '2', '3', '4', '5'];
  String? birthDateInString;
  DateTime? birthDate;
  bool?  isDateSelected ;
  bool _isPasswordVisible = true;

  TextEditingController _cName = new TextEditingController();
  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cMobile = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  TextEditingController _cDOB= new TextEditingController();
  TextEditingController _cReferralCode = new TextEditingController();
  FocusNode _fReferralCode = new FocusNode();
  FocusNode _fName = new FocusNode();
  FocusNode _fEmail = new FocusNode();
  FocusNode _fMobile = new FocusNode();
  FocusNode _fPassword = new FocusNode();

  SignupRequest signupRequest = SignupRequest();


  @override
  Widget build(BuildContext context) {
    signupRequest.gender = 'Male' ;
final provider = ref.watch(myprovider);

    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pop();
        return false;

      },
      child: sc(
        Scaffold(
          // backgroundColor: Theme.of(context).primaryColor,
          key: _scaffoldKey,
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
                          SizedBox(height: 70,),

                         Text(
                            "Create Account",
                            style: Theme.of(context).primaryTextTheme.caption,
                          ),
                          SizedBox(height: 70.0),

                          InputWidget(
                            topLabel: "Full Name",
                           textEditingController: _cName,
                            hintText: "Enter your full name",
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          InputWidget(

                           textEditingController: _cEmail,
                            topLabel: "Email",
                            hintText: "Enter your email address",
                          ),



                          SizedBox(
                            height: 25.0,
                          ),

                          InputWidget(

                            textEditingController: _cMobile,
                            topLabel: "Phone Number",
                            hintText: "Enter your phone number",
                          ),



                          SizedBox(
                            height: 25.0,
                          ),

                          Row(children: [
                            Expanded(child:
                            Container(

                           child:   Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Row(

                               children: [
                                  Text(birthDateInString ?? " Date of Birth"), SizedBox(width: 5,),
                                  GestureDetector(
                                      child: new Icon(Icons.calendar_today),
                                      onTap: ()async{
                                        final datePick= await showDatePicker(
                                            context: context,
                                            initialDate: new DateTime.now(),
                                            firstDate: new DateTime(1900),
                                            lastDate: new DateTime(2100)
                                        );
                                        if(datePick!=null && datePick!=birthDate){
                                          setState(() {
                                            birthDate=datePick;
                                            isDateSelected= true;

                                            // put it here
                                            birthDateInString = "${birthDate!.day}-${birthDate!.month}-${birthDate!.year}"; // 08/14/2019

                                            signupRequest.dateOfBirth = birthDateInString;

                                            print(birthDateInString);

                                          });
                                        }
                                      }
                                  ) ,
                              ],
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             ),
                           ),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.black12,),

                                borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                                  ),


                              ),

                          )

                         ),
                            SizedBox(width: 5,),
                            Expanded(child:   InputDropdown(

                            hintText: "Gender",
                            listOfValue: ["Male", "Female"],

                            onChanged: (String? value) {
                              setState(() {
                                _selectedValue = value;
                                // state.didChange(newValue);
                                signupRequest.gender = value;
                                print(_selectedValue);
                              });
                            },
                            selectedValue:_selectedValue,
                          ) ,)



                          ],),




                          SizedBox(
                            height: 25.0,
                          ),
                            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Password"),
                  SizedBox(height: 5.0),
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      height: 50,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        autofocus: false,
                        cursorColor: Color(0xFFFA692C),
                        enabled: true,
                        obscureText: _isPasswordVisible,
                        style: Theme.of(context).primaryTextTheme.headline6,
                        controller: _cPassword,
                        focusNode: _fPassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: IconTheme.of(context).color),
                              onPressed: () {
                                _isPasswordVisible = !_isPasswordVisible;
                                setState(() {});
                              },
                            ),
                            hintText: hnt_password),
                        // onEditingComplete: () {
                        //   _fConfirmPassword.requestFocus();
                        // },
                      )),
              ],),
                          SizedBox(
                            height: 25.0,
                          ),
  //
  //                         DropdownButtonFormField(
  //
  //                           hint: Text(
  //                             'choose one',
  //                           ),
  //                           isExpanded: true,
  //
  //                           items: listOfValue
  //                               .map((String value) {
  //                             return DropdownMenuItem(
  //                               value: value,
  //                               child: Text(
  //                                 value,
  //                               ),
  //                             );
  //                           }).toList(), onChanged: (Object? value) {  },
  //                         ),
  //
  //
  // SizedBox(height: 15,),
  // DropdownButtonFormField(
  //
  //   hint: Text(
  //     'choose one',
  //   ),
  //   isExpanded: true,
  //
  //   items: listOfValue
  //       .map((String value) {
  //     return DropdownMenuItem(
  //       value: value,
  //       child: Text(
  //         value,
  //       ),
  //     );
  //   }).toList(), onChanged: (Object? value) {  },
  // ),


                          // InputDropdown(
                          //
                          //   hintText: "Select State ",
                          //   listOfValue: listOfValue,
                          //
                          //   onChanged: (String? value) {
                          //     setState(() {
                          //       _selectedValue = value;
                          //       // state.didChange(newValue);
                          //       print(_selectedValue);
                          //     });
                          //   },
                          //   selectedValue:_selectedValue,
                          // ),
                          SizedBox(
                            height: 65.0,
                          ),


                          Button(btnText:" Create Account ",onClick: (){

                            _signUp()
;                          },),
                          SizedBox(
                            height: 15.0,
                          ),

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
                  Text(txt_you_already_have_account, style: Theme.of(context).primaryTextTheme.subtitle1),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                        );
                      },
                      child: Text(lbl_sign_in, style: Theme.of(context).primaryTextTheme.headline5))
                ],
              )),

        ),
      ),
    );
  }


  _signUp() async {
    try {




      signupRequest.fullname = _cName.text.trim();
      signupRequest.email = _cEmail.text.trim();
      signupRequest.phone = _cMobile.text.trim();
      signupRequest.password = _cPassword.text.trim();
      signupRequest.streetAddress = " street";
      signupRequest.state = " state address";
      signupRequest.city = " city address";


      // if (_cName.text.isNotEmpty &&
      //     EmailValidator.validate(_cEmail.text) && _cEmail.text.isNotEmpty && _cMobile.text.isNotEmpty && _cMobile.text.trim().length == 10 && _cPassword.text.isNotEmpty &&
      //     _cPassword.text.trim().length >= 6
      //
      //     )


     if (_cName.text.isEmpty) {
    showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_name);
    return;
    } else if (_cEmail.text.isEmpty) {
    showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_email);
    return;
    } else if (_cEmail.text.isNotEmpty && !EmailValidator.validate(_cEmail.text)) {
    showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_valid_email);
    return;
    } else if (_cMobile.text.isEmpty || (_cMobile.text.isNotEmpty && _cMobile.text.trim().length < 10)) {
    showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_valid_mobile_number);
    return;
    } else if (_cPassword.text.isEmpty) {
    showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_password);
    return;
    } else if (_cPassword.text.isNotEmpty && _cPassword.text.trim().length < 6) {
    showSnackBar(key: _scaffoldKey, snackBarMessage: txt_password_should_be_of_minimum_8_character);
    return;
    }


        bool isConnected = await br!.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper?.signUp(signupRequest).then((result) async {
            if (result != null) {


              if (result.resp_code == "00" ) {

                hideLoader();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ChooseCategory(user_id:result.recordList.id ,)),
                // );
                ref.read(myprovider).setuserid(result.recordList.id );
                nextScreen(context, 'hopcategory');

              //  await _sendOTP(_cMobile.text.trim());
              } else {
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
          showNetworkErrorSnackBar(_scaffoldKey!);
        }



    } catch (e) {
      print("Exception - signUpScreen.dart - _signUp():" + e.toString());
    }
  }
}