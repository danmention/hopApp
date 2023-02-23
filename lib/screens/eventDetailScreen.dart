import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hopleaders/models/eventModel.dart';

import '../widget/navbar.dart';

class EventDetailScreen extends StatelessWidget {
   EventDetailScreen({this.event}) ;
   Event? event;




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
             child: CachedNetworkImage(
               fit:BoxFit.cover ,
               // imageUrl: '${global.baseUrlForImage}${global.user.profileImage}',

               imageUrl: '${event?.image}',
               imageBuilder: (context, imageProvider) => Container(
                 height: 400,
                // width: MediaQuery.of(context).size.height * 0.17,

                 decoration: BoxDecoration(
                   color: Theme.of(context).cardTheme.color,

                   image: DecorationImage(image: imageProvider),

                 ),

               ),
               placeholder: (context, url) => Center(child: CircularProgressIndicator()),
               errorWidget: (context, url, error) => Icon(Icons.error),
             ),
           ),
           Expanded(
             child: SingleChildScrollView(



               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
                 child: SingleChildScrollView(
                   child: Column(children: [

                     SizedBox(height: 30,),
                     Text(event!.title??" ", style: Theme.of(context).primaryTextTheme.caption, textAlign: TextAlign.center,),
                     SizedBox(height: 30,),

                     // Html(
                     //   data: event!.descriptions,
                     //   // style: {
                     //   //   '#': Style(
                     //   //     fontSize: FontSize(18),
                     //   //     // maxLines: 2,
                     //   //     // textOverflow: TextOverflow.ellipsis,
                     //   //   ),
                     //   // },
                     // ),
                     Text(event!.descriptions??"", style: TextStyle(wordSpacing: 5),),
                   ],),
                 ),
               ),),
           )



         ],),
     );
   }
}
