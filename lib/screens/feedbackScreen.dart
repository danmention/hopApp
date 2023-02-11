import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hopleaders/widget/input_widget.dart';

import 'package:hopleaders/models/businessLayer/global.dart' as global;
import '../models/businessLayer/base.dart';
import '../widget/buttonWidget.dart';

class FeedbackScreen extends Base {


  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends BaseState {
  GlobalKey<ScaffoldState>? _scaffoldKey;

  TextEditingController _cdesc = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return sc(Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Ask Questions'),centerTitle: true,),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Text('Give Us Your Feedback', style: TextStyle(fontSize: 32),),
                SizedBox(height: 40,),


                TextFormField(
                  controller: _cdesc,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: InputDecoration(
                    // prefixIcon: prefixIcon == null ? prefixIcon : Icon(prefixIcon,
                    //   color: Color.fromRGBO(105, 108, 121, 1),
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(74, 77, 84, 0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    hintText: "Testimony Report ",
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(105, 108, 121, 0.7),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Button(btnText:" Submit Testimony ",onClick: (){

                  _save();
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => HomeScreen()));

                  //nextScreen(context, 'home ');
                },),

              ],),
          ),
        ),
      )
      ,));
  }




  _save() async {
    try {

     if (_cdesc.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: "Enter feedback details");
        return;
      }

      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper
            ?.submitQuestion(user_id: global.user.id.toString(),   desc: _cdesc.text)
            .then((result) {
          if (result != null) {
            if (result.resp_code == "00") {
              hideLoader();
              showSnackBar(snackBarMessage: ' Feedback  submitted successfully');
              //  global.user = result.data;

              //global.sp.setString('currentUser', json.encode(global.user.toJson()));
              Navigator.of(context).pop();

              setState(() {});
            } else {
              showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - submitreportscreen.dart - _save():" + e.toString());
    }
  }
}
