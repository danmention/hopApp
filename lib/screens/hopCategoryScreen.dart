import 'package:flutter/material.dart';
import 'package:hopleaders/models/response/megazone_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/businessLayer/base.dart';
import '../models/response/zone_response.dart';
import '../viewmodel/app_provider.dart';
import '../widget/buttonWidget.dart';
import '../widget/input_dropdown.dart';
import '../widget/input_widget.dart';
import 'package:hopleaders/viewmodel/app_provider.dart';
import 'package:hopleaders/models/businessLayer/global.dart' as global;


class ChooseCategory extends Base {
  ChooseCategory({this.user_id});

  final int? user_id;


  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends BaseState {
  TextEditingController megazone = new TextEditingController();

  FocusNode _fEmail = new FocusNode();
  FocusNode _fPassword = new FocusNode();
  bool _isRemember = false;
  bool _isPasswordVisible = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  bool _isDataLoaded = false;
  bool _isRecordPending = true;
  List<HopCategory> _megaZoneList = [];
  List<Zone> _zoneList = [];
  List<Area> _areaList = [];

  String? _selectedValue;
  HopCategory? _selectedCategory;
  Zone? selectedZone = Zone(title: 'Building equpment', url: '');
  Zone? _zoneselectedItem;
  Area? _areaselectedItem;
int? selected_area;
  @override
  void initState() {

    // _zoneselectedItem = _zoneList[0];
    // _areaselectedItem = _areaList[0];
    // _selectedCategory = _megaZoneList[0];
    _init();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final helloWorld = ref.watch(myprovider);

   //_zoneList = ref.watch(myprovider).getzone();

    return sc(Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                    ),

                    Text(
                      "Select Area",
                      style: Theme.of(context).primaryTextTheme.caption,
                    ),
                    SizedBox(height: 30.0),
                    SizedBox(height: 70.0),
                    _megaZoneList.isNotEmpty?
                    DropdownButtonFormField<HopCategory>(
                      hint: Text(
                        'choose Megazone',
                      ),
                      isExpanded: true,
                      onChanged: (value) {
                        print(value!.title.toString());
                        getZone(value.id.toString());

                      },
                      onSaved: null,
                      items: _megaZoneList.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value.title.toString(),
                          ),
                        );
                      }).toList(),
                    ): Container(),

                    // InputDropdown(
                    //
                    //   hintText: "Gender",
                    //   listOfValue:_megaZoneList,
                    //
                    //   onChanged: ( value) {
                    //     setState(() {
                    //       _selectedValue = value;
                    //       // state.didChange(newValue);
                    //       print(_selectedValue);
                    //     });
                    //   },
                    //   selectedValue:_selectedValue,
                    // ),

                    SizedBox(
                      height: 25.0,
                    ),

                  _zoneList.isNotEmpty?
                  DropdownButtonFormField<Zone>(

                      hint: Text(
                        'Choose Zone',
                      ),
                      isExpanded: true,
                      onChanged: (value) {
                        // _zoneselectedItem = value;
                        print(value!.title.toString());

                        getArea(value.id.toString());

                        // getZone(value.id.toString());
                        setState(() {});
                      },
                      items: _zoneList.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value.title.toString(),
                          ),
                        );
                      }).toList(),
                    ):Container(),
                    SizedBox(
                      height: 25.0,
                    ),


            _areaList.isNotEmpty?
            DropdownButtonFormField<Area>(

                      hint: Text(
                        'Choose Area',
                      ),
                      isExpanded: true,
                      onChanged: (value) {
                        print(value!.title.toString());

                        selected_area =value.id;

                        //getArea(value.id.toString());

                        //setState(() {});
                      },
                      items: _areaList.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value.title.toString(),
                          ),
                        );
                      }).toList(),
                    ):Container(),

                    SizedBox(
                      height: 65.0,
                    ),

                    Button(
                      btnText: " Submit ",
                      onClick: () {
                        if(selected_area==null){
                          showSnack(snackBarMessage: " Select your area from the dropdown");
                          return;
                        }

                       submit(ref.read(myprovider).getUserId(),selected_area);
                      //  submit(global.user.id,selected_area);
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (context) => HomeScreen()));

                        //nextScreen(context, 'home ');
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    ));
  }

  _getHopCategory() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        if (_isRecordPending) {
          await apiHelper?.getHopCategory().then((result) {
            hideLoader();
            if (result != null) {
              if (result.resp_code == "00") {
                List<HopCategory> _tList = result.data;

                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }

                _megaZoneList.addAll(_tList);

                setState(() {
                  //  _isMoreDataLoaded = false;
                });
              } else {
                _megaZoneList = [];
              }
            }
          });
        }
      } else {
        hideLoader();
        showNetworkErrorSnackBar(_scaffoldkey);

      }
    } catch (e) {
      print("Exception - hopCategoryScreen.dart - _getMegazone():" +
          e.toString());
    }
  }

  _init() async {
    try {
      await _getHopCategory();

      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - hopcatgory.dart - _initFinal():" + e.toString());
    }
  }

  void getZone(String? id) async {
    _zoneList.clear();
    _areaList.clear();
    setState(() { });
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        //   if (_isRecordPending) {

        await apiHelper?.getZone(id!).then((result) {
          if (result != null) {
            if (result.resp_code == "00") {
              List<Zone> _tList = result.data;

              print(_tList[0].title);

              ref.watch(myprovider).setZone(_tList);

              // if (_tList.isEmpty) {
              //   _isRecordPending = false;
              // }


              _zoneList.addAll(_tList);
              print(" goit here");
              setState(() { });

              // } else {
              //   _zoneList = [];
            }
          }
        });
        // }
      } else {
        showNetworkErrorSnackBar(_scaffoldkey);
      }
    } catch (e) {
      print("Exception - hopzonescreen.dart - _getzone():" + e.toString());
    }
  }

  void getArea(String? id) async {

    _areaList.clear();
    setState(() { });
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        // if (_isRecordPending) {

        await apiHelper?.getAreaList(id!).then((result) {
          if (result != null) {
            if (result.resp_code == "00") {
              List<Area> _tList = result.data;

              // if (_tList.isEmpty) {
              //   _isRecordPending = false;
              // }

             // ref.watch(myprovider).setArea(_tList);

              _areaList.addAll(_tList);

              setState(() {
                //  _isMoreDataLoaded = false;
              });

              // } else {
              //   _zoneList = [];
            }
          }
        });
        // }
      } else {
        showNetworkErrorSnackBar(_scaffoldkey);
      }
    } catch (e) {
      print("Exception - hopzonescreen.dart - _getarea():" + e.toString());
    }
  }


  void submit( user_id, selected_area) async {


    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        // if (_isRecordPending) {

        await apiHelper?.completeRegistration(user_id, selected_area).then((result) {
          if (result != null) {
            if (result.resp_code == "00") {

              nextScreen(context, 'login');

              showSnack(snackBarMessage: ' Registration Completed Successfully, Please Login');

             // List<Area> _tList = result.data;

              // if (_tList.isEmpty) {
              //   _isRecordPending = false;
              // }

              // ref.watch(myprovider).setArea(_tList);



              setState(() {
                //  _isMoreDataLoaded = false;
              });

              // } else {
              //   _zoneList = [];
            }
          }
        });
        // }
      } else {
        showNetworkErrorSnackBar(_scaffoldkey);
      }
    } catch (e) {
      print("Exception - hopzonescreen.dart - _getarea():" + e.toString());
    }
  }

  // void submit(){
  //
  // }

}
