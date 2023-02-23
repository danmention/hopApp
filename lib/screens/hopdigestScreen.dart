
// ignore_for_file: prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


import 'package:shimmer/shimmer.dart';

import '../models/businessLayer/base.dart';

import '../models/eventModel.dart';
import '../models/response/hopdigest_response.dart';
import '../widget/navbar.dart';
import 'digestDetailScreen.dart';
import 'eventDetailScreen.dart';

class hopDigestScreen extends Base {


  @override
  _hopScreenState createState() => _hopScreenState();
}

class _hopScreenState extends BaseState {

  bool _isDataLoaded = false;

  GlobalKey<ScaffoldState>? _scaffoldKey;

  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  ScrollController _scrollController = ScrollController();
  int pageNumber = 0;


  List<HopDigestResponse> _hopDigestList = [];

  List<Event>  eventlist = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar:  AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Hop Digest', textAlign: TextAlign.center,),
      ),
      body: Column(
        children: [
          Text('Hop Digest',  textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,fontSize: 23, fontWeight: FontWeight.bold)),


          _isDataLoaded
              ? _hopDigestList.length > 0
              ?
          Expanded(
            // height: size.height * 0.3,
            // margin: EdgeInsets.only(top: 0),
            child: ListView.builder(
                itemCount: _hopDigestList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(

                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DigestDetailScreen(_hopDigestList[index])),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        //backgroundColor: Colors.purple,
                        child: Image.asset('assets/logo.png'),
                      ),
                      title: Text(_hopDigestList[index].title!, overflow: TextOverflow.ellipsis, ),
                      subtitle: Container(
                        width:200, child:
                          Text( "${_hopDigestList[index].desc}")

                      // Html(
                      //   data: _hopDigestList[index].desc,
                      //   // style: {
                      //   //   '#': Style(
                      //   //     fontSize: FontSize(12),
                      //   //     maxLines: 1,
                      //   //     textOverflow: TextOverflow.ellipsis,
                      //   //   ),
                      //   // },
                      // ),
                        //Text(_hopDigestList[index].desc!, overflow: TextOverflow.ellipsis, )



                      ),
                      trailing: const Icon(Icons.house),
                    ),
                  );
                  // return CardDigest(heading: digesttList[index].name,cardImage: 'assets/logo.png',subheading: digesttList[index].description,);
                }),
          )

              :

          Center(
            child: Text(
              "No Hop Digest ",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
          )
              : _shimmer()

        ],
      ),
    );
  }






  @override
  void initState() {
    super.initState();
    _init();
  }

  _getHopDigest() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        if (_isRecordPending) {
          setState(() {
            _isMoreDataLoaded = true;
          });

          if (_hopDigestList.isEmpty) {
            pageNumber = 1;
          } else {
            pageNumber++;
          }
          await apiHelper!.getHopDigest(pageNumber, ).then((result) {
            if (result != null) {
              if (result.resp_code == "00") {
                List<HopDigestResponse> _tList = result.recordList;

                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }

                _hopDigestList.addAll(_tList);
                setState(() {
                  _isMoreDataLoaded = false;
                });
              } else {
                _hopDigestList = [];
              }
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - homeScreen.dart - _getServices():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getHopDigest();
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isMoreDataLoaded) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          await _getHopDigest();
          setState(() {
            _isMoreDataLoaded = false;
          });
        }
      });
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - barberListScreen.dart - _initFinal():" + e.toString());
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
