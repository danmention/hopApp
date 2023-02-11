
// ignore_for_file: prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../models/businessLayer/base.dart';

import '../models/eventModel.dart';
import 'eventDetailScreen.dart';

class EventScreen extends Base {


  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends BaseState {

  bool _isDataLoaded = false;

  GlobalKey<ScaffoldState>? _scaffoldKey;

  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  ScrollController _scrollController = ScrollController();
  int pageNumber = 0;




  List<Event>  eventlist = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        title: Text('Events', textAlign: TextAlign.center,),
      ),
      body: Column(
        children: [
          Text('Events',  textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,fontSize: 23, fontWeight: FontWeight.bold)),

          _isDataLoaded
              ? eventlist.length > 0
              ?

          Expanded(
            child: ListView.builder(itemCount: eventlist.length ,
                shrinkWrap: true,
                itemBuilder:  (BuildContext context, int index) {
              return


                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),

                  child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EventDetailScreen(event:eventlist[index], )),
                  );
                  },
                  child:

                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        eventlist[index].image != ''
                            ?




                        Center(
                          child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                            imageUrl: eventlist[index].image??"",
                              // width: 400,
                              height: 300,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        )
                            :

                        Container(
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: MediaQuery.of(context).size.height * 0.3,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: new BorderRadius.all(
                              new Radius.circular(MediaQuery.of(context).size.height * 0.17),
                            ),
                            border: new Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 3.0,
                            ),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                        SizedBox(height: 4,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(eventlist[index].title??"", style: TextStyle(fontSize: 20, color: Colors.black),),
                              SizedBox(height: 4,),
                              Text(eventlist[index].descriptions??"",  maxLines: 2,
                                style: TextStyle(fontSize: 13, color: Colors.grey), overflow: TextOverflow.ellipsis,)

                            ],),
                        ),


                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
              ));

            }),
          )
              :

          Center(
          child: Text(
          "Latest Event's Will Be Shown Here",
          style: Theme.of(context).primaryTextTheme.subtitle2,
          ),
          )
          : _shimmer(),
        ],
      ),
    );
  }






  @override
  void initState() {
    super.initState();
    _init();
  }

  _getEvent() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        if (_isRecordPending) {
          setState(() {
            _isMoreDataLoaded = true;
          });

          if (eventlist.isEmpty) {
            pageNumber = 1;
          } else {
            pageNumber++;
          }
          await apiHelper?.getEventList( pageNumber).then((result) {
            if (result != null) {
              if (result.resp_code == "00") {

                List<Event> _tList = result.recordList;

                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }

                eventlist.addAll(_tList);
                setState(() {
                  _isMoreDataLoaded = false;
                });
              } else {
                eventlist = [];
              }
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - eventListScreen.dart - _getServices():" + e.toString());
    }
  }



  _init() async {
    try {
      await _getEvent();
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isMoreDataLoaded) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          await _getEvent();
          setState(() {
            _isMoreDataLoaded = false;
          });
        }
      });
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - eventScreen.dart - _initFinal():" + e.toString());
    }
  }
  // Widget _shimmer() {
  //   return Padding(
  //     padding: const EdgeInsets.all(15),
  //     child: Shimmer.fromColors(
  //       baseColor: Colors.grey[300]!,
  //       highlightColor: Colors.grey[100]!,
  //       child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: 8,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Column(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     // CircleAvatar(
  //                     //   radius: 40,
  //                     //   child: Card(margin: EdgeInsets.only(top: 5, bottom: 5)),
  //                     // ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         SizedBox(
  //                           width: MediaQuery.of(context).size.width - 220,
  //                           height: 30,
  //                           child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
  //                         ),
  //                         SizedBox(
  //                           width: MediaQuery.of(context).size.width - 120,
  //                           height: 20,
  //                           child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //
  //               ],
  //             );
  //           }),
  //     ),
  //   );
  // }
  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            // CircleAvatar(
            //   radius: 60,
            //   child: Card(),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: Card(margin: EdgeInsets.only(top: 5, bottom: 5)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 250,
                                height: 40,
                                child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 150,
                                height: 40,
                                child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                              ),
                            ],
                          )
                        ],
                      ),

                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }


}
