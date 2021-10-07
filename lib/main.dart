import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/Eshop/ItemsCat.dart';
import 'package:gold247/pages/portfolio/Transactions.dart';
import 'package:gold247/pages/profile/Appointment_Details.dart';
import 'package:gold247/pages/profile/Orders.dart';
import 'package:gold247/pages/profile/Shop_order_details.dart';
import 'pages/screens.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'MyGold',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          fontFamily: 'Montserrat',
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: primaryColor,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: greyColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    });
  }
}
