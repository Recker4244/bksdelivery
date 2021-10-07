import 'dart:convert';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/FlexiSubscription.dart';
import 'package:gold247/models/Installments.dart';
import 'package:gold247/models/Plan_Subscription.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/buySccessFailScreen/buy_fail_screen.dart';
import 'package:gold247/pages/buySccessFailScreen/buy_success_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

enum adressType { Home, Work, Others }
adressType _character = adressType.Home;

class Adress_Details_Payment_Flex extends StatefulWidget {
  final String gold;
  final String mode;
  final String amount;
  final int duration;
  final int indentifier;
  final String PlanID;
  final String CPID;
  Adress_Details_Payment_Flex(
      {this.amount,
      this.gold,
      this.PlanID,
      this.CPID,
      this.mode,
      this.duration,
      this.indentifier});

  @override
  _Adress_Details_Payment_FlexState createState() =>
      _Adress_Details_Payment_FlexState();
}

class _Adress_Details_Payment_FlexState
    extends State<Adress_Details_Payment_Flex> {
  final addresscontroller = TextEditingController();
  final PINcontroller = TextEditingController();
  final Landmarkcontroller = TextEditingController();
  String InstallID;
  String SubscribeID;
  DataS datas;
  PlanSubscriptions pSubs;

  getAdress() {
    return Userdata.address;
  }

  bool available = true;
  Future addAddres() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('UserId') ?? "0";
    var request = http.Request(
        'POST', Uri.parse('https://gold-v1.herokuapp.com/InsertUserAddress'));
    request.bodyFields = {
      'UserId': Userdata.sId,
      'address': addresscontroller.text,
      'addtype': _character.toString(),
      'landmark': Landmarkcontroller.text,
      'plotno': PINcontroller.text,
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  checkPincode(String pincode) async {
    var request = http.Request('GET',
        Uri.parse('https://goldv2.herokuapp.com/api/pincode/search/$pincode'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      final status = det['msg'];
      if (status == "success") {
        setState(() {
          available = true;
        });
      } else {
        setState(() {
          available = false;
        });
      }
    } else {
      setState(() {
        available = false;
      });
    }
  }

  DataIN info;
  Installment Instas;
  Future Instalments() async {
    var uuid = Uuid().v1();
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/installment/create/${Userdata.sId}'));
    request.bodyFields = {
      'paymentId': uuid,
      'amount': widget.amount,
      "status": "Plan Initiated",
      "deleveryAgent": "613e0091590334001685bc60",
      "instantGoldApplied": "false",
      "mode": "COD",
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map s = jsonDecode(responseString);
      Instas = Installment.fromJson(s);

      info = DataIN.fromJson(s['data']);
      InstallID = info.sId;
    } else {
      print(response.reasonPhrase);
    }
    return Instas;
  }

  DataFS temp;
  FlexiSubscribe fs;
  Future Flexi_Sunscription() async {
    final headers = {'Content-Type': 'application/json'};
    final body = {
      "plan": {
        "mode": 'Value',
        "duration": widget.duration,
        "cyclePeriod": widget.CPID
      },
      "userId": Userdata.sId,
      "status": "Completed",
      "amount": widget.amount,
      "installmentId": InstallID,
      "addressId": "6144dff6e2102d94873b708f"
    };
    // final body = {
    //   "plan": {
    //     "mode": "Value",
    //     "duration": 20,
    //     "cyclePeriod": "6145e62a829b10074821f2ad"
    //   },
    //   "userId": "6136f4f828d71c00160d6e51",
    //   "status": "Processing",
    //   "amount": 100,
    //   "installmentId": "61421a21f7b79672ad627e99",
    //   "addressId": "6144dff6e2102d94873b708f"
    // };
    http.Response response = await http.post(
        Uri.parse(
            'https://goldv2.herokuapp.com/api/subscription/create/flexi/6136f4f828d71c00160d6e51'),
        body: json.encode(body),
        headers: headers);

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      Map s = responseString;
      fs = FlexiSubscribe.fromJson(s);
      temp = DataFS.fromJson(s['data']);

      SubscribeID = temp.sId;
    } else {
      print(response.reasonPhrase);
    }
    return fs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0.0,
        title: Text(
          'BUY GOLD',
          style: TextStyle(
            color: scaffoldBgColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            height20Space,
            height20Space,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                color: whiteColor,
                // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                child: Theme(
                  data: ThemeData(
                    primaryColor: whiteColor,
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: primaryColor,
                    ),
                  ),
                  child: TextField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.streetAddress,
                    style: primaryColor16MediumTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Adress',
                      labelStyle: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: primaryColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: primaryColor, width: 1),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                color: whiteColor,
                // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                child: Theme(
                  data: ThemeData(
                    primaryColor: whiteColor,
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: primaryColor,
                    ),
                  ),
                  child: TextField(
                    controller: PINcontroller,
                    keyboardType: TextInputType.number,
                    style: primaryColor16MediumTextStyle,
                    decoration: InputDecoration(
                      labelText: 'PinCode',
                      labelStyle: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: primaryColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: primaryColor, width: 1),
                      ),
                    ),
                    onChanged: (value) {
                      checkPincode(value);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                color: whiteColor,
                // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                child: Theme(
                  data: ThemeData(
                    primaryColor: whiteColor,
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: primaryColor,
                    ),
                  ),
                  child: TextField(
                    controller: Landmarkcontroller,
                    keyboardType: TextInputType.streetAddress,
                    style: primaryColor16MediumTextStyle,
                    decoration: InputDecoration(
                      labelText: 'LandMark',
                      labelStyle: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: primaryColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: primaryColor, width: 1),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
            heightSpace,
            !available
                ? Text(
                    'Not Serviceable Area, Please Change your Address',
                    style: black14SemiBoldTextStyle,
                  )
                : Container(),
            height20Space,
            height20Space,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Adress_Type(),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: fixPadding * 6),
            //   child:
            // ),
            SizedBox(height: fixPadding * 3.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () async {
                  await Instalments();
                  await Flexi_Sunscription();
                  setState(() {});
                  if (fs.success == true && Instas.success == true) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              backgroundColor: scaffoldBgColor,
                              title: Center(
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.check,
                                    size: 30.0,
                                    color: scaffoldBgColor,
                                  ),
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      "COLLECTION REQUEST PLACED",
                                      style: black14BoldTextStyle,
                                    )),
                                    Center(
                                        child: Text(
                                      'SUCCESS',
                                      style: black14MediumTextStyle,
                                    )),
                                    heightSpace,
                                    Center(
                                        child: Text(
                                      DateTime.now().toString(),
                                      style: black12MediumTextStyle,
                                    )),
                                    Center(
                                      child: Container(
                                        color: whiteColor,
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("BKS001"),
                                        )),
                                      ),
                                    ),
                                    height20Space,
                                    Center(
                                        child: Text(
                                      "Tap to Copy Verification OTP",
                                      style: black12MediumTextStyle,
                                    )),
                                    heightSpace,
                                    Center(
                                        child: Text(
                                      'Show this code while you visit Store',
                                      style: black12MediumTextStyle,
                                    ))
                                  ],
                                ),
                              ),
                            ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              backgroundColor: scaffoldBgColor,
                              title: Center(
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.sms_failed_rounded,
                                    size: 30.0,
                                    color: scaffoldBgColor,
                                  ),
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Center(
                                        child: Center(
                                      child: Text(
                                        "COLLECTION REQUEST FAILED",
                                        style: black16BoldTextStyle,
                                      ),
                                    )),
                                    Center(
                                        child: Text(
                                      'FAILED',
                                      style: black14MediumTextStyle,
                                    )),
                                    heightSpace,
                                  ],
                                ),
                              ),
                            ));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Proceed'.toUpperCase(),
                        style: TextStyle(
                          color: scaffoldBgColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Adress_Type extends StatefulWidget {
  @override
  _Adress_TypeState createState() => _Adress_TypeState();
}

class _Adress_TypeState extends State<Adress_Type> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Adress Type',
          style: primaryColor16MediumTextStyle,
        ),
        height5Space,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Adress_Type_selector(),
          ],
        ),
      ],
    );
  }
}

class Adress_Type_selector extends StatefulWidget {
  //Adress_Type_selector(this.type);

  @override
  _Adress_Type_selectorState createState() => _Adress_Type_selectorState();
}

class _Adress_Type_selectorState extends State<Adress_Type_selector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<adressType>(
          activeColor: primaryColor,
          value: adressType.Home,
          groupValue: _character,
          onChanged: (adressType value) {
            setState(() {
              _character = value;
            });
          },
        ),
        widthSpace,
        Text(
          "Home",
          style: primaryColor16MediumTextStyle,
        ),
        Radio<adressType>(
          activeColor: primaryColor,
          value: adressType.Work,
          groupValue: _character,
          onChanged: (adressType value) {
            setState(() {
              _character = value;
            });
          },
        ),
        widthSpace,
        Text(
          "Work",
          style: primaryColor16MediumTextStyle,
        ),
        Radio<adressType>(
          activeColor: primaryColor,
          value: adressType.Others,
          groupValue: _character,
          onChanged: (adressType value) {
            setState(() {
              _character = value;
            });
          },
        ),
        widthSpace,
        Text(
          "Others",
          style: primaryColor16MediumTextStyle,
        ),
      ],
    );
  }
}
