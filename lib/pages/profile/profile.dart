import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/Eshop/COD_address.dart';
import 'package:gold247/pages/portfolio/Transactions.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/models/user.dart';
import 'Orders.dart';
import 'package:gold247/pages/portfolio/Appointments.dart';
import 'package:gold247/pages/portfolio/Collections.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  logoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        double width = MediaQuery.of(context).size.width;
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You sure want to logout?',
                      style: black16BoldTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: (width - fixPadding * 14.0) / 2,
                            padding: EdgeInsets.symmetric(vertical: fixPadding),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1.0,
                                color: primaryColor,
                              ),
                              color: whiteColor,
                            ),
                            child: Text(
                              'Cancel',
                              style: black14MediumTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Login())),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: (width - fixPadding * 14.0) / 2,
                            padding: EdgeInsets.symmetric(vertical: fixPadding),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: primaryColor,
                            ),
                            child: Text(
                              'Logout',
                              style: white14MediumTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            aboutUser(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: EditProfile(),
                  ),
                ).then((value) {
                  setState(() {});
                });
              },
              child: profileItem(
                  Icons.person, 'Edit Profile', 'Edit your profile'),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: BankDetails(),
                  ),
                );
              },
              child: profileItem(Icons.account_balance, 'Bank Details',
                  'Here you can check your bank details.'),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Adress_Details_Payment(),
                  ),
                );
              },
              child: profileItem(
                  FontAwesomeIcons.addressBook,
                  'Address Details',
                  'This address is used to facilitate all your orders'),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Portfolio(),
                  ),
                );
              },
              child: profileItem(FontAwesomeIcons.piggyBank, 'Portfolio',
                  'Here you can check all your Savings details'),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: TransactionScreen(),
                  ),
                );
              },
              child: profileItem(Icons.receipt_long, 'Transactions',
                  'Here you can check all your Buy and Save Transactions'),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Orders(),
                  ),
                );
              },
              child: profileItem(FontAwesomeIcons.boxOpen, 'Orders',
                  'Here you can check all your order details'),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Collections(),
                  ),
                );
              },
              child: profileItem(FontAwesomeIcons.handHoldingUsd, 'Collections',
                  'Here you can check all your collection details'),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Appointments(),
                  ),
                );
              },
              child: profileItem(FontAwesomeIcons.calendarCheck, 'Appointments',
                  'Here you can check all your Sell gold details'),
            ),
            heightSpace,
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: PrivacyPolicy(),
                  ),
                );
              },
              child: profileItem(Icons.note, 'Terms and Conditions',
                  'Here you can check all Terms and Conditions'),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: PrivacyPolicy(),
                  ),
                );
              },
              child: profileItem(Icons.note, 'Privacy Policy',
                  'Your data is safe, here you check our policies'),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: PrivacyPolicy(),
                  ),
                );
              },
              child: profileItem(Icons.note, 'Return and Cancellation Policy',
                  'Here you can check all Return and cancellation Policies'),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Support(),
                  ),
                );
              },
              child: profileItem(Icons.headset_mic, 'Help & Support',
                  'Create a ticket and we will contact you'),
            ),
            divider(),
            InkWell(
              onTap: () {},
              child: profileItem(
                  Icons.star_border, 'Rate Us', 'Tell us what you think'),
            ),
            heightSpace,
            InkWell(
              onTap: () {},
              child: profileItem(Icons.android, 'About MyGold', 'v1.0.0'),
            ),
            heightSpace,

            // Logout
            InkWell(
              onTap: () => logoutDialog(),
              child: Container(
                padding: EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 1.5,
                    fixPadding * 2.0, fixPadding * 1.5),
                color: whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      size: 28.0,
                      color: blackColor,
                    ),
                    width20Space,
                    Text(
                      'Logout',
                      style: red16MediumTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            height20Space,
          ],
        ),
      ),
    );
  }

  aboutUser() {
    if (Userdata.pan == '' || Userdata.pan == null) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(fixPadding * 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/user/default.jpeg',
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: redColor,
                        border: Border.all(
                          width: 2.0,
                          color: whiteColor,
                        ),
                      ),
                      child: Icon(
                        Icons.gpp_bad,
                        size: 25.0,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            heightSpace,
            InkWell(
              child: Text(
                'KYC Not Verified',
                style: red14MediumTextStyle,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Support(),
                  ),
                );
              },
            ),
            heightSpace,
            Text(
              Userdata.fname,
              style: black18SemiBoldTextStyle,
            ),
            height5Space,
            Text(
              Userdata.mobile.toString(),
              style: grey16MediumTextStyle,
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(fixPadding * 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/user/default.jpeg',
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: greenColor,
                        border: Border.all(
                          width: 2.0,
                          color: whiteColor,
                        ),
                      ),
                      child: Icon(
                        Icons.gpp_good,
                        size: 25.0,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            heightSpace,
            Text(
              'KYC Verified',
              style: green14MediumTextStyle,
            ),
            heightSpace,
            Text(
              Userdata.fname,
              style: black18SemiBoldTextStyle,
            ),
            height5Space,
            Text(
              Userdata.mobile.toString(),
              style: grey16MediumTextStyle,
            ),
          ],
        ),
      );
    }
  }

  profileItem(icon, title, subtitle) {
    return Container(
      padding: EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 1.5,
          fixPadding * 2.0, fixPadding * 1.5),
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28.0,
            color: blackColor,
          ),
          width20Space,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: black16MediumTextStyle,
                ),
                SizedBox(height: 3.0),
                Text(
                  subtitle,
                  style: grey14RegularTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  divider() {
    return Container(
      width: double.infinity,
      height: 0.7,
      color: greyColor.withOpacity(0.15),
    );
  }
}
