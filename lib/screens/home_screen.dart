import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/firebase/fb_homeview_controllar.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/screens/category_screen.dart';
import 'package:e_commerce/screens/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> names = <String>[
    'Man',
    'Wemon',
    'a',
    'a',
    'a',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [
              _SearchText(),
              SizedBox(
                height: 15,
              ),
              Container(
                  alignment: Alignment.topLeft, child: Text('Categories ')),
              Container(
                height: 100,
                child: StreamBuilder<QuerySnapshot<CategoryModel>>(
                    stream: FbHomeViewControllar().getCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: ()=>Get.to(CategoryScreen()),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 80,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey.shade100),
                                    height: 60,
                                    width: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(snapshot
                                          .data!.docs[index]
                                          .data()
                                          .image),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      '${snapshot.data!.docs[index].data().name}')
                                ],
                              ),
                            );
                          },
                        );
                        ;
                      } else {
                        return Center(
                          child: Text('NO Product'),
                        );
                      }
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Selling',
                    style: GoogleFonts.nunito(fontSize: 18),
                  ),
                  TextButton(onPressed: (){},
                      child:Text(
                    'See All',
                    style: GoogleFonts.nunito(fontSize: 16),
                  ))

                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 240,
                child: StreamBuilder<QuerySnapshot<ProductsModel>>(
                    stream: FbHomeViewControllar().getBestSellingProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(Detalisscreen(
                                    productsModel:
                                        snapshot.data!.docs[index].data()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * .4,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey.shade100),
                                      height: 160,
                                      child: Container(
                                          height: 220,
                                          child: Image.network(
                                            snapshot.data!.docs[index]
                                                .data()
                                                .image,
                                            fit: BoxFit.fitWidth,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .data()
                                              .name,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .data()
                                              .sized,
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          '\$ ${snapshot.data!.docs[index].data().salary}',
                                          style: TextStyle(
                                              color: Color(0xff00C569)),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        ;
                      } else {
                        return Center(
                          child: Text('NO Product'),
                        );
                      }
                    }),
              ),
            ],
          ),
        ));
  }

  Widget _SearchText() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none, prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
