import 'package:gold247/constant/constant.dart';
import 'package:gold247/widget/column_builder.dart';
import 'package:flutter/material.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key key}) : super(key: key);

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  // final valueController = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     valueController.text = '10';
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: primaryColor,
  //       titleSpacing: 0.0,
  //       title: Text(
  //         'Deposit',
  //         style: white16SemiBoldTextStyle,
  //       ),
  //     ),
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Text(
  //           '\$152',
  //           style: black18BoldTextStyle,
  //         ),
  //         height5Space,
  //         Text(
  //           'Current Balance',
  //           style: black12RegularTextStyle,
  //         ),
  //         SizedBox(height: fixPadding * 3.0),
  //         // Amount Textfield Start
  //         Theme(
  //           data: ThemeData(
  //             primaryColor: greyColor,
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
  //             child: TextField(
  //               controller: valueController,
  //               keyboardType: TextInputType.number,
  //               style: black16RegularTextStyle,
  //               decoration: InputDecoration(
  //                 labelText: 'Amout',
  //                 labelStyle: black16RegularTextStyle,
  //                 suffix: Text(
  //                   '\$',
  //                   style: black16RegularTextStyle,
  //                 ),
  //                 border: OutlineInputBorder(
  //                   borderSide: BorderSide(color: greyColor, width: 0.7),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         // Amount Textfield End
  //         height20Space,
  //         // Amount Suggestion Start
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             amountSuggestionItem(10),
  //             width20Space,
  //             amountSuggestionItem(50),
  //             width20Space,
  //             amountSuggestionItem(100),
  //             width20Space,
  //             amountSuggestionItem(500),
  //           ],
  //         ),
  //         // Amount Suggestion End

  //         heightSpace,
  //         Text(
  //           'Min \$10, Max \$3,000',
  //           style: black14MediumTextStyle,
  //         ),

  //         SizedBox(height: fixPadding * 3.0),

  //         // Deposit Button Start
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
  //           child: Material(
  //             elevation: 2.0,
  //             borderRadius: BorderRadius.circular(5.0),
  //             child: InkWell(
  //               onTap: () => Navigator.pop(context),
  //               borderRadius: BorderRadius.circular(5.0),
  //               child: Container(
  //                 width: double.infinity,
  //                 padding: EdgeInsets.all(fixPadding * 0.7),
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(5.0),
  //                   color: primaryColor,
  //                 ),
  //                 child: Text(
  //                   'Deposit'.toUpperCase(),
  //                   style: white16MediumTextStyle,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         // Deposit Button End
  //         height5Space,
  //         Text(
  //           'Processing time upto 15 minutes',
  //           style: black14MediumTextStyle,
  //         )
  //       ],
  //     ),
  //   );
  // }

  // amountSuggestionItem(amount) {
  //   return InkWell(
  //     onTap: () {
  //       setState(() {
  //         valueController.text = '$amount';
  //       });
  //     },
  //     borderRadius: BorderRadius.circular(30.0),
  //     child: Container(
  //       padding: EdgeInsets.all(fixPadding),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(30.0),
  //         color: greyColor.withOpacity(0.2),
  //       ),
  //       child: Text(
  //         '\$$amount',
  //         style: black14RegularTextStyle,
  //       ),
  //     ),
  //   );
  // }
  final weightController = TextEditingController();
  final amountController = TextEditingController();
  final portfolioItem = [
    {
      'name': '24 KT GOLD',
      'shortName': 'BTC',
      'image': 'assets/crypto_icon/gold_ingots.png',
      'value': 'INR 4,580.00',
      'status': 'up',
      'change': '11.0%',
      'coinTotal': 'Buy Rate'
    }
  ];
  @override
  void initState() {
    super.initState();
    setState(() {
      weightController.text = '1.00';
      amountController.text = '4,580';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0.0,
        title: Text(
          'BUY GOLD',
          style: TextStyle(
            color: scaffoldBgColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '15.80 GRAM',
            style: black18BoldTextStyle,
          ),
          height5Space,
          Text(
            'Available Balance',
            style: black12RegularTextStyle,
          ),
          // SizedBox(height: fixPadding * 3.0),
          myPortfolioItems(),
          // Amount Textfield Start
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              color: whiteColor,
              // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
              child: Theme(
                data: ThemeData(
                  primaryColor: whiteColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: primaryColor,
                  ),
                ),
                child: TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  style: primaryColor16MediumTextStyle,
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
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Theme(
          //     data: ThemeData(
          //       primaryColor: primaryColor,
          //     ),
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          //       child: TextField(
          //         controller: weightController,
          //         keyboardType: TextInputType.number,
          //         style: primaryColor16MediumTextStyle,
          //         decoration: InputDecoration(
          //           labelText: 'Weight',
          //           labelStyle: TextStyle(
          //               color: primaryColor,
          //               fontSize: 20,
          //               fontWeight: FontWeight.w600),
          //           suffix: Text(
          //             'GRAM',
          //             style: primaryColor16MediumTextStyle,
          //           ),
          //           border: OutlineInputBorder(
          //             borderSide: BorderSide(color: primaryColor, width: 0.7),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              color: whiteColor,
              // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
              child: Theme(
                data: ThemeData(
                  primaryColor: whiteColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: primaryColor,
                  ),
                ),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: primaryColor16MediumTextStyle,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    suffix: Text(
                      'INR',
                      style: primaryColor16MediumTextStyle,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Theme(
          //     data: ThemeData(
          //       primaryColor: primaryColor,
          //     ),
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          //       child: TextField(
          //         controller: amountController,
          //         keyboardType: TextInputType.number,
          //         style: primaryColor16MediumTextStyle,
          //         decoration: InputDecoration(
          //           labelText: 'Amount',
          //           labelStyle: TextStyle(
          //               color: primaryColor,
          //               fontSize: 20,
          //               fontWeight: FontWeight.w600),
          //           suffix: Text(
          //             'INR',
          //             style: primaryColor16MediumTextStyle,
          //           ),
          //           border: OutlineInputBorder(
          //             borderSide: BorderSide(color: primaryColor, width: 0.7),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Amount Textfield End
          // height20Space,
          // Amount Suggestion Start
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     amountSuggestionItem(10),
          //     width20Space,
          //     amountSuggestionItem(50),
          //     width20Space,
          //     amountSuggestionItem(100),
          //     width20Space,
          //     amountSuggestionItem(500),
          //   ],
          // ),
          // Amount Suggestion End

          // heightSpace,
          // Text(
          //   'Min \$10, Max \$3,000',
          //   style: black14MediumTextStyle,
          // ),

          SizedBox(height: fixPadding * 3.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 55,

                // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'buy gold'.toUpperCase(),
                      style: TextStyle(
                        color: scaffoldBgColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Container(
                    //   height: 30.0,
                    //   width: 1.0,
                    //   color: whiteColor,
                    // ),
                    // Text(
                    //   'redeem gold'.toUpperCase(),
                    //   style: TextStyle(
                    //     color: scaffoldBgColor,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          // Withdraw Button Start
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     child: Material(
          //       elevation: 2.0,
          //       borderRadius: BorderRadius.circular(5.0),
          //       child: InkWell(
          //         onTap: () => Navigator.pop(context),
          //         borderRadius: BorderRadius.circular(5.0),
          //         child: Container(
          //           width: double.infinity,
          //           padding: EdgeInsets.all(fixPadding * 0.7),
          //           alignment: Alignment.center,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(5.0),
          //             color: primaryColor,
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Text(
          //                 'sell gold'.toUpperCase(),
          //                 style: TextStyle(
          //                   color: scaffoldBgColor,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               Container(
          //                 height: 30.0,
          //                 width: 1.0,
          //                 color: whiteColor,
          //               ),
          //               Text(
          //                 'redeem gold'.toUpperCase(),
          //                 style: TextStyle(
          //                   color: scaffoldBgColor,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Withdraw Button End
          height5Space,
          Text(
            'You have 0:43 Minutes',
            style: black14SemiBoldTextStyle,
          ),
          // SizedBox(
          //   height: 50,
          // ),
          // Text(
          //   "You can also prefer to partly sell or redeem by\n             entering your preferred weight",
          //   style: black14SemiBoldTextStyle,
          // ),
        ],
      ),
    );
  }

  // amountSuggestsaionItem(amount) {
  //   return InkWell(
  //     onTap: () {
  //       setState(() {
  //         valueController.text = '$amount';
  //         valueController.text = '$amount';
  //       });
  //     },
  //     borderRadius: BorderRadius.circular(30.0),
  //     child: Container(
  //       padding: EdgeInsets.all(fixPadding),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(30.0),
  //         color: greyColor.withOpacity(0.2),
  //       ),
  //       child: Text(
  //         '\$$amount',
  //         style: black14RegularTextStyle,
  //       ),
  //     ),
  //   );
  // }
  myPortfolioItems() {
    return ColumnBuilder(
      itemCount: portfolioItem.length,
      itemBuilder: (context, index) {
        final item = portfolioItem[index];
        return Padding(
          padding: (index != portfolioItem.length - 1)
              ? EdgeInsets.fromLTRB(
                  fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0.0)
              : EdgeInsets.all(fixPadding * 2.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: whiteColor,
                // boxShadow: [
                //   BoxShadow(
                //     blurRadius: 4.0,
                //     spreadRadius: 1.0,
                //     color: blackColor.withOpacity(0.05),
                //   ),
                // ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    item['image'],
                    height: 40.0,
                    width: 40.0,
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
                              style: primaryColor18BoldTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${item['coinTotal']}',
                                  style: black12MediumTextStyle,
                                ),
                                widthSpace,
                                (item['status'] == 'up')
                                    ? Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.arrow_drop_down,
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                Text(
                                  item['change'],
                                  style: black12MediumTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          item['value'],
                          style: black16BoldTextStyle,
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
