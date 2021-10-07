import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/screens.dart';
import 'package:gold247/pages/Eshop/itemdetails.dart';
import 'package:gold247/constant/constant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Goldcoins extends StatefulWidget {
  const Goldcoins({Key key}) : super(key: key);

  @override
  _GoldcoinsState createState() => _GoldcoinsState();
}

class _GoldcoinsState extends State<Goldcoins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(fixPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Reusablecard(
                        coinweight: 2,
                        price: 4600,
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Reusablecard(
                        coinweight: 10,
                        price: 408888,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(fixPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Reusablecard(
                        coinweight: 2,
                        price: 4600,
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Reusablecard(
                        coinweight: 10,
                        price: 408888,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Reusablecard extends StatelessWidget {
  Reusablecard({this.coinweight, this.price});

  final int coinweight;

  final int price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Eshop();
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 1,
              color: blackColor.withOpacity(0.05),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                    ),
                    Expanded(
                      child: Image(
                        image: AssetImage('assets/crypto_icon/btc.png'),
                        fit: BoxFit.cover,

                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: scaffoldLightColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(fixPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                    ),
                    Text(
                      '$coinweight GRAM 24KT GOLD',
                      style: primaryColor14MediumTextStyle,
                    ),
                    Text(
                      '99.99 PURE GOLD COIN',
                      style: primaryColor14MediumTextStyle,
                    ),
                    heightSpace,
                    Text(
                      'INR $price',
                      style: black14BoldTextStyle,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
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
