import 'package:gold247/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/user.dart';

////TODO     market

class Market extends StatefulWidget {
  const Market({Key key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  List<subscription> temp;
  List<subscription> running;
  List<subscription> forfeited;
  List<subscription> complete;
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

      running = temp.where((item) => item.status == "Processing").toList();
      forfeited = temp.where((item) => item.status == "Cancelled").toList();
      complete = temp.where((item) => item.status == "Completed").toList();
    } else {
      print(response.reasonPhrase);
    }

    return temp;
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
              length: 3,
              child: Scaffold(
                backgroundColor: scaffoldBgColor,
                appBar: AppBar(
                  backgroundColor: whiteColor,
                  automaticallyImplyLeading: true,
                  title: Text(
                    'Market is up 2.06% today',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: greenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Running'),
                      Tab(text: 'Forfieted'),
                      Tab(text: 'Completed'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Running(
                      running: running,
                    ),
                    Forfeited(
                      forfeited: forfeited,
                    ),
                    Completed(
                      completed: complete,
                    ),
                  ],
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
}
