import 'dart:async';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

double screenw;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 3),

        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //Your work starts here****************************************

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  'assets/Logo.png',
                  width: 40.w,
                  height: 20.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'BKS MyGOLD',
                  style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 20.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  width: 20.w,
                  child: Divider(
                    thickness: 1,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'BUY TODAY',
                  style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 20.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'SAVE FOR TOMMOWROW',
                  style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 20.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'A VENTURE OF',
                  style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 20.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'B.K.SARAF PVT JEWELLERS',
                  style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 20.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Positioned(
              bottom: 5.h,
              child: Container(
                width: width,
                child: SpinKitRing(
                  color: primaryColor,
                  size: 15,
                  lineWidth: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Your work ends here****************************************
