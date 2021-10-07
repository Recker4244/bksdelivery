import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/currencyScreen/buy_gold.dart';
import 'package:gold247/pages/screens.dart';
// import 'package:cryptox/widget/column_builder.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Plan Bonus Details .dart';

import 'referral_bonus_details.dart';
import 'package:sizer/sizer.dart';
class Portfolio extends StatefulWidget {
  const Portfolio({Key key}) : super(key: key);

  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  // final portfolioItem = [
  //   {
  //     'name': 'Bitcoin',
  //     'shortName': 'BTC',
  //     'image': 'assets/crypto_icon/btc.png',
  //     'value': '\$1,45,250',
  //     'status': 'up',
  //     'change': '5.26%',
  //     'coinTotal': '2.685'
  //   },
  //   {
  //     'name': 'Ethereum',
  //     'shortName': 'ETH',
  //     'image': 'assets/crypto_icon/eth.png',
  //     'value': '\$2,50,245',
  //     'status': 'down',
  //     'change': '2.56%',
  //     'coinTotal': '15.0256'
  //   }
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Center(
          child: Text(
            'Your Portfolio',
            style: primaryColor18BoldTextStyle,
          ),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          portfolioValue(),
          Choice_Card('Total Gold Saved In Plans', '10.60 GRAM', 'CHECK DETAILS',
              FontAwesomeIcons.solidCalendarCheck, Market()),
          Choice_Card('Total Instant Gold Available', '5.20 GRAM', 'CHECK DETAILS',
              FontAwesomeIcons.snowflake, BuyGold()),
          Choice_Card('Total Referral Bonus', '1.58 GRAM', 'CHECK DETAILS',
              FontAwesomeIcons.shareAlt, Referal_Bonus_Detials()),
          Choice_Card('Total Plan Bonus', '1.80 GRAM', 'CHECK DETAILS',
              FontAwesomeIcons.piggyBank, Plan_Bonnus_Details()),
          // myPortfolioItems(),
        ],
      ),
    );
  }

  portfolioValue() {
    // double width = MediaQuery.of(context).size.width;
    return Material(
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.only(bottom: fixPadding * 1.5),
        color: whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            valueItem('Total Saved', '15.80 GRAM'),
            Container(
              height: 8.h,
              width: 0.5.w,
              color: primaryColor,
            ),
            valueItem('Current Value', 'INR 56,869.30'),

          ],
        ),
      ),
    );
  }

  valueItem(title, value) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: (width) / 3,
      padding: EdgeInsets.only(left: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: grey12BoldTextStyle,
              ),
              SizedBox(height: 1.h,),
              Text(
                value,
                style: black16SemiBoldTextStyle,
              ),
            ],
          ),
          // Container(
          //   height: 30.0,
          //   width: 0.7,
          //   color: greyColor.withOpacity(0.6),
          // )
        ],
      ),
    );
  }


  Choice_Card(
      String mainText,
      String amount,
      String bottomText,
      IconData icons,
      Widget navigateTo,
      ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: whiteColor,

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.size,
                        alignment: Alignment.bottomCenter,
                        child: navigateTo));
              },
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.all(fixPadding * 1.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  color: whiteColor,
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
                          width: 12.w,
                          height: 6.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: scaffoldBgColor,
                          ),
                          child: Icon(
                            icons,
                            color: primaryColor,
                            size: 8.w,
                          ),
                        ),
                        widthSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$mainText',
                              style: grey12BoldTextStyle,
                            ),
                            height5Space,
                            Text(
                              '$amount',
                              style: black16SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 6.w,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.size,
                        alignment: Alignment.bottomCenter,
                        child: navigateTo));
              },
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.all(fixPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                  ),
                  color: Colors.white,
                ),
                child: Text(
                  '$bottomText'.toUpperCase(),
                  style: primaryColor16BoldTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
