import 'package:flutter/material.dart';
import 'package:hopleaders/screens/testimonyDetailScreen.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../models/businessLayer/base.dart';
import '../models/response/viewtestimony_response.dart';
import '../widget/navbar.dart';

class ViewTestimony extends Base {


  @override
  _ViewTestimonyState createState() => _ViewTestimonyState();
}

class _ViewTestimonyState extends BaseState {
  bool _isDataLoaded = false;

  GlobalKey<ScaffoldState>? _scaffoldKey;

  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  ScrollController _scrollController = ScrollController();
  int pageNumber = 0;




  List<Testimony>  testimonylist = [];


 String?  date ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar:  AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Testimony and Visions', textAlign: TextAlign.center,),
      ),
      body: Column(
        children: [
          Text('Events',  textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontSize: 23, fontWeight: FontWeight.bold)),

          _isDataLoaded
              ? testimonylist.length > 0
              ?

          Expanded(
            child: ListView.builder(itemCount: testimonylist.length ,
                shrinkWrap: true,
                itemBuilder:  (BuildContext context, int index) {



                  final datetime =  DateTime.parse(testimonylist[index].createdAt!);
                   date = DateFormat('dd/MM/yyyy').format(datetime);
                  return


                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),

                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => TestimonyDetailScreen(testimony:testimonylist[index], )),
                            );
                          },
                          child:

                          Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(testimonylist[index].title??"", style: TextStyle(fontSize: 20, color: Colors.black),),
                                    SizedBox(height: 4,),
                                    Text(testimonylist[index].desc??"",  maxLines: 1,
                                      style: TextStyle(fontSize: 13, color: Colors.grey), overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [

                                                Container(

                                                  child: const Text("By: ",style: TextStyle(color: Colors.white),),
                                                ),
                                                Container(

                                                  child:  Text(testimonylist[index].name??"",style: TextStyle(color: Colors.white),),
                                                ),
                                                // Expanded(
                                                //
                                                //   child: Container(
                                                //
                                                //     color: Colors.lightGreenAccent,
                                                //     child: Text("By", style: TextStyle(fontSize: 12),),
                                                //   ),
                                                //
                                                // ),
                                                // Expanded(
                                                //   child: Container(
                                                //     width: 100,
                                                //       color: Colors.blue,
                                                //       child: Text(testimonylist[index].name??"", style: TextStyle(fontSize: 12),),
                                                //   ),
                                                //
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                                borderRadius: BorderRadius.all(Radius.circular(8))
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(date.toString(),style: TextStyle(color: Colors.white),),
                                            ))



                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Divider(thickness: 2,color: Colors.black12,),

                                  ],),
                              ),


                            ],
                          ),
                        ));

                }),
          )
              :

          Center(
            child: Text(
              "Latest Testimonies Will Be Shown Here",
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

  _getTestimony() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        if (_isRecordPending) {
          setState(() {
            _isMoreDataLoaded = true;
          });

          if (testimonylist.isEmpty) {
            pageNumber = 1;
          } else {
            pageNumber++;
          }
          await apiHelper?.getTestimonyList( pageNumber).then((result) {
            if (result != null) {
              if (result.resp_code == "00") {

                List<Testimony> _tList = result.recordList;

                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }

                testimonylist.addAll(_tList);
                setState(() {
                  _isMoreDataLoaded = false;
                });
              } else {
                testimonylist = [];
              }
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - testimonyListScreen.dart - _getServices():" + e.toString());
    }
  }



  _init() async {
    try {
      await _getTestimony();
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isMoreDataLoaded) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          await _getTestimony();
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
