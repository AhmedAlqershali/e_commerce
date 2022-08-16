import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/firebase/fb_cart_product_controllar.dart';
import 'package:e_commerce/models/cart_products_model.dart';
import 'package:e_commerce/screens/check_out.dart';
import 'package:e_commerce/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CartScreen extends StatefulWidget {
   CartScreen({Key? key}) : super(key: key);
  CartProductsModel? cartProductsModel;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with Helpers{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: Container(
          child: StreamBuilder<QuerySnapshot<CartProductsModel>>(
              stream: FbCartProductControllar().getCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(

                          height: 140,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: 140,
                                  child: Image.network(
                                    snapshot.data!.docs[index].data().image,
                                    fit: BoxFit.fill,
                                  )),
                              Padding(

                                padding: const EdgeInsets.only(left: 10,top: 30),
                                child: Column(

                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Container(

                                        alignment: Alignment.center,
                                        child: Text(
                                          snapshot.data!.docs[index].data().name,
                                          style: TextStyle(fontSize: 17),
                                           overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Text(
                                        '\$200' ,

                                        style:
                                            TextStyle(color: Color(0xff00C569)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),

                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () async =>_deleteCartProduct(path: snapshot.data!.docs[index].id),
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                            height: 10,
                          ));
                } else {
                  return Center(
                    child: Text('NO Product'),
                  );
                }
              }
              ),
        ),
      ),
        StreamBuilder<QuerySnapshot<CartProductsModel>>(
          stream: FbCartProductControllar().getCategory(),
          builder: (context, snapshot) {
            return Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'TOTAL',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '\$ 2000' ,
                              style: TextStyle(color: Color(0xff00C569), fontSize: 18),
                            )
                          ],
                        ),
                        Container(
                          height: 55,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () =>Get.to(CheckoutScreen()),
                            child: Text('CHECKOUT'),
                            style: ElevatedButton.styleFrom(
                              maximumSize: Size(150, 55),
                              primary: Color(0xff00C569),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          }
        ),


    ]));
  }

  Future<void> _deleteCartProduct({required String path}) async {
    bool deleted = await FbCartProductControllar().delete(path: path);
    showSnackBar(context,
        message: deleted ? 'Deleted Successfully' : 'Delete failed',
        error: !deleted);
  }


}

