import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/firebase/fb_homeview_controllar.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'details_screen.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Category'),
      ),


      body:Container(
        child: StreamBuilder<QuerySnapshot<ProductsModel>>(
            stream: FbHomeViewControllar().getBestSellingProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData &&
                  snapshot.data!.docs.isNotEmpty) {
                return GridView.builder(

                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,

                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(Detalisscreen(
                            productsModel:
                            snapshot.data!.docs[index].data()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(

                          child: Column(

                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(50),
                                    color: Colors.grey.shade100),
                                height: 160,
                                child: Container(
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
                      ),
                    );

                  }, gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 132/214
                ),





                );

              } else {
                return Center(
                  child: Text('NO Product'),
                );
              }
            }),
      ),

    );
  }
}
