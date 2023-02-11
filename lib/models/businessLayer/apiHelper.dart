import 'dart:convert';
import 'dart:io';
import 'package:hopleaders/models/businessLayer/global.dart' as global;


import 'package:dio/dio.dart';
import 'package:hopleaders/models/request/signup_request.dart';
import 'package:hopleaders/models/response/megazone_response.dart';
import 'package:http/http.dart' as http;

import '../eventModel.dart';
import '../request/login_request.dart';
import '../response/UserResponseModel.dart';
import '../response/hopdigest_response.dart';
import '../response/hopreport_response.dart';
import '../response/hopwinners_response.dart';
import '../response/login_response.dart';
import '../response/registeration_complete_response.dart';
import '../response/signup_response.dart';
import '../response/testimony_response.dart';
import '../response/viewtestimony_response.dart';
import '../response/zone_response.dart';
import '../termsAndConditionModel.dart';

import 'apiResult.dart';
import 'dioResult.dart';



class APIHelper {

  dynamic getAPIResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = APIResult.fromJson(json.decode(response.body), recordList);
      return result;
    } catch (e) {
      print("Exception - getAPIResult():" + e.toString());
    }
  }


  dynamic getDioResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = DioResult.fromJson(response, recordList);
      return result;
    } catch (e) {
      print("Exception - getDioResult():" + e.toString());
    }
  }


  Future<dynamic> addSalonRating(int user_id, int vendor_id, double rating, String description) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}add_salon_rating"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "user_id": user_id,
          "vendor_id": vendor_id,
          "rating": rating,
          "description": description,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - addSalonRating(): " + e.toString());
    }
  }

  Future<dynamic> addStaffRating(int user_id, int staff_id, double rating, String description) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}add_staff_rating"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "user_id": user_id,
          "staff_id": staff_id,
          "rating": rating,
          "description": description,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - addStaffRating(): " + e.toString());
    }
  }






  Future<dynamic> cancelBooking(String cart_id, String reason) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}cancel_booking"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"cart_id": cart_id, "reason": reason}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - cancelBooking(): " + e.toString());
    }
  }

  Future<dynamic> cancelOrder(String cart_id, String reason) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}cancel_product_orders"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"cart_id": cart_id, "reason": reason}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - cancelOrder(): " + e.toString());
    }
  }

  Future<dynamic> changePassword(String user_email, String user_password) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}change_password"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"user_email": user_email, "user_password": user_password}),
      );

      dynamic recordList;
      if (response.statusCode == 200 && jsonDecode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - changePassword(): " + e.toString());
    }
  }



  Future<dynamic> deleteAllNotifications(int user_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}delete_all_notifications"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"user_id": user_id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - deleteAllNotifications(): " + e.toString());
    }
  }

  // Future<dynamic> delFromCart(int user_id, int product_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}del_frm_cart"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": user_id, "product_id": product_id}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = Cart.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - delFromCart(): " + e.toString());
  //   }
  // }

  Future<dynamic> forgotPassword(String user_email) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}forget_password"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"user_email": user_email}),
      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body) != null && json.decode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - forgotPassword(): " + e.toString());
    }
  }

  // Future<dynamic> getAllBookings(int user_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}all_booking"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": user_id, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<AllBookings>.from(json.decode(response.body)["data"].map((x) => AllBookings.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getAllBookings(): " + e.toString());
  //   }
  // }



  // Future<dynamic> getHopCategory() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}barber_desc"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({"staff_id": staff_id, }),
  //     );
  //
  //     dynamic recordList;
  //
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = PopularBarbers.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getBarbersDescription(): " + e.toString());
  //   }
  // }



  Future<dynamic> getHopCategory() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}hop-category',

          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200 && response.data["resp_code"] == "00") {
        recordList = List<HopCategory>.from(response.data["data"].map((x) => HopCategory.fromJson(x)));
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getCancelReasons(): " + e.toString());
    }
  }








  Future<dynamic> getWinnerCategory() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}user/winners-of-the-week/all',

          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200 && response.data["resp_code"] == "00") {
        recordList = List<Winners>.from(response.data["data"]["data"].map((x) => Winners.fromJson(x)));
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getCancelReasons(): " + e.toString());
    }
  }



  Future<dynamic> geReport(int id) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'user_id': id});

      response = await dio.get('${global.baseUrl}user/report?user_id=$id',
         // data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200 && response.data["resp_code"] == "00") {


        recordList = List<HopReport>.from(response.data["data"]["data"].map((x) => HopReport.fromJson(x)));

      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);



    } catch (e) {
      print("Exception - getReport(): " + e.toString());
    }
  }




  Future<dynamic> geAllHop() async {
    try {
      Response response;
      var dio = Dio();


      response = await dio.get('${global.baseUrl}user/hop-leaders',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200 && response.data["resp_code"] == "00") {


        recordList = List<CurrentUser>.from(response.data["data"]["data"].map((x) => CurrentUser.fromJson(x)));

      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);



    } catch (e) {
      print("Exception - getReport(): " + e.toString());
    }
  }








  Future<dynamic> getAllZone2(String id) async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}hop-category',

          options: Options(
            headers: await global.getApiHeaders(true),
          ));


      dynamic recordList;
      if (response.statusCode == 200 && response.data["resp_code"] == "00") {

        recordList = List<HopCategory>.from(response.data["data"].map((x) => HopCategory.fromJson(x)));

      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getCancelReasons(): " + e.toString());
    }
  }

  Future<dynamic> getAllZone(String id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}hop-category/by-parent"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"id": id, }),
      );


      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body)["resp_code"] == "00") {

        recordList = List<Zone>.from(json.decode(response.body)["data"].map((x) => Zone.fromJson(x)));



      } else {
        recordList = null;
      }

      return getAPIResult(response.body, recordList);

    } catch (e) {
      print("Exception - getAllZone: " + e.toString());
    }
  }




  Future<dynamic> getZone(String id) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
      'id': id});

      response = await dio.post('${global.baseUrl}hop-category/by-parent',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200 && response.data["resp_code"] == "00") {


        recordList = List<Zone>.from(response.data["data"].map((x) => Zone.fromJson(x)));

      } else {
        recordList = null;
      }
     return getDioResult(response, recordList);



    } catch (e) {
      print("Exception - getzoneReasons(): " + e.toString());
    }
  }


  Future<dynamic> getAreaList(String id) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'id': id});

      response = await dio.post('${global.baseUrl}hop-category/by-parent',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200 && response.data["resp_code"] == "00") {


        recordList = List<Area>.from(response.data["data"].map((x) => Area.fromJson(x)));

      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);



    } catch (e) {
      print("Exception - getzoneReasons(): " + e.toString());
    }
  }




  Future<dynamic> getHopDigest( int pageNumber, ) async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}user/weekly-digest/all?page=${pageNumber.toString()}"),
        headers: await global.getApiHeaders(true),

      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body)["resp_code"] == "00") {
        recordList = List<HopDigestResponse>.from(json.decode(response.body)["data"]["data"].map((x) => HopDigestResponse.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getHopDigest(): " + e.toString());
    }
  }



  Future<dynamic> completeRegistration(int user_id, int area_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}user/update-setup"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "user_id": user_id,
          "area_id": area_id,

        }),
      );


      dynamic recordList;

      if (response.statusCode == 200 && json.decode(response.body)["resp_code"] == "00") {
        recordList = SignupCompleteResponse.fromJson(json.decode(response.body)["data"]);

      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);



    } catch (e) {
      print("Exception - addStaffRating(): " + e.toString());
    }
  }



  // Future<dynamic> getCurrency() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse("${global.baseUrl}currency"),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = Currency.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getCurrency(): " + e.toString());
  //   }
  // }



  // Future<dynamic> getFavoriteList(int user_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}show_fav"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": user_id, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = Favorites.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getFavoriteList(): " + e.toString());
  //   }
  // }

  // Future<dynamic> getGoogleMap() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse("${global.baseUrl}google_map"),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = GoogleMapModel.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getGoogleMap(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getMapBox() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse("${global.baseUrl}mapbox"),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = MapBoxModel.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getMapBox(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getMapGateway() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse("${global.baseUrl}mapby"),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = MapByModel.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getMapGateway(): " + e.toString());
  //   }
  // }

  // Future<dynamic> getNearByBanners(String lat, String lng) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}getnearbanner"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({
  //         "lat": lat,
  //         "lng": lng,
  //
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<BannerModel>.from(json.decode(response.body)["data"].map((x) => BannerModel.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getNearByBanners(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getNearByBarberShops(String lat, String lng, int pageNumber, {String searchstring}) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}getnearbysalons?page=${pageNumber.toString()}"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({
  //         "lat": lat,
  //         "lng": lng,
  //         "searchstring": searchstring,
  //         "lang": global.languageCode,
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<BarberShop>.from(json.decode(response.body)["data"].map((x) => BarberShop.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getNearByBarberShops(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getNearByCouponsList(String lat, String lng) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}getnearcouponlist"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"lat": lat, "lng": lng, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<Coupons>.from(json.decode(response.body)["data"].map((x) => Coupons.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getNearByCouponsList(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getNotifications(int user_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}allnotifications"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({
  //         "user_id": user_id,
  //
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<NotificationList>.from(json.decode(response.body)["data"].map((x) => NotificationList.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getNotifications(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getPaymentGateways() async {
  //   try {
  //     final response = await http.get(Uri.parse("${global.baseUrl}payment_gateways"), headers: await global.getApiHeaders(true));
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = PaymentGateway.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getPaymentGateways(): " + e.toString());
  //   }
  // }

  // Future<dynamic> getPopularBarbersList(String lat, String lng, int pageNumber, String searchstring) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}popular_barber?page=${pageNumber.toString()}"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({
  //         "lat": lat,
  //         "lng": lng,
  //         "searchstring": searchstring,
  //         "lang": global.languageCode,
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<PopularBarbers>.from(json.decode(response.body)["data"].map((x) => PopularBarbers.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getPopularBarbersList(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getProductDetails(int product_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}product_det"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({"product_id": product_id, "user_id": global.user.id, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = ProductDetail.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getProductDetails(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getProductOrderHistory() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}product_orders"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": global.user.id, }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<ProductOrderHistory>.from(json.decode(response.body)["data"].map((x) => ProductOrderHistory.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getProductOrderHistory(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getProducts(String lat, String lng, int pageNumber, String searchstring) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}salon_products?page=${pageNumber.toString()}"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({"lat": lat, "lng": lng, "user_id": global.user.id, "searchstring": searchstring, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<Product>.from(json.decode(response.body)["data"].map((x) => Product.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getProducts(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getReferandEarn() async {
  //   try {
  //     Response response;
  //     var dio = Dio();
  //
  //     response = await dio.get('${global.baseUrl}refer_n_earn',
  //
  //         options: Options(
  //           headers: await global.getApiHeaders(true),
  //         ));
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && response.data["status"] == "1") {
  //       recordList = response.data["data"];
  //     } else {
  //       recordList = null;
  //     }
  //     return getDioResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getReferandEarn(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getSalonListForServices(String lat, String lng, String service_name) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}service_salons"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({
  //         "lat": lat,
  //         "lng": lng,
  //         "service_name": service_name,
  //
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<BarberShop>.from(json.decode(response.body)["data"].map((x) => BarberShop.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getNearByBarberShops(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getScratchCards() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}user_scratch_cards"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({
  //         "user_id": global.user.id,
  //
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<ScratchCard>.from(json.decode(response.body)["data"].map((x) => ScratchCard.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getScratchCards(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getServices(String lat, String lng, int pageNumber, {String searchstring}) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}services?page=${pageNumber.toString()}"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({"lat": lat, "lng": lng, "searchstring": searchstring, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<Service>.from(json.decode(response.body)["data"].map((x) => Service.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getServices(): " + e.toString());
  //   }
  // }
  //



  Future<dynamic> getTermsAndCondition() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}terms',
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = TermsAndCondition.fromJson(response.data['data']);

      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getTermsAndCondition(): " + e.toString());
    }
  }
  //
  // Future<dynamic> getTimeSLot(String selected_date, int staff_id, int vendor_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}timeslot"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({
  //         "selected_date": selected_date,
  //         "staff_id": staff_id,
  //         "vendor_id": vendor_id,
  //
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<TimeSlot>.from(json.decode(response.body)["data"].map((x) => TimeSlot.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getTimeSLot(): " + e.toString());
  //   }
  // }






  Future<dynamic> getUserProfile(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}myprofile"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "id": id,
          
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
        recordList.token = json.decode(response.body)["token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getUserProfile(): " + e.toString());
    }
  }








  Future<dynamic> getEventList(int pageNumber, ) async {
    try {


      final response = await http.get(
        Uri.parse("${global.baseUrl}user/events/all?page=${pageNumber.toString()}"),
        headers: await global.getApiHeaders(true),
        // body: json.encode({
        //
        //   "searchstring": searchstring,
        //
        // }),
      );

      dynamic recordList;

      if (response.statusCode == 200 && json.decode(response.body)["resp_code"] == "00") {
        recordList = List<Event>.from(json.decode(response.body)["data"]["data"].map((x) => Event.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getEventList(): " + e.toString());
    }
  }

  Future<dynamic> getTestimonyList(int pageNumber, ) async {
    try {


      final response = await http.get(
        Uri.parse("${global.baseUrl}user/testimony/all?page=${pageNumber.toString()}"),
        headers: await global.getApiHeaders(true),

      );

      dynamic recordList;

      if (response.statusCode == 200 && json.decode(response.body)["resp_code"] == "00") {
        recordList = List<Testimony>.from(json.decode(response.body)["data"]["data"].map((x) => Testimony.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getTestimonyList(): " + e.toString());
    }
  }



  Future<dynamic> loginWithEmail(Loginrequest user) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}auth/login"),
        headers: await global.getApiHeaders(false),
        body: json.encode(user),
      );

      dynamic recordList;


      if (response.statusCode == 200 && json.decode(response.body) != null && json.decode(response.body)["data"] != null) {
        // recordList = CurrentUser.fromJson(json.decode(response.body)["data"]["user"]);
        recordList = LoginResponse.fromJson(json.decode(response.body)["data"]);


        // recordList.token = json.decode(response.body)['data']["token_data"]["token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - loginWithEmail(): " + e.toString());
    }
  }



  Future<dynamic> signUp(SignupRequest user) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}auth/create"),
        headers: await global.getApiHeaders(false),
        body: json.encode(user),
      );

      dynamic recordList;
      // if(json.decode(response.body)["success"]==false){
      //   recordList = Data.fromJson(json.decode(response.body)["data"]);
      // } else

      if (response.statusCode == 200 && json.decode(response.body) != null && json.decode(response.body)["data"] != null) {


        recordList = SignupData.fromJson(json.decode(response.body)["data"]);


        // recordList.token = json.decode(response.body)['data']["token_data"]["token"];
      }
      else if (response.statusCode == 400)
      {

       // recordList = List<Error>.from(json.decode(response.body)["errors"].map((x) => Error.fromJson(x)));
        return Error.fromJson(json.decode(response.body));



      }

      else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - signupWithEmail(): " + e.toString());
    }
  }





  Future<dynamic> updateProfileImage({
    int? id,

    File? user_image,

  }) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({

        "user_id": id,
        'picture': user_image != null ? await MultipartFile.fromFile(user_image.path.toString()) : null,
      });

      response = await dio.post('${global.baseUrl}profile/update/dp',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CurrentUser.fromJson(response.data['data']);
        //  recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - submitreport(): " + e.toString());
    }
  }




  Future<dynamic> submitTestimony({
    String? title,

    String ? desc,
    String? user_id

  }) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        "user_id":user_id,
        "title": title,
        'desc': desc,
      });

      response = await dio.post('${global.baseUrl}user/testimony/create',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = TestimonyResponse.fromJson(response.data['data']);
        //  recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - submittestimony(): " + e.toString());
    }
  }



  Future<dynamic> submitQuestion({


    String ? desc,
    String? user_id

  }) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        "user_id":user_id,
        "title": "Questions Asked",
        'desc': desc,
      });

      response = await dio.post('${global.baseUrl}user/testimony/create',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = TestimonyResponse.fromJson(response.data['data']);
        //  recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - submittestimony(): " + e.toString());
    }
  }










  Future<dynamic> submitReport({
    String? id,
    String? attendance,
    String? no_of_first_timers,
    File? user_image,
    String? offering,
    String? time_of_meeting,
    String? desc,
  }) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({

        "user_id": id,
        "attendance": attendance,
        "no_of_first_timers": no_of_first_timers,
        "offering": offering,
        "time_of_meeting": "10",
        "desc": desc,
       // "picture": user_image,


       'picture': user_image != null ? await MultipartFile.fromFile(user_image.path.toString()) : null,
      });

      response = await dio.post('${global.baseUrl}user/report/create',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = HopReportResponse.fromJson(response.data['data']);
      //  recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - submitreport(): " + e.toString());
    }
  }





  Future<dynamic> signUp2(SignupRequest user) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'fullname': user.fullname,
        'email': user.email,
        'phone': user.phone,
        'password': user.password,
        "gender": user.gender,


        "DateOfBirth": user.dateOfBirth,
        "StreetAddress": "null",
        "state": "lagos",
        "city":"Lagos"
        //'device_id': global.appDeviceId,

        // 'fb_id': user.facebook != null ? user.facebook : null,
        // 'user_image': user.user_image != null ? await MultipartFile.fromFile(user.user_image!.path.toString()) : null,

      });
      
      response = await dio.post('${global.baseUrl}auth/create',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
       // recordList = CurrentUser.fromJson(response.data['data']);
        recordList = SignupData.fromJson(response.data['data']);


      } else {
        recordList = null;
      }
     // return getAPIResult(response.data, recordList);
      return getDioResult(response.data, recordList);


    } catch (e) {
      print("Exception - signUp(): " + e.toString());
    }
  }









  Future<dynamic> updateProfile(
    int id,
    String user_name,
    File user_image, {
    String? user_password,
  }) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'id': id,
        'user_name': user_name,
        'user_password': user_password,
        
        'user_image': user_image != null ? await MultipartFile.fromFile(user_image.path.toString()) : null,
      });
      
      response = await dio.post('${global.baseUrl}profile_edit',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CurrentUser.fromJson(response.data['data']);
        recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - updateProfile(): " + e.toString());
    }
  }

  Future<dynamic> verifyOtpAfterLogin(String user_phone, String status, String device_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}login_verifyotpfirebase"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"user_phone": user_phone, "status": status, "device_id": device_id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body) != null && json.decode(response.body)["data"] != null) {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]["user"]);
        recordList.cart_count = json.decode(response.body)['data']["cart_count"];
        recordList.token = json.decode(response.body)["token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtpAfterLogin(): " + e.toString());
    }
  }

  Future<dynamic> verifyOtpAfterRegistration(String user_phone, String status, String referral_code, String device_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}verify_via_firebase"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"user_phone": user_phone, "status": status, "referral_code": referral_code, "device_id": device_id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 && jsonDecode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
        recordList.token = json.decode(response.body)["token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtpAfterRegistration(): " + e.toString());
    }
  }

  Future<dynamic> verifyOtpForgotPassword(String user_email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}verify_otp"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"user_email": user_email, "otp": otp}),
      );

      dynamic recordList;
      if (response.statusCode == 200 && jsonDecode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtpForgotPassword(): " + e.toString());
    }
  }
}
