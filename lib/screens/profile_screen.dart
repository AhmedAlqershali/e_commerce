import 'package:e_commerce/models/users.dart';
import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({Key? key}) : super(key: key);
  late Users users;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('images/Image.png')
              ),
              Column(
                children: [
                  Text(
                    'BadMan',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'abunael@gmail.com',
                    style: TextStyle(
                        color: Colors.black45, fontSize: 16, letterSpacing: 2),
                  ),
                ],
              )




              ],
            ),
            SizedBox(height: 15,),
            Container(

                   child: ListTile(
                      leading: const Icon(Icons.create),
                      title: const Text('Edit Account'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {},
                    ),
            ),
            Container(

                   child: ListTile(
                             leading: const Icon(Icons.location_on_outlined),
                             title: const Text('Shipping Address'),
                             trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                             onTap: () {},
                    ),
            ),
            Container(

                   child: ListTile(
                             leading: const Icon(Icons.access_time_filled_sharp),
                             title: const Text('Order History'),
                             trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                             onTap: () {},
                    ),
            ),
            Container(

                   child: ListTile(
                             leading: const Icon(Icons.credit_card_outlined),
                             title: const Text('Cards'),
                             trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                             onTap: () {},
                    ),
            ),
            Container(

                   child: ListTile(
                             leading: const Icon(Icons.notifications_active_outlined),
                             title: const Text('Notifications'),
                             trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                             onTap: () {},
                    ),
            ),
            Container(

                   child: ListTile(
                             leading: const Icon(Icons.logout),
                             title: const Text('Logout'),
                             onTap: () {
                               _confirmLogout();
                             },
                    ),
            ),


          ],
        ),
      ),
    );
  }
void _confirmLogout() {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            )
        ),
        title: Text(
          'Are you sure?',
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
        content: Text('Return to login!'),
        contentTextStyle: GoogleFonts.nunito(
          fontWeight: FontWeight.w300,
          color: Colors.black54,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAll(LoginScreen());
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('No'),
          )
        ],
      );
    },
  );
}
}
