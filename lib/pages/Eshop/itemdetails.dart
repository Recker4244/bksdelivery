import 'dart:convert';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/SingleItemDetail.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import '../portfolio/Cart.dart';
import 'package:http/http.dart' as http;
class Eshop extends StatefulWidget {
  String id;
  String type;
  Eshop({this.id,this.type});
  @override
  _EshopState createState() => _EshopState();
}

class _EshopState extends State<Eshop> {
  List<SingleItemDetails> singleItemDetails;
  Future getSingleItemId() async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/itemdetails/${widget.id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      singleItemDetails=List<SingleItemDetails>.from(l.map((e) => SingleItemDetails.fromJson(e)));
    } else {
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          '1 GRAM 24KT GOLD 99.99 PURE GOLD COIN',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: scaffoldBgColor,
          ),
        ),
      ),
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
              GestureDetector(
                child: Container(
                  height: 50.0,
                  width: (width - 1.0) / 2,
                  alignment: Alignment.center,
                  child: Text(
                    'ADD TO CART'.toUpperCase(),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Cart();
                    }),
                  );
                },
                child: Container(
                  height: 50.0,
                  width: (width - 1.0) / 2,
                  alignment: Alignment.center,
                  child: Text(
                    'BUY NOW'.toUpperCase(),
                    style: white16BoldTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: whiteColor.withOpacity(0.5),
              child: Center(
                child: Image(
                  image: AssetImage('assets/crypto_icon/btc.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(fixPadding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Amtcounter(),
                  Description(),
                  height20Space,
                  height20Space,
                  SKU_Number(),
                  height20Space,
                  Charges_Applied(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Amtcounter extends StatefulWidget {


  @override
  _AmtcounterState createState() => _AmtcounterState();
}

class _AmtcounterState extends State<Amtcounter> {
  int count = 1;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'INR 4720',
          style: primaryColor22BoldTextStyle,
        ),
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: decrement,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                  Radius.circular(5),
                )),
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: Icon(Icons.minimize_sharp),
              ),
            ),
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
                '$count',
                style: white16BoldTextStyle,
              ),
              padding: EdgeInsets.all(10),
            ),
            GestureDetector(
              onTap: increment,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                  Radius.circular(5),
                )),
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Description extends StatelessWidget {
  const Description({
   this.karatage,this.grossWight
  });
final String karatage;
final String grossWight;
@override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Description',
          style: primaryColor18BoldTextStyle,
        ),
        heightSpace,
        Text(
          'Metal Purity : ${karatage}',
          style: primaryColor16BoldTextStyle,
        ),
        Text(
          'Packaging : Tamperproof Packaging',
          style: primaryColor16BoldTextStyle,
        ),
        Text(
          'Weight : ${grossWight} gram',
          style: primaryColor16BoldTextStyle,
        ),
        heightSpace,
        Text(
          'This item cannot be cancelled, returned or replaced once it has been ordered',
          style: primaryColor16MediumTextStyle,
        ),
      ],
    );
  }
}

class SKU_Number extends StatelessWidget {
  const SKU_Number({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'SKU Number',
          style: primaryColor18BoldTextStyle,
        ),
        Text(
          'BKS57656765',
          style: black16BoldTextStyle,
        ),
      ],
    );
  }
}

class Charges_Applied extends StatelessWidget {
  const Charges_Applied({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'CHARGES APPLIED',
          style: primaryColor18BoldTextStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'GST',
              style: black16BoldTextStyle,
            ),
            Text(
              'INR 3666',
              style: black16BoldTextStyle,
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Divider(
            thickness: 1,
            color: blackColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'MINTING',
              style: black16BoldTextStyle,
            ),
            Text(
              'INR 3666',
              style: black16BoldTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}
