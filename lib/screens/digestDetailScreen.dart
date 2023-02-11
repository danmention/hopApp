import 'package:flutter/material.dart';
import 'package:hopleaders/models/DigestModel.dart';
import 'package:hopleaders/models/response/hopdigest_response.dart';

import '../models/businessLayer/base.dart';
import '../widget/navbar.dart';

class DigestDetailScreen extends StatelessWidget {
  final HopDigestResponse digestModel;
  DigestDetailScreen(this.digestModel);



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text(' Digest'),),
      drawer: NavDrawer(),
      body: Container(
        child: Column(

          children: [
            Image.asset(
              "assets/prayer.jpg",
            ),

            Expanded(
              child: Container(


                // decoration: BoxDecoration(
                //   color: Colors.white10,
                //   borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(32.0),
                //       topRight: Radius.circular(32.0)),
                //
                // ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(children: [

                      SizedBox(height: 30,),
                      Text(digestModel.title!, style: Theme.of(context).primaryTextTheme.caption, textAlign: TextAlign.center,),
                      SizedBox(height: 30,),
                      Text(digestModel.desc!, style: TextStyle(wordSpacing: 5),),
                      SizedBox(height: 30,),
                    ],),
                  ),
                ),),
            )



        ],),
      ),
    );
  }
}
