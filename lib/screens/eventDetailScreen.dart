import 'package:flutter/material.dart';
import 'package:hopleaders/models/eventModel.dart';

import '../widget/navbar.dart';

class EventDetailScreen extends StatelessWidget {
   EventDetailScreen({this.event}) ;
   Event? event;




   @override
   Widget build(BuildContext context) {


     return Scaffold(
       appBar: AppBar(title: Text(' Event '),),
       drawer: NavDrawer(),
       body: Container(
         child: Column(

           children: [
             Image.asset(
                 event?.image??" "
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
                       Text(event!.title??" ", style: Theme.of(context).primaryTextTheme.caption, textAlign: TextAlign.center,),
                       SizedBox(height: 30,),
                       Text(event!.descriptions??"", style: TextStyle(wordSpacing: 5),),
                     ],),
                   ),
                 ),),
             )



           ],),
       ),
     );
   }
}
