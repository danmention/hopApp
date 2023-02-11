import 'package:flutter/material.dart';
import 'package:hopleaders/models/response/hopreport_response.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hopleaders/models/businessLayer/global.dart' as global;
import '../models/businessLayer/base.dart';
import '../widget/navbar.dart';

class ReportHistoryScreen extends Base {


  @override
  _ReportHistoryScreenState createState() => _ReportHistoryScreenState();
}

class _ReportHistoryScreenState extends BaseState{
  GlobalKey<ScaffoldState>? _scaffoldKey;
  bool _isDataLoaded = false;

  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  List<HopReport> _hopReportList = [];

  bool _isRecordPending = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Hop History', ),centerTitle: true,
        //automaticallyImplyLeading: false,
      ),
        body: _isDataLoaded
            ?_hopReportList.length>0 ?
        SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(children: [
           ListView.separated(
               separatorBuilder: (context, index) {
                 return Divider(color: Colors.black12,thickness: 1,);
               },
              itemCount: _hopReportList.length,
                shrinkWrap: true,
            itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(_hopReportList[index].hopSerialNumber!, style: Theme.of(context).primaryTextTheme.subtitle2 ,),
                    Container(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('NGN ${_hopReportList[index].offering}' ,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                    decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.all(Radius.circular(5))))
                  ],),

                  SizedBox(height: 10,),
                  Row(children: [Text(' Attendance :'), Text(_hopReportList[index].attendance!),],),

                 // Text(''),

                ],) ,
              ),
            );
            })
          ],),
        ),
        ):  Center(
          child: Text(
            "No Hop Report",
            style: Theme.of(context).primaryTextTheme.subtitle2,
          ),
        ):_shimmer(),);


  }


  _getReport() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        //  showOnlyLoaderDialog();
        if (_isRecordPending) {
          await apiHelper?.geReport(global.user.id!).then((result) {
            // hideLoader();
            if (result != null) {
              if (result.resp_code == "00") {
                List<HopReport> _tList = result.data;

                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }

                _hopReportList.addAll(_tList);

                setState(() {
                  //  _isMoreDataLoaded = false;

                });
              } else {
                _hopReportList = [];
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
      await _getReport();

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
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                child: Card(),
              ),
              SizedBox(
                height: 10,
              ),
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
                                  width: MediaQuery.of(context).size.width - 220,
                                  height: 40,
                                  child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 120,
                                  height: 40,
                                  child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }


}
