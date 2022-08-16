import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/cart_products_model.dart';

import 'package:get/get.dart';

class FbCartProductControllar extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;



  String total= '';



  Future<bool> createName({required CartProductsModel cartProductsModel}) async {
    return await _firebaseFirestore
        .collection('CartProduct')
        .add(cartProductsModel.toMap())
        .then((DocumentReference value) {
      print(value.id);
      return true;
    }).onError((error, stackTrace) => false);
  }

  Stream<QuerySnapshot<CartProductsModel>> getCategory() async* {
    yield* _firebaseFirestore
        .collection('CartProduct')
        .withConverter<CartProductsModel>(
            fromFirestore: (snapshot, options) =>
                CartProductsModel.fromMap(snapshot.data()!),
            toFirestore: (CartProductsModel value, options) => value.toMap())
        .snapshots();
  }

  Future<bool> delete({required String path}) async {
    return await _firebaseFirestore
        .collection('CartProduct')
        .doc(path)
        .delete()
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }





}
