import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/Detail.dart';
import 'package:gold247/models/Metalgroup.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../Eshop/COD_address.dart';

class SellOld extends StatefulWidget {
  SellOld();
  @override
  _SellOldState createState() => _SellOldState();
}

class _SellOldState extends State<SellOld> {
  List portfolioItem;
  int sellprice24;
  int sellprice22;
  int sellprice18;
  final valueController = TextEditingController();
  String karatageID = '60f73ac8e306ef7c367a54e7';
  String karatageController;

  String suffix;
  DataI dataI;
  Detail detail;
  String otp;
  bool message;
  Future CreatePlans() async {
    //TODO add url and body
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/appointment/create/${Userdata.sId}'));
    request.bodyFields = {
      "weight": valueController.text,
      "metalGroup": karatageID,
      "buySellPrice": data.sId,
      // "otp": "BKSSELL4001",
      // "appointmentDate": "2021-12-10T00:00:00.000Z",
      // "appointmentTime": "13: 00",
      // "status": "Verifier Assigned",
      // "verifier": "61478eb50bd5870016d17238"
    };
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map s = jsonDecode(responseString);

      message = s['success'];
      otp = s['data'];
    }
    return detail;
//      print(dataI.otp)
  }

  buysellprice data;
  List<buysellprice> price;

  Future fetchData() async {
    var request = http.Request('GET',
        Uri.parse('https://goldv2.herokuapp.com/api/buy-sell-price/letest'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      data = buysellprice.fromJson(det['data']);

      print(data);
    } else {
      print(response.reasonPhrase);
    }
    return data;
  }

  List<MetalGroup> temp = [];
  Future getMetals() async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/metal-group'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();

      Iterable t = jsonDecode(responseString);
      temp =
          List<MetalGroup>.from(t.map((model) => MetalGroup.fromJson(model)));
      print(temp);
    } else {
      print(response.reasonPhrase);
    }
    return temp;
  }

  MetalGroup parti;
  Future getMetalbyID() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/metal-group/${karatageID}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map d = jsonDecode(responseString);
      parti = MetalGroup.fromJson(d);
      print(parti.shortName);
    } else {
      print(response.reasonPhrase);
    }
    return parti;
  }

  Future<bool> init;
  Future<bool> initialise() async {
    await fetchData();
    await getMetals();
    await getMetalbyID();

    return true;
  }

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: init,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return SafeArea(
              child: Scaffold(
                  backgroundColor: scaffoldBgColor,
                  body: Center(
                      child: CircularProgressIndicator(
                    color: primaryColor,
                  ))),
            );
          } else {
            if (snapshot.hasData) {
              return SafeArea(
                  child: Scaffold(
                backgroundColor: scaffoldBgColor,
                appBar: AppBar(
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: whiteColor,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: primaryColor,
                  centerTitle: true,
                  title: Text(
                    "Sell Your Old Gold",
                    style: white18MediumTextStyle,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Gold_Price_bar(
                        buyprice: int.parse(data.kt24.sell),
                      ),
                      heightSpace,
                      height20Space,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(fixPadding * 2),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                              ),
                              child: TextField(
                                controller: valueController,
                                keyboardType: TextInputType.number,
                                style: primaryColor18BoldTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Weight',
                                  fillColor: whiteColor,
                                  labelStyle: primaryColor18BoldTextStyle,
                                  suffix: Text(
                                    'GRAM',
                                    style: primaryColor18BoldTextStyle,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(fixPadding * 2),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                              ),
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Karatage',
                                      fillColor: whiteColor,
                                      labelStyle: primaryColor18BoldTextStyle,
                                      suffix: Text(
                                        "KT",
                                        style: primaryColor16BoldTextStyle,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: primaryColor, width: 0.7),
                                      ),
                                    ),
                                    isEmpty: karatageID == '',
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: karatageID,
                                        isDense: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            karatageID = newValue;
                                            getMetalbyID();
                                          });

//
                                        },
                                        items: temp.map((MetalGroup value) {
                                          return DropdownMenuItem<String>(
                                            value: value.sId,
                                            child: value.shortName.isEmpty
                                                ? '23 KT'
                                                : Text(
                                                    value.shortName,
                                                    style:
                                                        primaryColor18BoldTextStyle,
                                                  ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: scaffoldBgColor,
                                  border: Border.all(
                                      color: primaryColor, width: 0.7),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: fixPadding * 2),
                              padding: EdgeInsets.all(fixPadding * 2), //TODO

                              child: Text(
                                  'INR ${valueController.text.isEmpty ? '1' : valueController.text == '24 KT' ? double.parse(valueController.text) * double.parse(data.kt24.sell) : valueController.text == '22 KT' ? double.parse(valueController.text) * double.parse(data.kt22.sell) : double.parse(valueController.text) * double.parse(data.kt18.sell)}',
                                  style: primaryColor18BoldTextStyle)),
                          Your_Portfolio(
                              parti.shortName == null ? "" : parti.shortName,
                              parti.shortName == '24 KT'
                                  ? double.parse(data.kt24.sell.toString())
                                  : parti.shortName == '22 KT'
                                      ? double.parse(data.kt22.sell.toString())
                                      : double.parse(data.kt18.sell.toString()),
                              valueController.text.isEmpty
                                  ? '1'
                                  : valueController.text,
                              valueController.text.isEmpty
                                  ? '1'
                                  : parti.shortName == '24 KT'
                                      ? (double.parse(valueController.text) *
                                              double.parse(
                                                  data.kt24.sell.toString()))
                                          .toString()
                                      : parti.shortName == '22 KT'
                                          ? (double.parse(
                                                      valueController.text) *
                                                  double.parse(data.kt22.sell
                                                      .toString()))
                                              .toString()
                                          : (double.parse(
                                                      valueController.text) *
                                                  double.parse(data.kt18.sell
                                                      .toString()))
                                              .toString()),
                          GestureDetector(
                            onTap: () async {
                              await CreatePlans();
//AlertDialog(
//
//    );
                              setState(() {
                                if (message == true) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
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
                                                    "REQUEST PLACED",
                                                    style: black16BoldTextStyle,
                                                  )),
                                                  Center(
                                                      child: Text(
                                                    'SUCCESS',
                                                    style:
                                                        black14MediumTextStyle,
                                                  )),
                                                  heightSpace,
                                                  Center(
                                                    child: Container(
                                                      color: whiteColor,
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Center(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(otp),
                                                      )),
                                                    ),
                                                  ),
                                                  height20Space,
                                                  Center(
                                                      child: Text(
                                                    "Tap to Copy Verification OTP",
                                                    style:
                                                        black12MediumTextStyle,
                                                  )),
                                                  heightSpace,
                                                  Center(
                                                      child: Text(
                                                    'Show this code while you visit Store',
                                                    style:
                                                        black12MediumTextStyle,
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
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
                                                      child: Text(
                                                    "REQUEST FAILED",
                                                    style: black16BoldTextStyle,
                                                  )),
                                                  Center(
                                                      child: Text(
                                                    'FAILED',
                                                    style:
                                                        black14MediumTextStyle,
                                                  )),
                                                  heightSpace,
                                                ],
                                              ),
                                            ),
                                          ));
                                }
                              });
                            },
                            child: Container(
                              color: primaryColor,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              height: 50.0,
                              padding: EdgeInsets.all(fixPadding * 1.5),
                              child: Text(
                                'PLace Request for Verification',
                                style: white18BoldTextStyle,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text("Price Changes in : "),
                          height20Space,
                        ],
                      ),
                    ],
                  ),
                ),
              ));
            } else {
              return Text("No data found");
            }
          }
        });
  }
}

