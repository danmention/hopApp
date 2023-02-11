import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hopleaders/models/businessLayer/global.dart' as global;
import 'package:hopleaders/widget/navbar.dart';
import 'package:shimmer/shimmer.dart';
import '../models/businessLayer/base.dart';
import '../models/response/hopwinners_response.dart';

class WinnerScreen extends Base {


  @override
  _WinnerScreenState createState() => _WinnerScreenState();
}

class _WinnerScreenState extends BaseState{
  List<Winners> _winnersList = [];
  bool _isDataLoaded = false;
  bool _isRecordPending = true;
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(title: Text('Winner'),
        centerTitle: true,),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:18.0, vertical: 24),
          child: Column(children: [

            _isDataLoaded
                ? _winnersList.length > 0
                ?
              Expanded(
                child: ListView.builder(

                itemCount: _winnersList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index){
                  return  Column(
                    children: [
                      Container(

                        child: _winnersList[index].profileImage != ''
                            ? CachedNetworkImage(
                          imageUrl: _winnersList[index].profileImage??" ",
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 300,

                            width: 400,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.color,
                              borderRadius: new BorderRadius.all(
                                new Radius.circular(5),
                              ),
                              image: DecorationImage(image: imageProvider),
                              border: new Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        )
                            :


                        Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.height * 0.17,
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
                      ),
                      SizedBox(height: 20,),
                      Text(_winnersList[index].fullName!, style: Theme.of(context).primaryTextTheme.caption,),
                      Text(_winnersList[index].areaName!),
                      SizedBox(height: 10,),
                      Divider(
                        thickness: 0.6,
                          color: Colors.blueGrey
                      ),
                      SizedBox(height: 10,),
                    ],
                  );
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





          ],),
        ),
      ),
    );
  }



  _getWinners() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
      //  showOnlyLoaderDialog();
        if (_isRecordPending) {
          await apiHelper?.getWinnerCategory().then((result) {
          // hideLoader();
            if (result != null) {
              if (result.resp_code == "00") {
                List<Winners> _tList = result.data;

                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }

                _winnersList.addAll(_tList);

                setState(() {
                  //  _isMoreDataLoaded = false;

                });
              } else {
                _winnersList = [];
              }
            }
          });
        }
      } else {
       // hideLoader();
        showNetworkErrorSnackBar(_scaffoldkey);

      }
    } catch (e) {
      print("Exception - hopCategoryScreen.dart - _getMegazone():" +
          e.toString());
    }
  }


  _init() async {
    try {
      await _getWinners();

      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - winnerscreen.dart - _initFinal():" + e.toString());
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
  @override
  void initState() {
    _init();
    // TODO: implement initState
    super.initState();
  }
}
