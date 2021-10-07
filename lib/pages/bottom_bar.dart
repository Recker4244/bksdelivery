import 'dart:io';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/Eshop/Collections.dart';
import 'package:gold247/pages/Eshop/ItemsCat.dart';
import 'package:gold247/pages/screens.dart';
import 'package:gold247/pages/Eshop/eshop.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class BottomBar extends StatefulWidget {
  final int index;

  const BottomBar({Key key, this.index}) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  DateTime currentBackPressTime;
  int currentIndex;
  @override
  void initState() {
    super.initState();

    if (widget.index != null) {
      setState(() {
        currentIndex = widget.index;
      });
    } else {
      setState(() {
        currentIndex = 1;
      });
    }
  }

  changeIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 3.0,
        child: Container(
          height: 8.h,
          width: double.infinity,
          color: whiteColor,
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bottomBarItem(
                  FontAwesomeIcons.home, 'assets/icon/grey/user.png', 1),
              bottomBarItem(
                  FontAwesomeIcons.piggyBank, 'assets/icon/grey/user.png', 2),
              bottomBarItem(
                  FontAwesomeIcons.store, 'assets/icon/grey/user.png', 3),
              bottomBarItem(
                  FontAwesomeIcons.user, 'assets/icon/grey/user.png', 4),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        child: (currentIndex == 1)
            ? Home()
            : (currentIndex == 2)
                ? Portfolio()
                : (currentIndex == 3)
                    ? ItemsCat()
                    : Profile(),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
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

  bottomBarItem(icon, nonActiveIconPath, index) {
    return InkWell(
      onTap: () => changeIndex(index),
      child: Padding(
        padding: const EdgeInsets.all(fixPadding * 0.6),
        child: Icon(
          icon,
          color: (index == currentIndex) ? primaryColor : greyColor,
          size: 8.w,
        ),
      ),
    );
  }
}
