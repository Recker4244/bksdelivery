import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/screens.dart';
import 'package:gold247/widget/column_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final popularCurrencyList = [
    {
      'name': '1 GRAM 24 KT COIN',
      'Cost': 'INR 43333',
      'value': '\$10,136.73',
      'status': 'up',
      'change': '4.72%'
    },
    {
      'name': '10 GRAM 24 KT COIN',
      'Cost': 'INR 2444',
      'value': '\$185.65',
      'status': 'up',
      'change': '6.86%'
    },
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 2.0,
        child: Container(
          height: 50.0,
          width: width,
          color: primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  height: 50.0,
                  width: (width - 1.0) / 2,
                  alignment: Alignment.center,
                  child: Text(
                    'PROCEED'.toUpperCase(),
                    style: white18BoldTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: scaffoldBgColor,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          heightSpace,
          cartGold(),
          summary(),
          Payment_Method(),
        ],
      ),
    );
  }

  cartGold() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ColumnBuilder(
          itemCount: popularCurrencyList.length,
          itemBuilder: (context, index) {
            final item = popularCurrencyList[index];
            return Padding(
              padding: (index != popularCurrencyList.length - 1)
                  ? EdgeInsets.fromLTRB(
                      fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0.0)
                  : EdgeInsets.all(fixPadding * 2.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.size,
                          alignment: Alignment.center,
                          child: CurrencyScreen()));
                },
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(fixPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        color: blackColor.withOpacity(0.05),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/crypto_icon/btc.png',
                        height: 50.0,
                        width: 50.0,
                        fit: BoxFit.cover,
                      ),
                      widthSpace,
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: black14MediumTextStyle,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      item['Cost'],
                                      style: black12RegularTextStyle,
                                    ),
                                    widthSpace,
                                    (item['status'] == 'up')
                                        ? Icon(
                                            Icons.arrow_drop_up,
                                            color: primaryColor,
                                          )
                                        : Icon(
                                            Icons.arrow_drop_down,
                                            color: redColor,
                                          ),
                                    Text(
                                      item['change'],
                                      style: black12RegularTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      )),
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '1',
                                    style: white16BoldTextStyle,
                                  ),
                                  padding: EdgeInsets.all(10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  summary() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ' Summary',
            style: primaryColor18BoldTextStyle,
          ),
          Padding(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sub-Total',
                      style: primaryColor16MediumTextStyle,
                    ),
                    Text(
                      'INR 134000',
                      style: primaryColor16MediumTextStyle,
                    ),
                  ],
                ),
                divider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Delivery Charges',
                      style: primaryColor16MediumTextStyle,
                    ),
                    Text(
                      'INR 134000',
                      style: primaryColor16MediumTextStyle,
                    ),
                  ],
                ),
                divider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Redeem Gold',
                      style: primaryColor16MediumTextStyle,
                    ),
                    Text(
                      'INR 134000',
                      style: primaryColor16MediumTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            child: Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: fixPadding * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Available Instant Gold Balance',
                            style: primaryColor14MediumTextStyle,
                          ),
                          Text(
                            '0.8 GRAM',
                            style: primaryColor14MediumTextStyle,
                          ),
                        ],
                      ),
                      Text(
                        'INR 134000',
                        style: primaryColor16MediumTextStyle,
                      ),
                    ],
                  ),
                ),
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
              ),
            ),
          ),
          height20Space,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                ' TO PAY :',
                style: primaryColor18BoldTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: fixPadding * 2,
                ),
                child: Text(
                  ' INR 130000',
                  style: primaryColor18BoldTextStyle,
                ),
              ),
            ],
          ),
        ],
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
          style: primaryColor18BoldTextStyle,
        ),
        heightSpace,
        Payment_Card(
          FontAwesomeIcons.creditCard,
          'Use Payment Gateway Service to pay instantly',
          'Online Payment',
          Cart(),
        ),
        heightSpace,
        Payment_Card(
          Icons.location_on,
          'You can pay at your doorstep',
          'Cash On Delivery',
          Cart(),
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
                Text(
                  tag,
                  style: black16BoldTextStyle,
                ),
                Text(
                  text,
                  style: black14RegularTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
