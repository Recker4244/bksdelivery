import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/Installments.dart';
import 'package:gold247/models/Plan_Subscription.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uuid/uuid.dart';

class SellGold extends StatefulWidget {
  const SellGold({Key key}) : super(key: key);

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<SellGold> {
  bool watchlist = false;
  final valueController = TextEditingController();
  final amountController = TextEditingController();

  final sellValueController = TextEditingController();
  final sellAmountController = TextEditingController();
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

  String InstallID;
  String SubscribeID;
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
      'amount': amountController.text,
      "status": "Plan Initiated",
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
    print(Instas.success);
    print("ok");
    return Instas;
  }

  DataS datas;
  PlanSubscriptions pSubs;
  Future Instant_Sunscription() async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/subscription/create/instant/${Userdata.sId}'));
    request.bodyFields = {
      "userId": Userdata.sId,
      "status": "Completed",
      "amount": amountController.text,
      "installmentId": InstallID,
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map s = jsonDecode(responseString);
      pSubs = PlanSubscriptions.fromJson(s);
      datas = DataS.fromJson(s['data']);

      SubscribeID = datas.sId;
    } else {
      print(response.reasonPhrase);
    }
    return pSubs;
  }

  Future<bool> init;
  Future<bool> initialise() async {
    await fetchData();
    return true;
  }

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  bottomNavigationBar: Material(
                    elevation: 2.0,
                    child: Container(
                      height: 50.0,
                      width: width,
                      color: primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => sellByValue(
                                double.parse(data.kt24.sell.toString())),
                            child: Container(
                              height: 50.0,
                              width: (width - 1.0) / 2,
                              alignment: Alignment.center,
                              child: Text(
                                'SELL BY VALUE'.toUpperCase(),
                                style: white16BoldTextStyle,
                              ),
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: 1.0,
                            color: whiteColor.withOpacity(0.5),
                          ),
                          InkWell(
                            onTap: () => sellByWeight(
                                double.parse(data.kt24.sell.toString())),
                            child: Container(
                              height: 50.0,
                              width: (width - 1.0) / 2,
                              alignment: Alignment.center,
                              child: Text(
                                'SELL BY WEIGHT'.toUpperCase(),
                                style: white16BoldTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: SafeArea(
                    child: ListView(
                      children: [
                        //currencyPriceChart(data.kt24.sell),
                        aboutPortfolio(),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Text("No data found");
            }
          }
        });
  }

  currencyPriceChart(int sp) {
    return Container(
      color: whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                    ),
                    widthSpace,
                    Text(
                      'SELL 24 KT GOLD',
                      style: black16BoldTextStyle,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      watchlist = !watchlist;
                    });
                    if (watchlist) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Added to watchlist'),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Remove from watchlist'),
                      ));
                    }
                  },
                  borderRadius: BorderRadius.circular(18.0),
                  child: Container(
                    width: 36.0,
                    height: 36.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        width: 0.6,
                        color: primaryColor.withOpacity(0.6),
                      ),
                    ),
                    child: Icon(
                      (watchlist) ? Icons.star : Icons.star_border,
                      size: 24.0,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60.0,
                  width: 60.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/crypto_icon/btc.png',
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ),
                widthSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current 24KT Gold Sell Price',
                      style: black14RegularTextStyle,
                    ),
                    height5Space,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'INR ${sp}',
                          style: black18SemiBoldTextStyle,
                        ),
                        widthSpace,
                        Icon(
                          Icons.arrow_drop_up,
                          size: 26.0,
                          color: primaryColor,
                        ),
                        Text(
                          '4.65%',
                          style: primaryColor16MediumTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          height20Space,
          Container(
            width: double.infinity,
            height: 250.0,
            child: CryptoChartSyncfusion(),
          ),
        ],
      ),
    );
  }

  aboutPortfolio() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Instant Gold Details',
            style: primaryColor16BoldTextStyle,
          ),
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              aboutPortfolioItem('Gold Saved', '5.0107731'),
              aboutPortfolioItem('Current Value', '\$200,005'),
            ],
          ),
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              aboutPortfolioItem('Average Sell Price', data.kt24.sell),
              Container(
                height: 75.0,
                width: (width - fixPadding * 6.0) / 2,
                padding: EdgeInsets.all(fixPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      color: blackColor.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gain/Loss',
                      style: grey14MediumTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_drop_up,
                          size: 26.0,
                          color: primaryColor,
                        ),
                        Text(
                          '5.65%',
                          style: primaryColor16BoldTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  aboutPortfolioItem(title, value) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 75.0,
      width: (width - fixPadding * 6.0) / 2,
      padding: EdgeInsets.all(fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 1.0,
            color: blackColor.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: grey14MediumTextStyle,
          ),
          Text(
            value.toString(),
            style: black16BoldTextStyle,
          ),
        ],
      ),
    );
  }

  aboutItem(iconPath, title, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    iconPath,
                    width: 16.0,
                    height: 16.0,
                    fit: BoxFit.cover,
                  ),
                  width5Space,
                  Text(
                    title,
                    style: black14RegularTextStyle,
                  ),
                ],
              ),
              Text(
                value,
                style: black14MediumTextStyle,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 0.7,
          color: greyColor.withOpacity(0.4),
        ),
      ],
    );
  }

  sellByValue(double buyprice) {
    double price;
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
                            'BUY 24 KT GOLD BY VALUE',
                            style: primaryColor18BoldTextStyle,
                          ),
                        ),
                        height20Space,
                        Container(
                          width: double.infinity,
                          height: 0.7,
                          color: greyColor.withOpacity(0.4),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: fixPadding * 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/crypto_icon/gold_ingots.png',
                                  width: 36.0,
                                  height: 36.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              widthSpace,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current 24KT Gold Buy Price',
                                    style: grey14BoldTextStyle,
                                  ),
                                  height5Space,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'INR ${(buyprice) + (buyprice * 0.03)}',
                                        style: black18BoldTextStyle,
                                      ),
                                      widthSpace,
                                      Text(
                                        '(GST 3% INCLUDED)',
                                        style: black12MediumTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Enter Value Textfield
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                          ),
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              labelStyle: primaryColor18BoldTextStyle,
                              suffix: Text(
                                'INR',
                                style: primaryColor18BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                            onChanged: (value) {
                              var val =
                                  double.parse('${amountController.text}');
                              var amount = (val /
                                  double.parse((buyprice + (buyprice * 0.03))
                                      .toStringAsPrecision(3)));
                              setState(() {
                                valueController.text = '$amount';
                              });
                            },
                          ),
                        ),

                        height20Space,

                        // Amount Textfield
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                            backgroundColor: whiteColor,
                          ),
                          child: TextField(
                            controller: valueController,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Weight',
                              labelStyle: primaryColor18BoldTextStyle,
                              suffix: Text(
                                'GRAM  ',
                                style: primaryColor18BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
                        height20Space,
                        // Buy Button
                        InkWell(
                          onTap: () async {
                            await Instalments();
                            await Instant_Sunscription();
                            setState(() {
                              if (pSubs.success == true &&
                                  Instas.success == true) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.topToBottom,
                                    child: BuySuccessScreen(
                                        text:
                                            "You have successfully buy ${valueController.text} Gram at price of INR ${amountController.text}"),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.topToBottom,
                                    child: BuyFailScreen(),
                                  ),
                                );
                              }
                            });
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
                              'Buy'.toUpperCase(),
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
  }

  sellByWeight(double buyPrice) {
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
                            'BUY 24 KT GOLD BY WEIGHT',
                            style: primaryColor18BoldTextStyle,
                          ),
                        ),
                        height20Space,
                        Container(
                          width: double.infinity,
                          height: 0.7,
                          color: greyColor.withOpacity(0.4),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: fixPadding * 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/crypto_icon/gold_ingots.png',
                                  width: 36.0,
                                  height: 36.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              widthSpace,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current 24KT Gold Price',
                                    style: grey14BoldTextStyle,
                                  ),
                                  height5Space,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'INR ${buyPrice + (buyPrice * 0.03)}',
                                        style: black18BoldTextStyle,
                                      ),
                                      widthSpace,
                                      Text(
                                        '(GST 3% INCLUDED)',
                                        style: black12MediumTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Enter Value Textfield
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                          ),
                          child: TextField(
                            controller: valueController,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'WEIGHT',
                              labelStyle: primaryColor18BoldTextStyle,
                              suffix: Text(
                                'GRAM',
                                style: primaryColor18BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                            onChanged: (value) {
                              var val = double.parse('${valueController.text}');
                              var amount = (val *
                                  double.parse((buyPrice + (buyPrice * 0.03))
                                      .toString()));
                              setState(() {
                                amountController.text = '$amount';
                              });
                            },
                          ),
                        ),

                        height20Space,

                        // Amount Textfield
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                            backgroundColor: whiteColor,
                          ),
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              labelStyle: primaryColor18BoldTextStyle,
                              prefix: Text(
                                'INR  ',
                                style: primaryColor18BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
                        height20Space,
                        // Buy Button
                        InkWell(
                          onTap: () async {
                            await Instalments();
                            await Instant_Sunscription();
                            setState(() {
                              if (pSubs.success == true &&
                                  Instas.success == true) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.topToBottom,
                                    child: BuySuccessScreen(
                                      text:
                                          "You have successfully buy ${valueController.text} Gram at price of INR ${amountController}",
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.topToBottom,
                                    child: BuyFailScreen(),
                                  ),
                                );
                              }
                            });
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
                              'Buy'.toUpperCase(),
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
  }
}

  //TODO Study this widget