class Gold_Price_bar extends StatelessWidget {
  int buyprice;
  Gold_Price_bar({Key key, this.buyprice}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(fixPadding * 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(goldIngotsPath),
                ),
              ),
              widthSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' Current 24 KT GOLD Sell Price',
                    style: primaryColor18BoldTextStyle,
                  ),
                  height5Space,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'INR ${buyprice.toString()}',
                        style: black14BoldTextStyle,
                      ),
                      Icon(
                        Icons.arrow_drop_up,
                        color: greenColor,
                      ),
                      Text(
                        '24%',
                        style: black14BoldTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Your_Portfolio(String kartage, double sellPrice, String Weight, String amount) {
  return Container(
    height: 330,
    child: Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'CALCULATION',
            style: primaryColor16MediumTextStyle,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Portfolio_card('Selected Karatage',
                    kartage), //TODO${kartage} ${sellPrice} ${amount}
                Portfolio_card(
                  'Per Gram Sell Price',
                  'INR ${sellPrice}',
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Portfolio_card('Weight Entered', "${Weight} GRAM"),
                Portfolio_card('Approximate sell price', ' INR  ${amount}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class Portfolio_card extends StatelessWidget {
  Portfolio_card(this.tag, this.text);

  final String tag;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                spreadRadius: 1.0,
                color: blackColor.withOpacity(0.05),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tag,
                  style: grey14BoldTextStyle,
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  text,
                  style: black14MediumTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Payment_Method extends StatelessWidget {
  const Payment_Method({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '   Choose Payment Mode',
          style: primaryColor16MediumTextStyle,
        ),
        heightSpace,
        Payment_Card(
          FontAwesomeIcons.creditCard,
          'Use Payment Gateway Service to pay instantly',
          'Online Payment',
          BankDetails(),
        ),
        heightSpace,
        Payment_Card(
          Icons.location_on,
          'You can pay at your doorstep',
          'Cash On Delivery',
          Adress_Details_Payment(),
        ),
      ],
    );
  }
}

class Payment_Card extends StatelessWidget {
  Payment_Card(
    this.icon,
    this.text,
    this.tag,
    this.navigateTo,
  );

  final IconData icon;

  final String tag;
  final String text;

  final Widget navigateTo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.size,
                alignment: Alignment.bottomCenter,
                child: navigateTo));
      },
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: fixPadding * 2),
        padding: EdgeInsets.all(fixPadding * 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              size: 40,
            ),
            width20Space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  child: Text(
                    tag,
                    style: black16BoldTextStyle,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    text,
                    style: black14RegularTextStyle,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
