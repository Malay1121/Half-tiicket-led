import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SpinTheWheel extends StatefulWidget {
  const SpinTheWheel({super.key});

  @override
  State<SpinTheWheel> createState() => _SpinTheWheelState();
}

StreamController<int> controller = StreamController<int>();
List items = [
  'Coupon Code 1',
  'Deal 1',
  'Discount 1',
  'Freebies',
  'Gift Card 1'
];

class _SpinTheWheelState extends State<SpinTheWheel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Text('ad')),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: responsiveWidth(300, context),
                height: responsiveWidth(300, context),
                child: FortuneWheel(
                  selected: controller.stream,
                  duration: Duration(seconds: 10),
                  items: [
                    for (var item in items) FortuneItem(child: Text(item)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Text('ad')),
        ],
      ),
    );
  }
}

class SpinWheelRegister extends StatefulWidget {
  const SpinWheelRegister({super.key});

  @override
  State<SpinWheelRegister> createState() => _SpinWheelRegisterState();
}

class _SpinWheelRegisterState extends State<SpinWheelRegister> {
  @override
  Widget build(BuildContext context) {
    bool _loading = false;
    TextEditingController _emailController = TextEditingController(text: '');
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Text('ad')),
          SizedBox(
            width: responsiveWidth(390, context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: responsiveWidth(193, context),
                  height: responsiveHeight(40, context),
                  child: Center(
                    child: AutoSizeText(
                      'Enter Details',
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
                  height: responsiveHeight(6, context),
                ),
                SizedBox(
                  width: responsiveWidth(222, context),
                  height: responsiveHeight(20, context),
                  child: Center(
                    child: AutoSizeText(
                      'Register to play',
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
                  height: responsiveHeight(24, context),
                ),
                SizedBox(
                  width: responsiveWidth(325, context),
                  height: responsiveHeight(58, context),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
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
                      hintText: 'Enter Email Id',
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
                  height: responsiveHeight(16, context),
                ),
                SizedBox(
                  height: responsiveHeight(20, context),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _loading = true;
                    });
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await http
                        .post(
                      Uri.parse('https://api.halftiicket.com/addTempUser'),
                      headers: {
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode({
                        'email': _emailController.text,
                      }),
                    )
                        .then((value) {
                      setState(() {
                        _loading = false;
                      });

                      var data = jsonDecode(value.body);
                      print(data);
                      if (data != {"message": "minimum child age is 3"} ||
                          data !=
                              {
                                "detail": [
                                  {
                                    "loc": ["body", "email"],
                                    "msg": "value is not a valid email address",
                                    "type": "value_error.email"
                                  }
                                ]
                              } ||
                          data !=
                              "{detail: [{loc: [body], msg: value is not a valid dict, type: type_error.dict}]}") {
                        preferences.setInt('phoneNumber', data['phoneNumber']);
                        preferences.setInt('childAge', data['childAge']);
                        preferences.setString('name', data['name']);
                        preferences.setString('_id', data['_id']);

                        preferences.setString(
                            'contests', data['contests'].toString());
                        setState(() {
                          _emailController = TextEditingController(text: '');
                        });
                        setState(() {
                          controller.add(
                            Fortune.randomInt(0, items.length),
                          );
                        });
                        Navigator.pushNamed(context, '/spin-the-wheel-play');
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
                      child: SizedBox(
                        height: responsiveHeight(25, context),
                        width: responsiveWidth(76, context),
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
          Expanded(child: Text('ad')),
        ],
      ),
    );
  }
}
