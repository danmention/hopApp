import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hopleaders/widget/input_widget.dart';

import '../models/businessLayer/base.dart';
import '../widget/buttonWidget.dart';

class HopTestimony extends Base {


  @override
  _HopTestimonyState createState() => _HopTestimonyState();
}

class _HopTestimonyState extends BaseState {
  @override
  Widget build(BuildContext context) {
    return sc(Scaffold(
      appBar: AppBar(title: Text('Share Testimony'),),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SizedBox(height: 20,),
            InputWidget(


              topLabel: "Title",
              hintText: "Enter your title ",

            ),
            SizedBox(height: 20,),


            TextFormField(

              keyboardType: TextInputType.multiline,
              maxLines: 6,
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
                hintText: "Feedback Report ",
                hintStyle: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromRGBO(105, 108, 121, 0.7),
                ),
              ),
            ),
              SizedBox(height: 20,),
              Button(btnText:" Submit Testimony ",onClick: (){


                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => HomeScreen()));

                //nextScreen(context, 'home ');
              },),

          ],),
        ),
      )
      ,));
  }
}
