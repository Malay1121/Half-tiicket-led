import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard/responsive.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

dynamic _data = {};
bool _loading = true;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await http.get(
        Uri.parse(
          'https://api.halftiicket.com/getContests',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((response) {
        setState(() {
          _loading = false;
          _data = jsonDecode(response.body) as Map;
        });
      });

      print(_data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  top: responsiveHeight(48, context),
                  left: responsiveWidth(26, context),
                  right: responsiveWidth(26, context),
                ),
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: responsiveHeight(45, context),
                            width: responsiveWidth(157, context),
                            child: AutoSizeText.rich(
                              TextSpan(
                                text: 'Hi,',
                                style: GoogleFonts.outfit(
                                  textStyle: TextStyle(
                                    fontSize: responsiveText(36, context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Daniel',
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        fontSize: responsiveText(36, context),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            height: responsiveHeight(20, context),
                            width: responsiveWidth(136, context),
                            child: AutoSizeText(
                              'Have a Great Day !',
                              maxLines: 1,
                              style: TextStyle(
                                color: Color(0xFF131313),
                                fontWeight: FontWeight.w300,
                                fontSize: responsiveText(16, context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: responsiveWidth(52, context),
                        height: responsiveHeight(52, context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/dp.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: responsiveWidth(30, context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsiveHeight(55, context),
                  ),
                  SizedBox(
                    width: responsiveWidth(191, context),
                    height: responsiveHeight(30, context),
                    child: AutoSizeText(
                      'Choose Category',
                      style: GoogleFonts.outfit(
                        textStyle: TextStyle(
                          color: Color(0xFF131313),
                          fontWeight: FontWeight.w700,
                          fontSize: responsiveText(24, context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: responsiveHeight(20, context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/offers');
                        },
                        child: Container(
                          width: responsiveWidth(160, context),
                          height: responsiveHeight(202, context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFEC130),
                                Color(0xFFF58D03),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/homecard.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: responsiveHeight(29, context),
                              ),
                              Container(
                                width: responsiveWidth(58, context),
                                height: responsiveHeight(58, context),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/offer.png',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(14, context),
                              ),
                              SizedBox(
                                height: responsiveHeight(25, context),
                                width: responsiveWidth(60, context),
                                child: Center(
                                  child: AutoSizeText(
                                    'Offers',
                                    maxLines: 1,
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: responsiveText(20, context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(7, context),
                              ),
                              SizedBox(
                                width: responsiveWidth(100, context),
                                height: responsiveHeight(40, context),
                                child: Center(
                                  child: AutoSizeText(
                                    'Select to view exciting offers',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: responsiveText(16, context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/voting');
                        },
                        child: Container(
                          width: responsiveWidth(160, context),
                          height: responsiveHeight(202, context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF00D1BA),
                                Color(0xFF00839E),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/homecard.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: responsiveHeight(29, context),
                              ),
                              Container(
                                width: responsiveWidth(58, context),
                                height: responsiveHeight(58, context),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/votecard.png',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(14, context),
                              ),
                              SizedBox(
                                height: responsiveHeight(25, context),
                                width: responsiveWidth(112, context),
                                child: Center(
                                  child: AutoSizeText(
                                    'Band Voting',
                                    maxLines: 1,
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: responsiveText(20, context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(7, context),
                              ),
                              SizedBox(
                                width: responsiveWidth(100, context),
                                height: responsiveHeight(40, context),
                                child: Center(
                                  child: AutoSizeText(
                                    'Select to Vote your favorite Bands',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: responsiveText(16, context),
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
                  SizedBox(
                    height: responsiveHeight(23, context),
                  ),
                  Container(
                    width: responsiveWidth(160, context),
                    height: responsiveHeight(202, context),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFB77EFE),
                          Color(0xFF8202E7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/bighome.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: responsiveWidth(27, context),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/spin-the-wheel');
                          },
                          child: Container(
                            width: responsiveWidth(66, context),
                            height: responsiveHeight(66, context),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/spinwheel.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: responsiveWidth(14, context),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: responsiveHeight(25, context),
                              width: responsiveWidth(142, context),
                              child: AutoSizeText(
                                'Spin The Wheel',
                                maxLines: 1,
                                style: GoogleFonts.outfit(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: responsiveText(20, context),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: responsiveHeight(7, context),
                            ),
                            SizedBox(
                              width: responsiveWidth(206, context),
                              height: responsiveHeight(20, context),
                              child: AutoSizeText(
                                'Spin the wheel and win prizes',
                                maxLines: 2,
                                style: GoogleFonts.outfit(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: responsiveText(16, context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: responsiveHeight(30, context),
                  ),
                  SizedBox(
                    height: responsiveHeight(30, context),
                    width: responsiveWidth(179, context),
                    child: AutoSizeText(
                      'Contest',
                      style: GoogleFonts.outfit(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: responsiveText(24, context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: responsiveHeight(20, context),
                  ),
                  for (var contest in _data['contests'])
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: responsiveHeight(20, context)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/${contest['_id']}');
                        },
                        child: Container(
                          width: responsiveWidth(343, context),
                          height: responsiveHeight(104, context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFEC130),
                                Color(0xFFF58D03),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: responsiveWidth(25, context),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: responsiveWidth(123, context),
                                    height: responsiveHeight(25, context),
                                    child: AutoSizeText(
                                      contest['name'].toString(),
                                      style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: responsiveText(20, context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveWidth(200, context),
                                    height: responsiveHeight(18, context),
                                    child: AutoSizeText(
                                      'Little description',
                                      style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: responsiveText(14, context),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              SizedBox(
                                width: responsiveWidth(40, context),
                                height: responsiveHeight(40, context),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
