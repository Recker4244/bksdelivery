import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/StandPlans.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/cod/cod_Stan.dart';
import 'package:gold247/pages/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Standard_PC extends StatefulWidget {
  final String mode;
  final String id;
  Standard_PC({this.id, this.mode});
  @override
  _Standard_PCState createState() => _Standard_PCState();
}

class _Standard_PCState extends State<Standard_PC> {
  Razorpay _razorpay;
  final Rkey = 'rzp_test_wVVGuz2rxyrfFd';
  TextEditingController Weight = TextEditingController();
  int buyprice;
  String val = "0";
  String minvalue;
  String cycleID;
  int mode;
  String suffix;
  int duration;
  buysellprice data;
  Future fetchData() async {
    var request = http.Request('GET',
        Uri.parse('https://goldv2.herokuapp.com/api/buy-sell-price/letest'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      data = buysellprice.fromJson(det['data']);
    } else {
      print(response.reasonPhrase);
    }
    return data;
  }

  Future fetcStanPlans() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://goldv2.herokuapp.com/api/plan/${widget.id}"), //+ widget.id),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      Map datas = responseString;
      //stanplan = StanPlan.fromJson(datas);
      if (responseString['cyclePeriod']['name'] == 'Every Month') {
        suffix = 'Months';
      } else if (responseString['cyclePeriod']['name'] == 'Every Day') {
        suffix = 'Days';
      } else if (responseString['cyclePeriod']['name'] == 'Every Year') {
        suffix = 'Year';
      } else {
        suffix = 'Week';
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  void openCheckout() async {
    var options = {
      'key': Rkey,
      'amount': (double.parse(val) * double.parse(data.kt24.buy)) * 100.0,
      'name': "Standard Plan",
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': Userdata.mobile, 'email': Userdata.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future<bool> init;
  Future<bool> initialise() async {
    await fetcStanPlans();
    await fetchData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    return true;
  }

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.paymentId);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
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
                      "stanplan.name",
                      style: white18MediumTextStyle,
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Gold_Price_bar(
                          buyprice: int.parse(data.kt24.buy),
                        ),
                        heightSpace,
                        Text(
                          'Price Changes in',
                          style: black16RegularTextStyle,
                        ),
                        height20Space,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: fixPadding * 2),

                              color: whiteColor,
                              // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                              child: TextField(
                                controller: Weight,
                                keyboardType: TextInputType.number,
                                style: primaryColor16BoldTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Weight',
                                  labelStyle: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  suffix: Text(
                                    'GRAM',
                                    style: primaryColor16MediumTextStyle,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.1),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    val = Weight.text;
                                  });
                                },
                              ),
                            ),
                            // stanplan.mode == 'weight' && Weight.text.isEmpty
                            //     ? Your_Portfolio(
                            //         double.parse('1'),
                            //         (1 + (stanplan.bonus * 0.01))
                            //             .toStringAsPrecision(3),
                            //         stanplan.duration,
                            //         ((double.parse('1') * stanplan.duration) *
                            //                 (1 + stanplan.bonus * 0.01))
                            //             .toStringAsPrecision(3),
                            //         suffix)
                            //     : stanplan.mode == 'weight'
                            //         ? Your_Portfolio(
                            //             double.parse(Weight.text),
                            //             (1 + (stanplan.bonus * 0.01))
                            //                 .toStringAsPrecision(3),
                            //             stanplan.duration,
                            //             ((double.parse(Weight.text) * stanplan.duration) *
                            //                     (1 + stanplan.bonus * 0.01))
                            //                 .toStringAsPrecision(3),
                            //             suffix)
                            //         : stanplan.mode == 'value' &&
                            //                 Weight.text.isEmpty
                            //             ? Your_Portfolio(
                            //                 double.parse('9999'),
                            //                 (1 + (stanplan.bonus * 0.01))
                            //                     .toStringAsPrecision(3),
                            //                 stanplan.duration,
                            //                 (((double.parse('9999') / data.kt24.buy) *
                            //                             stanplan.duration) *
                            //                         (1 + stanplan.bonus * 0.01))
                            //                     .toString(),
                            //                 suffix)
                            //             : Your_Portfolio(
                            //                 double.parse(Weight.text),
                            //                 (1 + (stanplan.bonus * 0.01))
                            //                     .toStringAsPrecision(3),
                            //                 stanplan.duration,
                            //                 (((double.parse(Weight.text) / data.kt24.buy) * stanplan.duration) * (1 + stanplan.bonus * 0.01)).toString(),
                            //                 suffix),
                            // Container(
                            //   decoration: BoxDecoration(
                            //       color: whiteColor,
                            //       borderRadius: BorderRadius.all(
                            //         Radius.circular(10),
                            //       )),
                            //   width: double.infinity,
                            //   margin: EdgeInsets.symmetric(
                            //       horizontal: fixPadding * 2),
                            //   padding: EdgeInsets.all(fixPadding * 2),
                            //   child: stanplan.mode == 'weight' &&
                            //           Weight.text.isEmpty
                            //       ? Text(
                            //           ' INR ${((double.parse('1')) * data.kt24.buy).toString()}',
                            //           style: primaryColor16BoldTextStyle)
                            //       : stanplan.mode == 'weight'
                            //           ? Text(
                            //               ' INR ${((double.parse(Weight.text)) * data.kt24.buy).toString()}',
                            //               style: primaryColor16BoldTextStyle)
                            //           : stanplan.mode == 'value' &&
                            //                   Weight.text.isEmpty
                            //               ? Text(
                            //                   '${((double.parse('9999') / data.kt24.buy)).toStringAsPrecision(3)}  GRAM',
                            //                   style:
                            //                       primaryColor16BoldTextStyle)
                            //               : Text(
                            //                   '${((double.parse(Weight.text) / data.kt24.buy)).toStringAsPrecision(3)}  GRAM',
                            //                   style:
                            //                       primaryColor16BoldTextStyle),
                            // ),

