import 'package:flutter/material.dart';
import 'package:hopleaders/models/response/login_response.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hopleaders/models/businessLayer/global.dart' as global;
import '../models/businessLayer/base.dart';


class AllHopScreen extends Base {


  @override
  _HopScreenState createState() => _HopScreenState();
}

class _HopScreenState extends BaseState {

  bool _isDataLoaded = false;

  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  List<CurrentUser> _hopLeadersList = [];

  bool _isRecordPending = true;
  List<CurrentUser> _foundUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('All Hop '),

        //automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search hop near you', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),

          _isDataLoaded
              ?_foundUsers.length>0 ?
          Expanded(

            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.black12,thickness: 1,);
                },

                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
                itemCount: _foundUsers.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),

                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_foundUsers[index].fullName!, style: Theme.of(context).primaryTextTheme.subtitle2 ,),
                              Container(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_foundUsers[index].availability??"", style: TextStyle(color: Colors.white, fontSize: 12),),
                              ),
                                decoration: BoxDecoration(color: Colors.blue,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),)
                            ],),

                          SizedBox(height: 5,),
                          Row(children: [Text(' Area :'), Text(_foundUsers[index].areaName??""),],),

                          // Text(''),

                        ],) ,

                  );
                }),
          ):
    Center(
            child: Text(
              "No Hop Report",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
          ):_shimmer()
          ],),
        ),
      )) ;





  }




  _getAllHop() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        //  showOnlyLoaderDialog();
        if (_isRecordPending) {
          await apiHelper?.geAllHop().then((result) {
            // hideLoader();
            if (result != null) {
              if (result.resp_code == "00") {
                List<CurrentUser> _tList = result.data;

                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }

                _hopLeadersList.addAll(_tList);

                setState(() {
                  //  _isMoreDataLoaded = false;

                });
              } else {
                _hopLeadersList = [];
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
      await _getAllHop();
      _foundUsers   =  _hopLeadersList;
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - winnerscreen.dart - _initFinal():" + e.toString());
    }
  }


  @override
  void initState() {
    _init();
    // TODO: implement initState
    super.initState();
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

  // Widget _shimmer() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: Shimmer.fromColors(
  //       baseColor: Colors.grey[300]!,
  //       highlightColor: Colors.grey[100]!,
  //       child: Column(
  //         children: [
  //           // CircleAvatar(
  //           //   radius: 60,
  //           //   child: Card(),
  //           // ),
  //
  //           ListView.builder(
  //               shrinkWrap: true,
  //               physics: NeverScrollableScrollPhysics(),
  //               itemCount: 5,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return Column(
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         SizedBox(
  //                           width: 80,
  //                           height: 80,
  //                           child: Card(margin: EdgeInsets.only(top: 5, bottom: 5)),
  //                         ),
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             SizedBox(
  //                               width: MediaQuery.of(context).size.width - 200,
  //                               height: 40,
  //                               child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
  //                             ),
  //                             SizedBox(
  //                               width: MediaQuery.of(context).size.width - 100,
  //                               height: 40,
  //                               child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
  //                             ),
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //
  //                   ],
  //                 );
  //               }),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _runFilter(String enteredKeyword) {
    List<CurrentUser> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _hopLeadersList;
    } else {
      results = _hopLeadersList
          .where((user) =>
          user.fullName!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

}
