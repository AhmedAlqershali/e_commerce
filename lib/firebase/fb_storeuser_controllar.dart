import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/users.dart';

class FbStoreUserControllar {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  Future<bool> createName({required Users users}) async {
    return await _firebaseFirestore
        .collection('Users')
        .add(users.toMap())
        .then((DocumentReference value) {
      print(value.id);
      return true;
    }).onError((error, stackTrace) => false);
  }

  Stream<QuerySnapshot<Users>> getUsers() async* {

    yield* _firebaseFirestore
        .collection('Users')
        .withConverter<Users>(
        fromFirestore: (snapshot, options) => Users.fromMap(snapshot.data()!),
        toFirestore: (Users value, options) => value.toMap())
        .snapshots();
  }
  
}