import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/category.dart';
import 'package:gold247/models/collection.dart';
import 'package:gold247/models/product.dart';
import 'package:gold247/models/variety.dart';
import 'package:gold247/pages/Eshop/eshop.dart';

import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ItemsCat extends StatefulWidget {
  @override
  _ItemsCatState createState() => _ItemsCatState();
}

class _ItemsCatState extends State<ItemsCat> {
  List<category> categoryList;
  Future getcategories() async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/category/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['categories'];
      categoryList =
          List<category>.from(l.map((model) => category.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return categoryList;
  }

  List<product> productList;
  Future getproducts() async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/product/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      List det = jsonDecode(responseString);
      Iterable l = det;
      productList =
          List<product>.from(l.map((model) => product.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return productList;
  }

  List<variety> varietyList;
  Future getvarieties() async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/variety/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['varieties'];
      varietyList =
          List<variety>.from(l.map((model) => variety.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return varietyList;
  }

  List<collection> collectionList;
  Future getCollections() async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/collection/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['collections'];
      collectionList =
          List<collection>.from(l.map((model) => collection.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return collectionList;
  }

  Future<bool> init() async {
    await getCollections();
    await getcategories();
    await getvarieties();
    await getproducts();
    return true;
  }

  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
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
            return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: whiteColor,
                    title: Center(
                      child: Text(
                        'Shop Finest Jewellery',
                        style: primaryColor18BoldTextStyle,
                      ),
                    ),
                  ),
                  backgroundColor: scaffoldBgColor,
                  body: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        height: 30.h,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 20.h,
                                child: Padding(
                                    padding: const EdgeInsets.all(fixPadding),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Eshop(
                                                      id: productList[index]
                                                          .sId,
                                                      type: "preview",
                                                    )));
                                      },
                                      child: previewCard(
                                        name: productList[index].name,
                                        id: productList[index].sId,
                                      ),
                                    )),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: productList.length,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        'Our Collection ',
                        style: primaryColor16MediumTextStyle,
                      ),
                      heightSpace,
                      Container(
                        height: 30.h,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Padding(
                                    padding: const EdgeInsets.all(fixPadding),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Eshop(
                                                      id: collectionList[index]
                                                          .sId,
                                                      type: "collections",
                                                    )));
                                      },
                                      child: CollectionCard(
                                          name: collectionList[index]
                                              .collectionName),
                                    )),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: collectionList.length,
                        ),
                      ),
                      height20Space,
                      Text(
                        'Trending Categories ',
                        style: primaryColor16MediumTextStyle,
                      ),
                      heightSpace,

                      Container(
                        height: 35.h,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2/3),
                              itemCount: categoryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Eshop(
                                                  id: categoryList[index].sId,
                                                  type: "category",
                                                )));
                                  },
                                  child: CategoryCard(
                                    name: categoryList[index].categoryName,
                                  ),
                                );
                              }),
                        ),
                      ),
                      //height20Space,
                      Text(
                        'Our Varieties ',
                        style: primaryColor16MediumTextStyle,
                      ),
                      heightSpace,
                      Container(
                        height: 50.h,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1 / 1),
                              itemCount: varietyList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Eshop(
                                                    id: varietyList[index]
                                                        .sId,
                                                    type: "variety",
                                                  )));
                                    },
                                    child: varietyCard(id: varietyList[index].sId,name: varietyList[index].varietyName,));
                              }),
                        ),
                      ),
                      height20Space,
                    ],
                  ))),
            );
          } else {
            return Text("No data found");
          }
        }
      },
    );
  }
}

class varietyCard extends StatelessWidget {
  final String name;
  final String id;
  varietyCard({
  this.name,this.id
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 60.w,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              name,
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final String id;
  CategoryCard({this.id, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
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
        children: [
          CarouselSlider.builder(
            itemCount:3,
            itemBuilder: (context, Index, realIndex) {

                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage("https://staticimg.titan.co.in/Tanishq/Catalog/5110982QJAAA00_1.jpg?impolicy=pqmed&imwidth=640"),
                      )),
                );

            },
            options: CarouselOptions(
              height: 30.h,
              aspectRatio: 16 / 9,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
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
                    "category",
                    style: primaryColor14MediumTextStyle,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: scaffoldBgColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //   Card(
    //   color: primaryColor,
    //   child: Center(child: Text(name,style: TextStyle(color: Colors.white),)),
    // );
  }
}

class previewCard extends StatelessWidget {
  final String name;
  final String id;
  const previewCard({Key key, this.name, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              name,
              style: TextStyle(color: Colors.black, fontSize: 15.sp),
            )),
      ),
    );
  }
}

class CollectionCard extends StatelessWidget {
  final String name;
  final String id;
  const CollectionCard({Key key, this.id, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          width: 80.w,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                )),
          ),
        ));
  }
}
