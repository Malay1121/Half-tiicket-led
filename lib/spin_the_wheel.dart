import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinwheel/flutter_spinwheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard/constant.dart';
import 'package:leaderboard/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SpinTheWheel extends StatefulWidget {
  const SpinTheWheel({super.key});

  @override
  State<SpinTheWheel> createState() => _SpinTheWheelState();
}

StreamController<int> controller = StreamController<int>();
List<String> items = [];

class _SpinTheWheelState extends State<SpinTheWheel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Image.network(
              imageSponsor,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: responsiveWidth(300, context),
                height: responsiveWidth(300, context),
                child: Spinwheel(
                  onChanged: (val) async {
                    SharedPreferences _preferences =
                        await SharedPreferences.getInstance();
                    await http
                        .post(
                          Uri.parse(
                              'https://api.halftiicket.com/addPlayerSpinner'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            "user_id": _preferences.getString('_id').toString(),
                            "user_name":
                                _preferences.getString('name').toString(),
                            "company_name": val.split(' by ')[0],
                            "description": val.split(' by ')[1],
                            "phone_number":
                                _preferences.getString('phoneNumber'),
                          }),
                        )
                        .then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrizeScreen(
                                      prize: val,
                                    ))));
                  },
                  select: Random().nextInt(items.length),
                  autoPlay: false,
                  items: items,
                ),
              ),
            ),
          ),
          Expanded(
            child: Image.network(
              imageSponsor,
              fit: BoxFit.fill,
            ),
          ),
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
          Expanded(
            child: Image.network(
              imageSponsor,
              fit: BoxFit.fill,
            ),
          ),
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
                    await http.post(
                      Uri.parse(
                          'https://api.halftiicket.com/spinnerEmailChecker/${_emailController.text.replaceAll("@", "%40")}'),
                      headers: {
                        'Content-Type': 'application/json',
                      },
                    ).then((value) async {
                      var data = jsonDecode(value.body);
                      print(data);
                      if (value.statusCode == 200) {
                        preferences.setInt('phoneNumber', data['phoneNumber']);
                        preferences.setInt('childAge', data['childAge']);
                        preferences.setString('name', data['name']);
                        preferences.setString('_id', data['_id']);

                        preferences.setString(
                            'contests', data['contests'].toString());
                        setState(() {
                          _emailController = TextEditingController(text: '');
                        });

                        await http.post(
                          Uri.parse(
                              'https://api.halftiicket.com/spinnerOffers'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                        ).then((value1) {
                          setState(() {
                            _loading = false;
                          });

                          var data1 = jsonDecode(value1.body);
                          print(data1);
                          if (value1.statusCode == 200) {
                            for (var item in data1['offers'])
                              setState(() {
                                items = data1['offers']['description'] +
                                    ' by ' +
                                    data1['offers']['company_name'];
                              });

                            Navigator.pushNamed(
                                context, '/spin-the-wheel-play');
                          } else {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return Text('Try again');
                                }));
                          }
                        });
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
          Expanded(
            child: Image.network(
              imageSponsor,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

class PrizeScreen extends StatefulWidget {
  PrizeScreen({super.key, required this.prize});
  String prize;
  @override
  State<PrizeScreen> createState() => _PrizeScreenState();
}

class _PrizeScreenState extends State<PrizeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Image.network(
              imageSponsor,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/typingback.png'),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: responsiveHeight(171, context),
                    ),
                    SizedBox(
                      width: responsiveWidth(303, context),
                      height: responsiveHeight(38, context),
                      child: Center(
                        child: AutoSizeText(
                          widget.prize.toString(),
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: Color(0xFF903838),
                              fontSize: responsiveText(30, context),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: responsiveHeight(171, context),
                  child: Container(
                    width: responsiveWidth(342, context),
                    height: responsiveHeight(217, context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: responsiveWidth(169, context),
                          height: responsiveHeight(41, context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFFC329),
                                Color(0xFFF58B01),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: SizedBox(
                              height: responsiveHeight(31, context),
                              width: responsiveWidth(125, context),
                              child: Center(
                                child: Text(
                                  widget.prize != 'Better Luck Next Time'
                                      ? 'You Won!'
                                      : 'You Lost!',
                                  style: GoogleFonts.outfit(
                                    textStyle: TextStyle(
                                      color: Color(0xFF212121),
                                      fontWeight: FontWeight.w400,
                                      fontSize: responsiveText(14, context),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: responsiveHeight(108, context),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpinWheelRegister()));
                          },
                          child: Container(
                            width: responsiveWidth(156, context),
                            height: responsiveHeight(38, context),
                            decoration: BoxDecoration(
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
                                height: responsiveHeight(18, context),
                                width: responsiveWidth(120, context),
                                child: Center(
                                  child: Text(
                                    'Spin Again!',
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: responsiveText(14, context),
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
          Expanded(
            child: Image.network(
              imageSponsor,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
