import 'dart:io';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class mobileNumber {
  String phoneNumber = '';
  bool whatsapp = true;
}

mobileNumber mobilenumber = mobileNumber();

class _LoginState extends State<Login> {
  DateTime currentBackPressTime;
  String phoneIsoCode;
  final numberController = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  // void onPhoneNumberChange(String number, String internationalizedPhoneNumber,
  //     String isoCode) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     phoneNumber = number;
  //     phoneIsoCode = isoCode;
  //     prefs.setString('phoneNumber', number);
  //   });
  // }

  bool value = true;
  bool whatsapp = true;

  @override
  Widget buildCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          activeColor: primaryColor,
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value;
              whatsapp = value;
            });
          },
        ),
        Text(
          'Click here to recieve Whatsapp Notifications',
          style: black14RegularTextStyle,
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: scaffoldBgColor,
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: 15.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Logo.png',
                width: 40.w,
                height: 20.h,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5.h),
              Text(
                'Signin with phone number',
                style: grey14BoldTextStyle,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  fixPadding * 3.0,
                  20,
                  fixPadding * 3.0,
                  15,
                ),
                child: Container(
                  width: 70.w,
                  padding: EdgeInsets.only(left: fixPadding * 2.0),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        color: blackColor.withOpacity(0.05),
                      ),
                    ],
                  ),
                  child: InternationalPhoneNumberInput(
                    textStyle: black14RegularTextStyle,
                    autoValidate: false,
                    selectorTextStyle: black16MediumTextStyle,
                    initialValue: number,
                    textFieldController: numberController,
                    inputBorder: InputBorder.none,
                    inputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 0.0),
                      hintText: 'Phone Number',
                      hintStyle: black16SemiBoldTextStyle,
                      border: InputBorder.none,
                    ),
                    selectorType: PhoneInputSelectorType.DIALOG,
                  ),
                ),
              ),
              buildCheckbox(),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 3.0, vertical: 15.0),
                child: InkWell(
                  onTap: () => Change_Language(),
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 6.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      'Continue',
                      style: white18BoldTextStyle,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'We’ll send otp for verification',
                style: black14MediumTextStyle,
              ),
              SizedBox(
                height: 5.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => GuestHome(),
                    ),
                  );
                },
                child: Text(
                  'Guest Login',
                  style: red16BoldTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
      // onWillPop: () async {
      //   bool backStatus = onWillPop();
      //   if (backStatus) {
      //     exit(0);
      //   }
      //   return false;
      // },
      //),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  void Change_Language() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        double width = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    decoration: BoxDecoration(
                      color: scaffoldBgColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            'Choose Language',
                            style: primaryColor18BoldTextStyle,
                          ),
                        ),
                        height20Space,
                        Container(
                          width: double.infinity,
                          height: 0.7,
                          color: greyColor.withOpacity(0.4),
                        ),

                        Hindi_or_English(),

                        height20Space,
                        // Buy Button
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRightWithFade,
                                child: OTPScreen(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(7.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(fixPadding * 1.7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: primaryColor,
                            ),
                            child: Text(
                              'continue'.toUpperCase(),
                              style: white16MediumTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    final PhoneNumberOb = numberController.text;
    final PhoneReplace = PhoneNumberOb.replaceAll(" ", "");
    http.Response response = await http.post(
      Uri.parse("https://goldv2.herokuapp.com/api/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"mobile": PhoneReplace, "isWhatsapp": whatsapp}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      mobilenumber.phoneNumber = PhoneReplace;
      mobilenumber.whatsapp = whatsapp;
    }
  }
}

class Hindi_or_English extends StatefulWidget {
  @override
  _Hindi_or_EnglishState createState() => _Hindi_or_EnglishState();
}

class _Hindi_or_EnglishState extends State<Hindi_or_English> {
  bool isHindi = false;

  void setLanguage(bool set) {
    setState(() {
      isHindi = set;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isHindi = true;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 13,
                    decoration: BoxDecoration(
                      color: isHindi ? primaryColor : whiteColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              widthSpace,
              Text(
                'Hindi',
                style: primaryColor14MediumTextStyle,
              ),
            ],
          ),
          widthSpace,
          widthSpace,
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isHindi = false;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 13,
                    decoration: BoxDecoration(
                      color: isHindi ? whiteColor : primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              widthSpace,
              Text(
                'English',
                style: primaryColor14MediumTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
