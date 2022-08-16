import 'package:e_commerce/firebase/fb_cart_product_controllar.dart';
import 'package:e_commerce/models/cart_products_model.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Detalisscreen extends StatefulWidget {
  Detalisscreen({Key? key, required this.productsModel}) : super(key: key);
  late ProductsModel productsModel;
  CartProductsModel? cartProductsModel;

  @override
  State<Detalisscreen> createState() => _DetalisscreenState();
}

class _DetalisscreenState extends State<Detalisscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            child: Column(
              children: [
                Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.productsModel.image,
                      fit: BoxFit.fill,
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.productsModel.name,
                      style: GoogleFonts.nunito(fontSize: 26),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .45,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Size'),
                          Text(widget.productsModel.sized),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .4,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Color'),
                          Container(
                            width: 40,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                              color: widget.productsModel.color,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Details:',
                      style: TextStyle(fontSize: 18),
                    )),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    widget.productsModel.info,
                    style: TextStyle(fontSize: 18, height: 1.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'PRICE',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '\$' + widget.productsModel.salary,
                            style: TextStyle(
                                color: Color(0xff00C569), fontSize: 20),
                          ),
                        ],
                      ),
                      Container(
                          height: 55,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () => _save(),
                            child: Text('Add'),
                            style: ElevatedButton.styleFrom(
                              maximumSize: Size(150, 55),
                              primary: Color(0xff00C569),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    bool status = widget.cartProductsModel ==
        await FbCartProductControllar()
            .createName(cartProductsModel: cartProductsModel);

    if (status) {
      widget.cartProductsModel == null ? '' : Navigator.pop(context);
    }
  }

  CartProductsModel get cartProductsModel {
    CartProductsModel cartProductsModel = CartProductsModel();
    if (widget.cartProductsModel != null) {
      cartProductsModel.path = widget.cartProductsModel!.path;
    }

    cartProductsModel.name = widget.productsModel.name;
    cartProductsModel.image = widget.productsModel.image;
    cartProductsModel.salary = widget.productsModel.salary;

    return cartProductsModel;
  }
}
