import 'package:e_commerce/firebase/fb_auth_controllar.dart';
import 'package:e_commerce/models/firebase_response.dart';
import 'package:e_commerce/screens/auth/register_screen.dart';
import 'package:e_commerce/screens/bn_screen.dart';
import 'package:e_commerce/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;


  String? _emailError;
  String? _passwordError;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    // _tapGestureRecognizer.onTap = _navigateToRegister;
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Welcome,',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Spacer(),
                TextButton(
                    onPressed: () => Get.to(RegisterScreen()),
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.nunito(
                          color: Color(0xff00C569),
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Sign in  to continue ',
              style: GoogleFonts.roboto(
                color: const Color(0xFF716F87),
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              enabled: true,
              style: GoogleFonts.nunito(
                color: Colors.black45,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              expands: true,
              minLines: null,
              maxLines: null,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Email',
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                errorText: _emailError,
                constraints: BoxConstraints(
                  // minHeight: 50,
                  maxHeight: _emailError == null ? 55 : 75,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordTextController,
              keyboardType: TextInputType.text,
              minLines: 1,
              maxLines: 1,
              expands: false,
              style: GoogleFonts.nunito(
                color: Colors.black45,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              obscureText: !_showPassword,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Password',
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                errorText: _passwordError,
                constraints: BoxConstraints(
                  // minHeight: 50,
                  maxHeight: _passwordError == null ? 55 : 75,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                alignment: Alignment.bottomRight,
                child: RichText(
                  text: TextSpan(
                    text: 'Forget Password? ',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => performLogin(),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff00C569),
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: Text(
                'SIGN IN',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                '-OR-',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Image.asset('images/Icon_Facebook.png'),
                  Spacer(),
                  Text(
                    'Sign In with Facebook',
                    style:
                        GoogleFonts.nunito(color: Colors.black, fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => LoginGoogle(),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Image.asset('images/icons8_Google_2.png'),
                    Spacer(),
                    Text(
                      'Sign In with Google',
                      style:
                          GoogleFonts.nunito(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performLogin()async {
     if (checkData()) {




       await Login();






    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  void updateErrorsState() {
    setState(() {
      _emailError =
          _emailTextController.text.isEmpty ? 'Enter email address' : null;
      _passwordError =
          _passwordTextController.text.isEmpty ? 'Enter password' : null;
    });
  }




  Future<void> Login() async {
    FirebaseResponse firebaseResponse = await FbAuthControllar().signIn(
        email: _emailTextController.text,
        password: _passwordTextController.text);
    showSnackBar(
      context,
      message: firebaseResponse.message,
      error: !firebaseResponse.success,
    );
    if(firebaseResponse.success)
    Get.to(BnScreen());
  }







  void LoginGoogle() async {
    FbAuthControllar().Google();

    showSnackBar(
      context,
      message: 'Done',
      error: false,
    );
  }
}
