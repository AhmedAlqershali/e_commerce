import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/firebase_response.dart';
import 'package:e_commerce/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FbAuthControllar {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<FirebaseResponse> createAccount(
      {  Users? users,required String email, required String password}) async {
    try {
      UserCredential _userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _userCredential.user!.sendEmailVerification();
      await _firebaseAuth.signOut();
      return FirebaseResponse(
          success: true,
          message: 'Account created successfully, activate to start');
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(success: false, message: e.message ?? '');
    }
  }

  Future<FirebaseResponse> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential _usercredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      String message = _usercredential.user!.emailVerified
          ? 'Logged in successfully'
          : 'Login failed!, activate your email';
      return FirebaseResponse(
          success: _usercredential.user!.emailVerified, message: message);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(success: false, message: e.message ?? '');
    }
  }

  Future<FirebaseResponse> sendPasswordResetEmail(
      {required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return FirebaseResponse(
          success: true, message: 'Password reset email sent!');
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(success: false, message: e.message ?? '');
    }
  }


  Future<void> signOut() async => _firebaseAuth.signOut();

  User get user => _firebaseAuth.currentUser!;

  bool get signedIn => _firebaseAuth.currentUser != null;



  Future<UserCredential> Google()async {
    GoogleSignIn _googleSignIn=GoogleSignIn();

       GoogleSignInAccount? googleSignInAccount= await _googleSignIn.signIn();


      GoogleSignInAuthentication? googleSignInAuthentication=
      await googleSignInAccount?.authentication;

       AuthCredential authCredential= GoogleAuthProvider.credential(
         accessToken: googleSignInAuthentication?.accessToken,
         idToken:googleSignInAuthentication?.idToken,
      );
     return  await _firebaseAuth.signInWithCredential(authCredential);




  }
}
