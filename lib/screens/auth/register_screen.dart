import 'package:e_commerce/firebase/fb_auth_controllar.dart';
import 'package:e_commerce/firebase/fb_storeuser_controllar.dart';
import 'package:e_commerce/models/firebase_response.dart';
import 'package:e_commerce/models/users.dart';
import 'package:e_commerce/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({Key? key,this.users}) : super(key: key);

    Users? users;


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {


  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  bool _showPassword = false;

  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _navigateToRegister;
    // _tapGestureRecognizer.onTap = _navigateToRegister;
  }

  void _navigateToRegister() =>
      Navigator.pushNamed(context, '/register_screen');

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Sign Up,',
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: _nameTextController,
              keyboardType: TextInputType.name,
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
                hintText: 'Name',
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                errorText: _nameError,
                constraints: BoxConstraints(
                  // minHeight: 50,
                  maxHeight: _nameError == null ? 55 : 75,
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
            SizedBox(
              height: 25,
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
            const SizedBox(height: 25),
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => performRegister(),
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
          ],
        ),
      ),
    );
  }

  void performRegister() {
    if (checkData()) {
      Register();
      _save();
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      updateErrorsState();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Logged in successfully'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue.shade300,
          duration: const Duration(seconds: 3),
          dismissDirection: DismissDirection.horizontal,
        ),
      );
      return true;
    }

    updateErrorsState();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Logged in fialed'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
    return false;
  }

  void updateErrorsState() {
    setState(() {
      _nameError = _nameTextController.text.isEmpty ? 'Enter your Name' : null;
      _emailError =
          _emailTextController.text.isEmpty ? 'Enter email address' : null;
      _passwordError =
          _passwordTextController.text.isEmpty ? 'Enter password' : null;
    });
  }

  void Register() async {
    FirebaseResponse firebaseResponse = await FbAuthControllar().createAccount(
        users: users,
        email: _emailTextController.text,
        password: _passwordTextController.text

    );

    showSnackBar(
      context,
      message: firebaseResponse.message,
      error: !firebaseResponse.success,
    );
    if (firebaseResponse.success) Navigator.pop(context);
  }



  Future<void> _save() async {
    bool status = widget.users == await FbStoreUserControllar().createName(users: users);



    if (status) {
      widget.users == null ? '' : Navigator.pop(context);
    }
  }




  Users get users {
    Users users = Users();
    if (widget.users != null) {
      users.path = widget.users!.path;
    }
    users.name= _nameTextController.text;
    users.email= _emailTextController.text;
    return users;
  }
}