//
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '   Choose Payment Mode',
                                  style: primaryColor16MediumTextStyle,
                                ),
                                heightSpace,
//        FontAwesomeIcons.creditCard,
//
//          ,
                                GestureDetector(
                                  onTap: () {
                                    openCheckout();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: fixPadding * 2),
                                    padding: EdgeInsets.all(fixPadding * 2),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.creditCard,
                                          size: 40,
                                        ),
                                        width20Space,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                'Use Payment Gateway Service to pay instantly',
                                                style: black16BoldTextStyle,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Text(
                                                'Online Payment',
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
                                ),
                                heightSpace,
                                // Payment_Card(
                                //   Icons.location_on,
                                //   'You can pay at your doorstep',
                                //   'Cash On Delivery',
                                //   Adress_Details_Payment_Stan(
                                //     amount: (double.parse(val) *
                                //             data.kt24.buy.toDouble())
                                //         .toString(),
                                //     gold: val,
                                //     PlanID: widget.id,
                                //     CPID: stanplan.cyclePeriod.sId,
                                //   ),
                                // ),
                              ],
                            ),
                            height20Space,
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Text("No data found");
            }
          }
        }
//
        );
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
                    '24 KT GOLD',
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

Your_Portfolio(double saveGold, String BonusC, int Duration, String Saving,
    String suffix) {
  return Container(
    height: 330,
    child: Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Your Portfolio',
            style: primaryColor16MediumTextStyle,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Portfolio_card('Saving Gold', '${saveGold.toString()}  GRAM'),
                Portfolio_card(
                  'Bonus By Maturity',
                  '${BonusC}  GRAM',
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Portfolio_card('Duration', "${Duration.toString()} ${suffix}"),
                Portfolio_card('Total Saving', '${Saving} GRAM'),
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
                  style: primaryColor16BoldTextStyle,
                ),
                Text(
                  text,
                  style: primaryColor16MediumTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
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
