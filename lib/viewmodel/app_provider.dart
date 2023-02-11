import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/response/megazone_response.dart';
import '../models/response/zone_response.dart';


final myprovider = ChangeNotifierProvider((ref) =>  AppViewModel());
class AppViewModel    extends ChangeNotifier {


  List<HopCategory> _megaZoneList = [];
  List<Zone> _zoneList = [];
  List<Area> _areaList = [];
  int? user_id;

  void setuserid(int id) {
    user_id = id;
    notifyListeners();
  }

  int getUserId(){
    notifyListeners();
    return user_id!;

  }

  List<Zone> getzone() {

    notifyListeners();
    return _zoneList ;
  }


  void setZone(List<Zone> zone){
    _zoneList = zone;
    notifyListeners();
  }


  List<Area> getArea() {

    notifyListeners();
    return _areaList ;
  }


  void setArea(List<Area> zone){
    _areaList = zone;
    notifyListeners();
  }




}