import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:get/get.dart';

class FbHomeViewControllar extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // final CollectionReference<Map<String, dynamic>> _collectionReference =
  // FirebaseFirestore.instance.collection('Category');
  //
  // List<CategoryModel> get categoryModel => _categoryModel.obs;
  // final List<CategoryModel> _categoryModel = [];

  // FbHomeViewControllar() {
  //   getCategory();
  //   getBestSellingProducts();
  // }

  // void getCategory()  {
  //    _collectionReference.get().then((value) =>
  //   {
  //     for (int i = 0; i < value.docs.length; i++)
  //       {
  //         _categoryModel.add(CategoryModel.fromMap(value.docs[i].data())),
  //       }
  //   }
  //   );
  // }

  Stream<QuerySnapshot<CategoryModel>> getCategory() async* {

    yield* _firebaseFirestore
        .collection('Category')
        .withConverter<CategoryModel>(
        fromFirestore: (snapshot, options) => CategoryModel.fromMap(snapshot.data()!),
        toFirestore: (CategoryModel value, options) => value.toMap())
        .snapshots();
  }




  Stream<QuerySnapshot<ProductsModel>> getBestSellingProducts() async* {

    yield* _firebaseFirestore
        .collection('Product')
        .withConverter<ProductsModel>(
        fromFirestore: (snapshot, options) => ProductsModel.fromMap(snapshot.data()!),
        toFirestore: (ProductsModel value, options) => value.toMap())
        .snapshots();
  }




}
