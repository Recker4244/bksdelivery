import 'dart:convert';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/models/user.dart';

import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gold247/widget/column_builder.dart';
import 'package:gold247/models/transactions.dart';
////TODO     market

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Transaction> res = [];
  List<subscription> temp;
  List<Installments> credit = [];
  List<Installments> debit = [];
  Future getplans() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/subscription/user/${Userdata.sId}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      temp = List<subscription>.from(
          l.map((model) => subscription.fromJson(model)));
      for (int i = 0; i < temp.length; i++) {
        for (int j = 0; j < temp[i].installments.length; j++) {
          if (temp[i].installments[j].statustype == "Saved" ||
              temp[i].installments[j].statustype == "Released") {
            credit.add(temp[i].installments[j]);
          } else if (temp[i].installments[j].statustype == "Hold" ||
              temp[i].installments[j].statustype == "Sold" ||
              temp[i].installments[j].statustype == "Redeem") {
            debit.add(temp[i].installments[j]);
          }
        }
      }
      print("hello");
    } else {
      print(response.reasonPhrase);
    }

    return temp;
  }

  @override
  void initState() {
    debit = [];
    credit = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getplans(),
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
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: scaffoldBgColor,
                appBar: AppBar(
                  backgroundColor: scaffoldBgColor,
                  automaticallyImplyLeading: false,
                  title: Text('Your Transactions',
                      style: primaryColor22BoldTextStyle),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF95203D),
                      size: 32.0,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  bottom: TabBar(
                    labelColor: primaryColor,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'Credit',
                      ),
                      Tab(text: 'Debit'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [Credit(), Debit()],
                ),
              ),
            );
          } else {
            return Text("No data found");
          }
        }
      },
    );
  }

  Credit() {
    return (credit.isEmpty)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: greyColor.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.remove_red_eye,
                  color: greyColor,
                  size: 55.0,
                ),
              ),
              heightSpace,
              heightSpace,
              Center(
                child: Text(
                  'No transactions!',
                  style: grey20BoldTextStyle,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40.0,
                              width: 40.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: greenColor),
                              child: Icon(
                                Icons.call_received,
                                color: whiteColor,
                                size: 22.0,
                              ),
                            ),
                            widthSpace,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      (credit[index].amount.toString()),
                                      style: black16SemiBoldTextStyle,
                                    ),
                                    width5Space,
                                    Text(
                                      (credit[index]
                                          .statustype
                                          .replaceAll(RegExp('_'), ' ')
                                          .toUpperCase()),
                                      style: black16SemiBoldTextStyle,
                                    ),
                                  ],
                                ),
                                height5Space,
                                Text(
                                  (credit[index].createdAt),
                                  style: grey12BoldTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          (credit[index].amount.toString()),
                          style: black16BoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: primaryColor,
                    ),
                  ),
                ],
              );
            },
            itemCount: credit.length,
          );
  }

  Debit() {
    return (debit.isEmpty)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: greyColor.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.remove_red_eye,
                  color: greyColor,
                  size: 55.0,
                ),
              ),
              heightSpace,
              heightSpace,
              Text(
                'No transactions!',
                style: grey20BoldTextStyle,
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40.0,
                              width: 40.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: greenColor,
                              ),
                              child: Icon(
                                Icons.call_made_rounded,
                                color: whiteColor,
                                size: 22.0,
                              ),
                            ),
                            widthSpace,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      (debit[index].amount.toString()),
                                      style: black16SemiBoldTextStyle,
                                    ),
                                    width5Space,
                                    Text(
                                      (debit[index].statustype),
                                      style: black16SemiBoldTextStyle,
                                    ),
                                  ],
                                ),
                                height5Space,
                                Text(
                                  (debit[index].createdAt),
                                  style: grey12BoldTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          (debit[index].amount.toString()),
                          style: black16BoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: primaryColor,
                    ),
                  ),
                ],
              );
            },
            itemCount: debit.length);
  }
}
