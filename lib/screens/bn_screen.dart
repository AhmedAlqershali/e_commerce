import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/bn_screen_item.dart';
import 'home_screen.dart';

class BnScreen extends StatefulWidget {
  const BnScreen({Key? key}) : super(key: key);

  @override
  State<BnScreen> createState() => _BnScreenState();
}

class _BnScreenState extends State<BnScreen> {
  int _currentIndex = 0;
  final List<BnItem> _bnScreens = <BnItem>[
     BnItem(widget: HomeScreen(), title: 'Home' ),
     BnItem(widget:CartScreen() , title: 'Cart'),
     BnItem(widget: ProfileScreen(), title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(

        iconTheme: const IconThemeData(color: Colors.black),
    title: Text(
    _bnScreens[_currentIndex].title,
    style: GoogleFonts.nunito(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    ),
      ),
        ),


      body: _bnScreens[_currentIndex].widget,


      bottomNavigationBar:bottomNavigationBar() ,









    );
  }




  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text('Explore'),
            ),
            label: '',
            icon: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Image.asset(
                'images/Icon_Explore.png',
                fit: BoxFit.contain,
                width: 20,
              ),
            )),
        BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text('Cart'),
            ),
            label: '',

            icon: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Image.asset(
                'images/Icon_Cart.png',
                fit: BoxFit.contain,
                width: 20,
              ),
            )),
        BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text('Profaile'),
            ),
            label: '',
            icon: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Image.asset(
                'images/Icon_User.png',
                fit: BoxFit.contain,
                width: 20,
              ),
            )),
      ],
      onTap: (int itemIndex) {
        setState(() {
          _currentIndex = itemIndex;
        });
      },
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }


}
