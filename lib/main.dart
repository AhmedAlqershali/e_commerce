import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/screens/auth/register_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Shop',
      initialRoute: '/login_screen',

      routes: {
        '/login_screen':(context)=>LoginScreen(),
        '/register_screen':(context)=>RegisterScreen(),
        '/home_screen':(context)=>HomeScreen(),

      },



    );
  }
}
