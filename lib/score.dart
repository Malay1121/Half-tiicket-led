import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:leaderboard/constant.dart';
import 'package:leaderboard/leaderboard.dart';
import 'package:leaderboard/math_quiz.dart';
import 'dart:convert';

import 'package:leaderboard/responsive.dart';

class ScorePage extends StatefulWidget {
  ScorePage({
    super.key,
    required this.timeElapsed,
    required this.id,
    this.maths = false,
    this.score,
    required this.rank,
  });
  var timeElapsed;
  int? score;
  bool maths;
  String id;
  int rank;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
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
                      width: responsiveWidth(184, context),
                      height: responsiveHeight(38, context),
                      child: Center(
                        child: AutoSizeText(
                          'Results',
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
                                  widget.maths == true
                                      ? '${widget.score} / 3 in ${widget.timeElapsed.toString()}'
                                      : widget.timeElapsed.toString(),
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
                        widget.maths == true
                            ? SizedBox(
                                width: responsiveWidth(137, context),
                                height: responsiveHeight(18, context),
                                child: Center(
                                  child: AutoSizeText(
                                    widget.score! < 3
                                        ? 'Better Luck Next Time'
                                        : '',
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: responsiveText(14, context),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: responsiveHeight(108, context),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LeaderBoard(id: widget.id)));
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
                                    'Go to Leaderboard',
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
                Positioned(
                    top: responsiveHeight(681, context),
                    child: Column(
                      children: [
                        SizedBox(
                          height: responsiveHeight(60, context),
                          width: responsiveWidth(223, context),
                          child: AutoSizeText(
                            'Your Rank',
                            style: TextStyle(
                              color: Color(0xFF903838),
                              fontWeight: FontWeight.w700,
                              fontSize: responsiveText(48, context),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: responsiveWidth(92, context),
                          height: responsiveHeight(50, context),
                          child: Center(
                            child: AutoSizeText(
                              widget.rank.toString(),
                              style: GoogleFonts.outfit(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: responsiveText(40, context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
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
