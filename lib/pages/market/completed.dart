import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Completed extends StatefulWidget {
  final List<subscription> completed;
  const Completed({Key key, this.completed}) : super(key: key);

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  int compute(subscription cal) {
    int amount = 0;
    for (int i = 0; i < cal.installments.length; i++) {
      if (cal.installments[i].statustype == "Saved" ||
          cal.installments[i].statustype == "Released") {
        amount += int.parse(cal.installments[i].gold);
      }
    }
    return amount;
  }

  @override
  Widget build(BuildContext context) {
    return (widget.completed == null)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightSpace,
              heightSpace,
              Center(
                child: Text(
                  'No Plans',
                  style: grey20BoldTextStyle,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: widget.completed.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              int gold = compute(widget.completed[index]);
              final item = widget.completed[index];
              return Padding(
                padding: (index != widget.completed.length - 1)
                    ? EdgeInsets.fromLTRB(fixPadding * 1.5, fixPadding * 1.5,
                        fixPadding * 1.5, 0.0)
                    : EdgeInsets.all(fixPadding * 1.5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.center,
                            child: TotalBalance(
                              sub: widget.completed[index],
                            )));
                  },
                  child: Container(
                    height: 138,
                    width: 90,
                    decoration: BoxDecoration(
                      color: scaffoldBgColor,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                widthSpace,
                                Image.asset(
                                  "assets/crypto_icon/gold_ingots.png",
                                  height: 44,
                                  width: 44,
                                  fit: BoxFit.cover,
                                ),
                                widthSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Gold Saved in this Plan",
                                      style: grey14BoldTextStyle,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${gold} GRAM",
                                      style: black16BoldTextStyle,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: primaryColor,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'SELL/REDEEM',
                                style: black14BoldTextStyle,
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
          );
  }
}
