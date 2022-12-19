import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/constant.dart';
import 'package:leaderboard/home_page.dart';
import 'package:leaderboard/public_voting.dart';
import 'package:leaderboard/register.dart';
import 'package:leaderboard/responsive.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool _loading = true;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        if (preferences.getString('email') != null &&
            preferences.getString('password') != null &&
            preferences.getString('password') != 'null' &&
            preferences.getString('email') != 'null') {
          await http
              .post(Uri.parse('https://api.halftiicket.com/login'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode({
                    'email': preferences.getString('email'),
                    'password': preferences.getString('password')
                  }))
              .then((response) async {
            setState(() {
              _loading = false;
            });
            var body = jsonDecode(response.body);
            SharedPreferences preference =
                await SharedPreferences.getInstance();

            if (body['detail'] != "email or password incorrect") {
              preference!.setString('_id', body['_id']);
              preference!.setString('name', body['name']);
              preference!.setString('password', body['password']);
              preference!.setInt('childAge', body['childAge']);
              preference!.setString('email', body['email']);
              preference!.setInt('phoneNumber', body['phoneNumber']);
              preference!.setBool('admin', body['admin']);
              preference!.setString('contests', body['contests'].toString());

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Text(
                      'Wrong Email or Password!',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Color(0xFF77B255),
                          fontSize: responsiveTextLogin(20, context),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        color: Color(0xFFFBE43C),
        backgroundColor: Color(0xFFFFD18B),
      ),
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: responsiveHeightLogin(148, context),
                child: Container(
                  height: responsiveHeightLogin(732, context),
                  width: responsiveWidthLogin(390, context),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/background.png'),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: responsiveHeightLogin(80, context),
                child: SizedBox(
                  width: responsiveWidthLogin(390, context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.fitHeight,
                        height: responsiveHeightLogin(150, context),
                      ),
                      SizedBox(
                        height: responsiveHeightLogin(136, context),
                      ),
                      SizedBox(
                        width: responsiveWidthLogin(88, context),
                        height: responsiveHeightLogin(40, context),
                        child: Center(
                          child: AutoSizeText(
                            'Login',
                            maxLines: 1,
                            style: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                color: Color(0xFF903838),
                                fontSize: responsiveTextLogin(32, context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeightLogin(6, context),
                      ),
                      SizedBox(
                        width: responsiveWidthLogin(205, context),
                        height: responsiveHeightLogin(20, context),
                        child: Center(
                          child: AutoSizeText(
                            'Log In & Give Vote to bands',
                            maxLines: 1,
                            style: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: responsiveTextLogin(16, context),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeightLogin(24, context),
                      ),
                      SizedBox(
                        width: responsiveWidthLogin(325, context),
                        height: responsiveHeightLogin(58, context),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: responsiveWidthLogin(36, context),
                              top: responsiveHeightLogin(19, context),
                              bottom: responsiveHeightLogin(19, context),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFCC9D),
                              ),
                              borderRadius: BorderRadius.circular(37),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFCC9D),
                              ),
                              borderRadius: BorderRadius.circular(37),
                            ),
                            filled: true,
                            fillColor: Color(0xFFFEFBDD),
                            hintText: 'Email Address',
                            hintStyle: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                color: Color(0xFF7C5037),
                                fontSize: responsiveTextLogin(16, context),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeightLogin(16, context),
                      ),
                      SizedBox(
                        width: responsiveWidthLogin(325, context),
                        height: responsiveHeightLogin(58, context),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: (responsiveHeightLogin(58, context) -
                                      responsiveTextLogin(16, context)) /
                                  2,
                              horizontal: responsiveWidthLogin(36, context),
                              // bottom: responsiveHeight(19, context),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFCC9D),
                              ),
                              borderRadius: BorderRadius.circular(37),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFCC9D),
                              ),
                              borderRadius: BorderRadius.circular(37),
                            ),
                            filled: true,
                            fillColor: Color(0xFFFEFBDD),
                            hintText: 'Password',
                            hintStyle: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                color: Color(0xFF7C5037),
                                fontSize: responsiveTextLogin(16, context),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeightLogin(162, context),
                      ),
                      SizedBox(
                        width: responsiveWidthLogin(234, context),
                        height: responsiveHeightLogin(20, context),
                        child: Center(
                          child: AutoSizeText.rich(
                            TextSpan(
                              text: 'Don’t have an account? ',
                              style: GoogleFonts.outfit(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: responsiveTextLogin(16, context),
                                ),
                              ),
                              children: [
                                TextSpan(
                                    text: 'Register',
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            responsiveTextLogin(16, context),
                                      ),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterationScreen()))),
                              ],
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeightLogin(20, context),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            _loading = true;
                          });
                          SharedPreferences _preferences =
                              await SharedPreferences.getInstance();
                          final response = await http
                              .post(
                            Uri.parse('https://api.halftiicket.com/login'),
                            headers: {
                              'Content-Type': 'application/json',
                            },
                            body: jsonEncode({
                              'email': _emailController.text,
                              'password': _passwordController.text,
                            }),
                          )
                              .then((response) async {
                            setState(() {
                              _loading = false;
                            });
                            var data = jsonDecode(response.body);
                            if (data !=
                                {"detail": "email or password incorrect"}) {
                              _preferences.setString('email', data['email']);
                              _preferences.setInt(
                                  'phoneNumber', data['phoneNumber']);
                              _preferences.setString(
                                  'password', data['password']);
                              _preferences.setInt('childAge', data['childAge']);
                              _preferences.setString('name', data['name']);
                              _preferences.setBool('admin', data['admin']);
                              _preferences.setString(
                                  'contests', data['contests'].toString());

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return Text('Try again');
                                  }));
                            }
                          });
                        },
                        child: Container(
                          height: responsiveHeightLogin(58, context),
                          width: responsiveWidthLogin(326, context),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(37),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFFB2B2),
                                Color(0xFFFBC63C),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Center(
                              child: SizedBox(
                                height: responsiveHeightLogin(25, context),
                                width: responsiveWidthLogin(76, context),
                                child: Center(
                                  child: AutoSizeText(
                                    'Login',
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            responsiveTextLogin(20, context),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
