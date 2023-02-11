import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hopleaders/widget/input_widget.dart';
import 'package:hopleaders/models/businessLayer/global.dart' as global;
import '../models/businessLayer/base.dart';
import '../widget/buttonWidget.dart';

class HopTestimony extends Base {


  @override
  _HopTestimonyState createState() => _HopTestimonyState();
}

class _HopTestimonyState extends BaseState {

  GlobalKey<ScaffoldState>? _scaffoldKey;
  TextEditingController _ctitle = new TextEditingController();
  TextEditingController _cdesc = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return sc(Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Share Testimony'),),
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
              InputWidget(
                textEditingController: _ctitle,


                topLabel: "Title",
                hintText: "Enter your title ",

              ),
              SizedBox(height: 20,),


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
      // FocusScope.of(context).unfocus();
      // global.user.user_name = _cName.text;
      // global.user.user_password = _cPassword.text.isEmpty ? null : _cPassword.text;

      if (_ctitle.text.isEmpty  ) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: "Enter Title ");
        return;
      } else if (_cdesc.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: "Enter details of the testimony");
        return;
      }

      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper
            ?.submitTestimony(user_id: global.user.id.toString(), title: _ctitle.text,  desc: _cdesc.text)
            .then((result) {
          if (result != null) {
            if (result.resp_code == "00") {
              hideLoader();
              showSnackBar(snackBarMessage: ' Testimony  submitted successfully');
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
