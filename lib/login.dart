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
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: responsiveHeight(148, context),
              child: Container(
                height: responsiveHeight(732, context),
                width: responsiveWidth(390, context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/background.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: responsiveHeight(80, context),
              child: SizedBox(
                width: responsiveWidth(390, context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.fitHeight,
                      height: responsiveHeight(150, context),
                    ),
                    SizedBox(
                      height: responsiveHeight(136, context),
                    ),
                    SizedBox(
                      width: responsiveWidth(88, context),
                      height: responsiveHeight(40, context),
                      child: Center(
                        child: AutoSizeText(
                          'Login',
                          maxLines: 1,
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: Color(0xFF903838),
                              fontSize: responsiveText(32, context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(6, context),
                    ),
                    SizedBox(
                      width: responsiveWidth(205, context),
                      height: responsiveHeight(20, context),
                      child: Center(
                        child: AutoSizeText(
                          'Log In & Give Vote to bands',
                          maxLines: 1,
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: responsiveText(16, context),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(24, context),
                    ),
                    SizedBox(
                      width: responsiveWidth(325, context),
                      height: responsiveHeight(58, context),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: responsiveWidth(36, context),
                            top: responsiveHeight(19, context),
                            bottom: responsiveHeight(19, context),
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
                              fontSize: responsiveText(16, context),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(16, context),
                    ),
                    SizedBox(
                      width: responsiveWidth(325, context),
                      height: responsiveHeight(58, context),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: (responsiveHeight(58, context) -
                                    responsiveText(16, context)) /
                                2,
                            horizontal: responsiveWidth(36, context),
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
                              fontSize: responsiveText(16, context),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(162, context),
                    ),
                    SizedBox(
                      width: responsiveWidth(234, context),
                      height: responsiveHeight(20, context),
                      child: Center(
                        child: AutoSizeText.rich(
                          TextSpan(
                            text: 'Don’t have an account? ',
                            style: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: responsiveText(16, context),
                              ),
                            ),
                            children: [
                              TextSpan(
                                  text: 'Register',
                                  style: GoogleFonts.outfit(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: responsiveText(16, context),
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
                      height: responsiveHeight(20, context),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences _preferences =
                            await SharedPreferences.getInstance();
                        final response = await http.post(
                          Uri.parse('https://api.halftiicket.com/login'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            'email': _emailController.text,
                            'password': _passwordController.text,
                          }),
                        );
                        var data = jsonDecode(response.body);
                        if (data != {"detail": "email or password incorrect"}) {
                          _preferences.setString('email', data['email']);
                          _preferences.setInt(
                              'phoneNumber', data['phoneNumber']);
                          _preferences.setString('password', data['password']);
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
                      },
                      child: Container(
                        height: responsiveHeight(58, context),
                        width: responsiveWidth(326, context),
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
                              height: responsiveHeight(25, context),
                              width: responsiveWidth(76, context),
                              child: Center(
                                child: AutoSizeText(
                                  'Login',
                                  style: GoogleFonts.outfit(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveText(20, context),
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
    );
  }
}
