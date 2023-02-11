import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hopleaders/widget/buttonWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../models/businessLayer/base.dart';
import '../models/businessLayer/businessRule.dart';
import 'package:hopleaders/models/businessLayer/global.dart' as global;
import '../widget/input_widget.dart';

class SubmitReportScreen extends Base {


  @override
  _SubmitReportScreenState createState() => _SubmitReportScreenState();
}

class _SubmitReportScreenState extends BaseState{
  BusinessRule? br;
  File? _tImage;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  TextEditingController _cAttendance = new TextEditingController();
  TextEditingController _cfeedback = new TextEditingController();
  TextEditingController _cfirstTimer = new TextEditingController();
  TextEditingController _cOffering = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Submit Report'),),
      body: SingleChildScrollView(child:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 19),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: 30,),
          // InputWidget(
          //   topLabel: "Seial Number",
          //   hintText: global.user.identity,
          // ),
          Text('Serial Number'),
          SizedBox(height: 10,),
          Container(
            child: Text('${global.user.identity}'),
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              //border: Border.all(width: 1)

            ),),

          SizedBox(height: 20,),

          Align(
              alignment: Alignment.topLeft,
              child: Text('Leaders Name' )),
          SizedBox(height: 5,),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${global.user.fullName}', textAlign: TextAlign.left,)),
            ),
            height: 45,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(width: 1, color: Color.fromRGBO(74, 77, 84, 0.2),)

            ),),

          // InputWidget(
          //   topLabel: "Leaders Name ",
          //   hintText: "Enter your number of attendance",
          // ),
          SizedBox(height: 20,),
          InputWidget(
            textEditingController: _cAttendance,
            keyboardInputType: TextInputType.number,
            topLabel: "Attendance ",
            hintText: "Enter your number of attendance",
          ),



          SizedBox(height: 20,),
          InputWidget(
            textEditingController: _cfirstTimer,
            keyboardInputType: TextInputType.number,
            topLabel: "No First timers ",
            hintText: "Enter your number of attendance",
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){

              showImagePicker(context);

            },
            child: Center(
              child: _image != null? Image.file(_image!, height: 155,):  Container(
                height: 155,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset('assets/cloud.png',width: 49.0, height: 49,),
                    const SizedBox(height: 10,),
                    Text('Upload a picture')
                  ],
                ),
              ),
            ),
          ),

          // InkWell(
          //   onTap: (){
          //     _showCupertinoModalSheet();
          //   },
          //   child: Container(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         SizedBox(child: Icon(Icons.camera_alt, ), width: 100,),
          //         Text('Clik to Add Image', style: TextStyle(color: Colors.black),)
          //       ],
          //     ),
          //     decoration: BoxDecoration(
          //       color: Colors.grey
          //     ),
          //     width: 200,
          //     height: 200,
          //   ),
          // ),
          SizedBox(height: 20,),

          InputWidget(
            keyboardInputType: TextInputType.number,
            textEditingController: _cOffering,
            inputType: true,
            topLabel: "Offering ",
            hintText: "Enter your number of offering",
          ),
          SizedBox(height: 20,),


          TextFormField(
            controller: _cfeedback,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
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
          SizedBox(height: 30,),
          Button(btnText: 'Submit Report', onClick: (){
            _save();
          },)
        ],),
      )
      ,),);
  }


  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(" Select Image"),
          actions: [
            CupertinoActionSheetAction(
              child: Text("Take a picture", style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br?.openCamera();
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text("Choose from gallery", style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br?.selectImageFromGallery();
                hideLoader();

                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text("Cancel", style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - accountSettingScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }

  File? _image;

  Future getImage(ImageSource imageSource, BuildContext context)async{
    try {
      final image = await ImagePicker().pickImage(source: imageSource,
        // maxHeight: 150.0,
        maxWidth: 350.0,

      );
      if (image == null) {
        return;
      }else{
        print(image.path.toString());
        final imageTemporary = File(image.path);


        setState(() {
          _image = imageTemporary;
        });
      }
      Navigator.of(context).pop();


    } catch(e){
      print("error::::::::: $e");
    }
  }



  _save() async {
    try {
      // FocusScope.of(context).unfocus();
      // global.user.user_name = _cName.text;
      // global.user.user_password = _cPassword.text.isEmpty ? null : _cPassword.text;

   if (_cAttendance.text.isEmpty  ) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: "Enter Your Attendance ");
        return;
      } else if (_image == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: "Snap your your cell meeting");
        return;
      }

      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper
            ?.submitReport(id: global.user.id.toString(), attendance:_cAttendance.text , user_image: _image,
          no_of_first_timers:_cfirstTimer.text,    offering:_cOffering.text,time_of_meeting: " ",   desc: _cfeedback.text)
            .then((result) {
          if (result != null) {
            if (result.resp_code == "00") {
              hideLoader();
              showSnackBar(snackBarMessage: ' Hop Report submitted successfully');
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






  // Future <File> saveFilePermanently(String imagepath)async{
  //   final directory = await getApplicationDocumentsDirectory();
  //
  //   final name = basename(imagepath);
  //   final image = File('${directory.path}/$name');
  //   print(image);
  //   return File(imagepath).copy(image.path);
  // }

  void showImagePicker(BuildContext context) {

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              onTap: (){
                getImage(ImageSource.camera, context);
              },
              leading: Icon(Icons.camera),
              title: Text('Use Camera'),
            ),
            ListTile(
              onTap: (){
                getImage(ImageSource.gallery, context);
              },
              leading: Icon(Icons.picture_in_picture),
              title: Text('Choose Gallery'),
            ),

          ],
        );
      },
    );


  }

}
