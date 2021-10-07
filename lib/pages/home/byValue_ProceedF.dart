//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:gold247/constant/constant.dart';
//import 'package:gold247/pages/screens.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:page_transition/page_transition.dart';
//import 'package:http/http.dart' as http;
//import '../Eshop/COD_address.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//class ByVal_Flexi extends StatefulWidget {
//  double val;
//  int duration;
//  int mode;
//  String planname;
//  String CycleP;
//  ByVal_Flexi(
//      {@required this.CycleP, this.duration, this.val, this.planname, this.mode});
//  @override
//  _ByVal_FlexiState createState() => _ByVal_FlexiState();
//}
//
//class _ByVal_FlexiState extends State<ByVal_Flexi> {
//  List portfolioItem;
//  int buyprice;
//  List FlexPalns;
//  String CycleP;
//  String val;
//  String Planname;
//  int mode;
//  int duration;
//  String suffix;
//  String calue;
//  double amount;
//  double bonusC;
//
//  Future fetchData() async {
//    http.Response response;
//    response = await http
//        .get(Uri.parse('https://goldv2.herokuapp.com/api/buy-sell-price'));
//    if (response.statusCode == 200) {
//      setState(() {
//        portfolioItem = json.decode(response.body);
//        buyprice = portfolioItem[0]['kt24']['buy'];
//      });
//    }
//  }
//
////  Future CreatePlans(String planname, String cycleP, int duration, String text,
////      String text2) async {
////    ///TODO call this function to push data and get success/failure dialog
////    http.Response response = await http.post(
////      Uri.parse("https://goldv2.herokuapp.com/api/plan/type/flexi"),
////      body: {
////        "name": planname,
////        "cyclePeriod": cycleP,
////        "duration": duration,
////        "calcId": "5f3f9e5b5229ec11f804dd5c"
////      },
////    );
////    if (response.statusCode == 200) {
////      if (json.decode(response.body)['status'] == "success") {
////        print(response.body);
////        AlertDialog(
////          backgroundColor: scaffoldBgColor,
////          title: Center(
////            child: Icon(
////              Icons.check,
////              size: 20.0,
////              color: whiteColor,
////            ),
////          ),
////          content: SingleChildScrollView(
////            child: ListBody(
////              children: <Widget>[
////                Text(text),
////                Text('SUCCESS'),
////                heightSpace,
////                Container(
////                  child: Text("BKSCOL002"),
////                ),
////                Text(text2)
////              ],
////            ),
////          ),
////        );
////      }
////    }
////  }
//
//
//
//  void GetVal() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    setState(() {
//      val = prefs.getString('val');
//      Planname = prefs.getString('planName');
//      CycleP = prefs.getString('cycle_p');
//      mode = prefs.getInt('mode');
//      duration = prefs.getInt('duration');
//      if (CycleP == 'Every Month') {
//        suffix = 'Months';
//      } else if (CycleP == 'Every Day') {
//        suffix = 'Days';
//      } else {
//        suffix = 'Week';
//      }
//    });
//  }
//
//  @override
//  void initState() {
//    fetchData();
//    fetchFlexPlans();
//    GetVal();
//
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: scaffoldBgColor,
//      appBar: AppBar(
//        elevation: 0,
//        leading: IconButton(
//          icon: Icon(
//            Icons.close,
//            color: whiteColor,
//            size: 30,
//          ),
//          onPressed: () => Navigator.of(context).pop(),
//        ),
//        backgroundColor: primaryColor,
//        centerTitle: true,
//        title: Text(
//          Planname,
//          style: white18MediumTextStyle,
//        ),
//      ),
//      body: SingleChildScrollView(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Gold_Price_bar(
//              buyprice: buyprice,
//            ),
//            heightSpace,
//            Text(
//              'Price Changes in',
//              style: black16RegularTextStyle,
//            ),
//            height20Space,
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                SizedBox(
//                  width: double.infinity,
//                ),
//                Container(
//                  decoration: BoxDecoration(
//                      color: whiteColor,
//                      borderRadius: BorderRadius.all(
//                        Radius.circular(10),
//                      )),
//                  width: double.infinity,
//                  margin: EdgeInsets.symmetric(horizontal: fixPadding * 2),
//                  padding: EdgeInsets.all(fixPadding * 2),
//                  child: mode == 1
//                      ? Text(
//                          "${val}  GRAM",
//                          style: primaryColor16BoldTextStyle,
//                        )
//                      : Text('INR ${val}', style: primaryColor16BoldTextStyle),
//                ),
//                mode == 1
//                    ? Your_Portfolio(
//                        double.parse(val),
//                        (1 + (FlexPalns[0]['bonus'] * 0.01))
//                            .toStringAsPrecision(3),
//                        duration,
//                        ((double.parse(val) * duration) *
//                                (1 + FlexPalns[0]['bonus'] * 0.01))
//                            .toStringAsPrecision(3),
//                        suffix)
//                    : Your_Portfolio(
//                        double.parse(((double.parse(val) / buyprice)
//                            .toStringAsPrecision(3))),
//                        (1 + (FlexPalns[0]['bonus'] * 0.01))
//                            .toStringAsPrecision(3),
//                        duration,
//                        (((double.parse(val) / buyprice) * duration) *
//                                (1 + FlexPalns[0]['bonus'] * 0.01))
//                            .toStringAsPrecision(3),
//                        suffix),
//                Container(
//                  decoration: BoxDecoration(
//                      color: whiteColor,
//                      borderRadius: BorderRadius.all(
//                        Radius.circular(10),
//                      )),
//                  width: double.infinity,
//                  margin: EdgeInsets.symmetric(horizontal: fixPadding * 2),
//                  padding: EdgeInsets.all(fixPadding * 2),
//                  child: mode == 1
//                      ? Text(
//                          ("INR ${(double.parse(val) * buyprice).toString()}"),
//                          style: primaryColor16BoldTextStyle)
//                      : Text(
//                          '${((double.parse(val) / buyprice)).toStringAsPrecision(3)}  GRAM',
//                          style: primaryColor16BoldTextStyle),
//                ),
//                Payment_Method(),
//                height20Space,
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class Gold_Price_bar extends StatelessWidget {
//  int buyprice;
//  Gold_Price_bar({Key key, this.buyprice}) : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.all(fixPadding * 1.5),
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.vertical(
//          top: Radius.circular(10.0),
//        ),
//        color: whiteColor,
//        boxShadow: [
//          BoxShadow(
//            color: blackColor.withOpacity(0.05),
//            spreadRadius: 4,
//            blurRadius: 4,
//          ),
//        ],
//      ),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: [
//          Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: [
//              Container(
//                width: 50.0,
//                height: 50.0,
//                alignment: Alignment.center,
//                child: Image(
//                  image: AssetImage(goldIngotsPath),
//                ),
//              ),
//              widthSpace,
//              Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  Text(
//                    '24 KT GOLD',
//                    style: primaryColor18BoldTextStyle,
//                  ),
//                  height5Space,
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        'INR ${buyprice.toString()}',
//                        style: black14BoldTextStyle,
//                      ),
//                      Icon(
//                        Icons.arrow_drop_up,
//                        color: greenColor,
//                      ),
//                      Text(
//                        '24%',
//                        style: black14BoldTextStyle,
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//Your_Portfolio(double saveGold, String BonusC, int Duration, String Saving,
//    String suffix) {
//  return Container(
//    height: 330,
//    child: Padding(
//      padding: EdgeInsets.all(fixPadding * 2.0),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Text(
//            'Your Portfolio',
//            style: primaryColor16MediumTextStyle,
//          ),
//          Expanded(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Portfolio_card('Saving Gold', '${saveGold.toString()}  GRAM'),
//                Portfolio_card(
//                  'Bonus By Maturity',
//                  '${BonusC}  GRAM',
//                ),
//              ],
//            ),
//          ),
//          Expanded(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Portfolio_card('Duration', "${Duration.toString()} ${suffix}"),
//                Portfolio_card('Total Saving', '${Saving} GRAM'),
//              ],
//            ),
//          ),
//        ],
//      ),
//    ),
//  );
//}
//
//class Portfolio_card extends StatelessWidget {
//  Portfolio_card(this.tag, this.text);
//
//  final String tag;
//  final String text;
//
//  @override
//  Widget build(BuildContext context) {
//    return Expanded(
//      child: GestureDetector(
//        child: Container(
//          margin: EdgeInsets.all(5),
//          decoration: BoxDecoration(
//            color: whiteColor,
//            borderRadius: BorderRadius.circular(15.0),
//            boxShadow: [
//              BoxShadow(
//                blurRadius: 4.0,
//                spreadRadius: 1.0,
//                color: blackColor.withOpacity(0.05),
//              ),
//            ],
//          ),
//          child: Padding(
//            padding: const EdgeInsets.all(fixPadding * 2.0),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text(
//                  tag,
//                  style: primaryColor16BoldTextStyle,
//                ),
//                Text(
//                  text,
//                  style: primaryColor16MediumTextStyle,
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class Payment_Method extends StatelessWidget {
//  const Payment_Method({
//    Key key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Text(
//          '   Choose Payment Mode',
//          style: primaryColor16MediumTextStyle,
//        ),
//        heightSpace,
//        Payment_Card(
//          FontAwesomeIcons.creditCard,
//          'Use Payment Gateway Service to pay instantly',
//          'Online Payment',
//          BankDetails(),
//        ),
//        heightSpace,
//        Payment_Card(
//          Icons.location_on,
//          'You can pay at your doorstep',
//          'Cash On Delivery',
//          Adress_Details_Payment(),
//        ),
//      ],
//    );
//  }
//}
//
//class Payment_Card extends StatelessWidget {
//  Payment_Card(
//    this.icon,
//    this.text,
//    this.tag,
//    this.navigateTo,
//  );
//
//  final IconData icon;
//
//  final String tag;
//  final String text;
//
//  final Widget navigateTo;
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: () {
//        Navigator.push(
//            context,
//            PageTransition(
//                type: PageTransitionType.size,
//                alignment: Alignment.bottomCenter,
//                child: navigateTo));
//      },
//      child: Container(
//        decoration: BoxDecoration(
//            color: whiteColor,
//            borderRadius: BorderRadius.all(
//              Radius.circular(10),
//            )),
//        width: double.infinity,
//        margin: EdgeInsets.symmetric(horizontal: fixPadding * 2),
//        padding: EdgeInsets.all(fixPadding * 2),
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Icon(
//              icon,
//              size: 40,
//            ),
//            width20Space,
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                SizedBox(
//                  width: 150,
//                  child: Text(
//                    tag,
//                    style: black16BoldTextStyle,
//                    softWrap: true,
//                    overflow: TextOverflow.ellipsis,
//                  ),
//                ),
//                SizedBox(
//                  width: MediaQuery.of(context).size.width * 0.5,
//                  child: Text(
//                    text,
//                    style: black14RegularTextStyle,
//                    softWrap: true,
//                    overflow: TextOverflow.ellipsis,
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
