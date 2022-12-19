import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/home_page.dart';
import 'package:leaderboard/login.dart';
import 'package:leaderboard/public_voting.dart';
import 'package:leaderboard/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
int _age = 0;
TextEditingController _phoneController = TextEditingController();

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({super.key});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      width: responsiveWidthLogin(193, context),
                      height: responsiveHeightLogin(40, context),
                      child: Center(
                        child: AutoSizeText(
                          'Register Now',
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
                      width: responsiveWidthLogin(222, context),
                      height: responsiveHeightLogin(20, context),
                      child: Center(
                        child: AutoSizeText(
                          'Register & Give Vote to bands',
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
                        controller: _nameController,
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
                          hintText: 'Child\'s Full Name',
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
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: (responsiveHeightLogin(58, context) -
                                    responsiveTextLogin(16, context)) /
                                2,
                            horizontal: responsiveWidthLogin(36, context),
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
                      height: responsiveHeightLogin(16, context),
                    ),
                    SizedBox(
                      width: responsiveWidthLogin(325, context),
                      height: responsiveHeightLogin(58, context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: responsiveWidthLogin(125, context),
                            height: responsiveHeightLogin(58, context),
                            decoration: BoxDecoration(
                              color: Color(0xFFFEFBDD),
                              borderRadius: BorderRadius.circular(37),
                              border: Border.all(
                                color: Color(0xFFFFCC9D),
                                width: 1,
                              ),
                            ),
                            child: SizedBox(
                              width: responsiveWidthLogin(64, context),
                              height: responsiveHeightLogin(34, context),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: responsiveWidthLogin(36, context),
                                  ),
                                  SizedBox(
                                    width: responsiveWidthLogin(29, context),
                                    height: responsiveHeightLogin(20, context),
                                    child: Center(
                                      child: AutoSizeText(
                                        _age <= 0 ? 'Age' : _age.toString(),
                                        style: GoogleFonts.outfit(
                                          textStyle: TextStyle(
                                            color: Color(0xFF7C5037),
                                            fontSize: responsiveTextLogin(
                                                16, context),
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveWidthLogin(19, context),
                                  ),
                                  SizedBox(
                                    height: responsiveHeightLogin(34, context),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: responsiveHeightLogin(
                                              16, context),
                                          width:
                                              responsiveWidthLogin(16, context),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (_age < 105) {
                                                  _age++;
                                                }
                                              });
                                            },
                                            child: Icon(
                                              Icons.expand_less,
                                              color: Color(0xFF7C5037),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: responsiveHeightLogin(
                                              16, context),
                                          width:
                                              responsiveWidthLogin(16, context),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (_age > 0) {
                                                  _age--;
                                                }
                                              });
                                            },
                                            child: Icon(
                                              Icons.expand_more,
                                              color: Color(0xFF7C5037),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: responsiveWidthLogin(184, context),
                            height: responsiveHeightLogin(58, context),
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefix: Padding(
                                  padding: EdgeInsets.only(
                                      left: responsiveWidthLogin(10, context)),
                                  child: SizedBox(
                                    width: responsiveWidthLogin(23, context),
                                    height: responsiveHeightLogin(20, context),
                                    child: AutoSizeText(
                                      '+91',
                                      style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                          color: Color(0xFF7C5037),
                                          fontSize:
                                              responsiveTextLogin(16, context),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: (responsiveHeightLogin(
                                              58, context) -
                                          responsiveTextLogin(16, context)) /
                                      2,
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
                                hintText: 'Phone',
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeightLogin(17, context),
                    ),
                    SizedBox(
                      width: responsiveWidthLogin(231, context),
                      height: responsiveHeightLogin(20, context),
                      child: Center(
                        child: AutoSizeText.rich(
                          TextSpan(
                            text: 'Already have an account? ',
                            style: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: responsiveTextLogin(16, context),
                              ),
                            ),
                            children: [
                              TextSpan(
                                  text: 'Login',
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
                                                LoginScreen()))),
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
                        SharedPreferences _preferences =
                            await SharedPreferences.getInstance();
                        await http
                            .post(
                          Uri.parse('https://api.halftiicket.com/addUser'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            'name': _nameController.text,
                            'email': _emailController.text,
                            'childAge': _age,
                            'phoneNumber': int.parse(_phoneController.text),
                            'password': _passwordController.text,
                            "contests": {}
                          }),
                        )
                            .then((value) {
                          var data = jsonDecode(value.body);
                          print(data);
                          if (data != {"message": "minimum child age is 3"} ||
                              data !=
                                  {
                                    "detail": [
                                      {
                                        "loc": ["body", "email"],
                                        "msg":
                                            "value is not a valid email address",
                                        "type": "value_error.email"
                                      }
                                    ]
                                  } ||
                              data !=
                                  "{detail: [{loc: [body], msg: value is not a valid dict, type: type_error.dict}]}") {
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
                          child: SizedBox(
                            height: responsiveHeightLogin(25, context),
                            width: responsiveWidthLogin(76, context),
                            child: Center(
                              child: AutoSizeText(
                                'Register',
                                style: GoogleFonts.outfit(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsiveTextLogin(20, context),
                                    fontWeight: FontWeight.w600,
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
