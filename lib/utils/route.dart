import 'package:flutter/material.dart';
import 'package:hopleaders/screens/eventScreen.dart';
import 'package:hopleaders/screens/feedbackScreen.dart';
import 'package:hopleaders/screens/hopdigestScreen.dart';
import 'package:hopleaders/screens/sendTestimonyScreen.dart';
import 'package:hopleaders/screens/winnerScreen.dart';

import '../screens/allhopScreen.dart';
import '../screens/hopCategoryScreen.dart';
import '../screens/homeScreen.dart';
import '../screens/otpScreen.dart';
import '../screens/signInScreen.dart';
import '../screens/signupScreen.dart';
import '../screens/submitReportScreen.dart';
import '../screens/viewTestimonyScreen.dart';

class RouteGenerator{


  static Route<dynamic> generateRoute(RouteSettings settings)  {
    switch (settings.name) {
      case "home":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "otp":
        return MaterialPageRoute(builder: (_) => OtpScreen());

     case "report":
      return MaterialPageRoute(builder: (_) => SubmitReportScreen());

      case "login":
        return MaterialPageRoute(builder: (_) => SignInScreen());

      case "feedback":
        return MaterialPageRoute(builder: (_) => FeedbackScreen());

      case "viewtestimony":
        return MaterialPageRoute(builder: (_) => ViewTestimony());

      case "hopcategory":
        return MaterialPageRoute(builder: (_) => ChooseCategory());

      case "hopdigest":
        return MaterialPageRoute(builder: (_) => hopDigestScreen());

      case "allhop":
        return MaterialPageRoute(builder: (_) => AllHopScreen());
      case "event":
        return MaterialPageRoute(builder: (_) => EventScreen());

      case"sharetestimony":
        return MaterialPageRoute(builder: (_) => HopTestimony());

      case "register":
        return MaterialPageRoute(builder: (_) => SignUpScreen());
    case "winner":
      return MaterialPageRoute(builder: (_) => WinnerScreen());
      default:
        return MaterialPageRoute(builder: (_) => SignInScreen());
    }
  }

  // Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case "/":
  //       return MaterialPageRoute(builder: (BuildContext context) {
  //         return Home();
  //       });
  //     case "/login":
  //       return MaterialPageRoute(builder: (BuildContext context) {
  //         return Login();
  //       });
  //     case "/dashboard":
  //       return MaterialPageRoute(builder: (BuildContext context) {
  //         return Dashboard();
  //       });
  //     case "/single-order":
  //       return MaterialPageRoute(builder: (BuildContext context) {
  //         return SingleOrder();
  //       });
  //     default:
  //       return MaterialPageRoute(builder: (BuildContext context) {
  //         return Home();
  //       });
  //   }
  // }


}