
import 'package:flutter/material.dart';
import 'package:hopleaders/models/businessLayer/global.dart' as global;

import '../models/businessLayer/baseRoute.dart';
import '../screens/eventScreen.dart';
import '../screens/homeScreen.dart';
import '../screens/allhopScreen.dart';
import '../screens/profileScreen.dart';

class BottomNavigationWidget extends BaseRoute {
  final int? screenId;
  BottomNavigationWidget({a, o, this.screenId}) : super(a: a, o: o, r: 'BottomNavigationWidget');
  @override
  _BottomNavigationWidgetState createState() => new _BottomNavigationWidgetState(screenId: screenId);
}

class _BottomNavigationWidgetState extends BaseRouteState {
  int? screenId = 0;
  int _currentIndex = 0;
  int locationIndex = 0;
  _BottomNavigationWidgetState({this.screenId}) : super();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = (screenId != null ? screenId : 0)!;
    if (screenId != null && screenId == 1) {
      locationIndex = screenId!;
      screenId = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: sc(Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            notchMargin: 2,
            shape: CircularNotchedRectangle(),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: SizedBox(
                height: 60,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  unselectedFontSize: 0,
                  selectedFontSize: 0,
                  onTap: (index) {
                    _currentIndex = index;
                    locationIndex = 0;
                    setState(() {});
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: '',
                      icon: Icon(Icons.home_outlined),
                      tooltip: 'Home',
                    ),
                    BottomNavigationBarItem(
                        label: '',
                        tooltip: 'Location',
                        icon: Padding(
                          padding: global.isRTL ? EdgeInsets.only(left: 15) : EdgeInsets.only(right: 15),
                          child: Icon(Icons.location_on_outlined),
                        )),
                    BottomNavigationBarItem(
                        label: '',
                        tooltip: 'Favourite',
                        icon: Padding(
                          padding: global.isRTL ? EdgeInsets.only(right: 15) : EdgeInsets.only(left: 15),
                          child: Icon(Icons.favorite_outline_outlined),
                        )),
                    BottomNavigationBarItem(label: '', icon: Icon(Icons.person_outline), tooltip: 'Profile')
                  ],
                ),
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.white,
          child: FloatingActionButton(
            elevation: 0,
            mini: true,
            backgroundColor: Color(0xFFFA692C),
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => BarberShopListScreen(a: widget.analytics, o: widget.observer)),
              // );
            },
            child: Icon(Icons.calendar_today_rounded),
          ),
        ),
        body: screens().elementAt(_currentIndex),
      )),
    );
  }

  List<Widget> screens() => [
        HomeScreen( ),
    EventScreen(),
        // LocationScreen(
        //   a: widget.analytics,
        //   o: widget.observer,
        //   screenId: locationIndex,
        // ),
        AllHopScreen(),
        ProfileScreen()
      ];
}
