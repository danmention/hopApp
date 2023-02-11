import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hopleaders/models/response/viewtestimony_response.dart';

import '../widget/navbar.dart';

class TestimonyDetailScreen extends StatelessWidget {
   TestimonyDetailScreen({this.testimony}) ;
  Testimony? testimony;



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(' Event '),),
      drawer: NavDrawer(),
      body: Column(

        children: [




          Expanded(
            child: SingleChildScrollView(



              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(children: [

                    SizedBox(height: 30,),
                    Text(testimony!.title??" ", style: Theme.of(context).primaryTextTheme.caption, textAlign: TextAlign.center,),
                    SizedBox(height: 30,),

                    Html(
                      data: testimony!.desc,
                      style: {
                        '#': Style(
                          fontSize: FontSize(18),
                          // maxLines: 2,
                          // textOverflow: TextOverflow.ellipsis,
                        ),
                      },
                    ),
                    // Text(event!.descriptions??"", style: TextStyle(wordSpacing: 5),),
                  ],),
                ),
              ),),
          )



        ],),
    );
  }
}
