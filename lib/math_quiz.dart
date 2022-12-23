import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard/responsive.dart';
import 'package:leaderboard/score.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MathQuiz extends StatefulWidget {
  MathQuiz({super.key});

  @override
  State<MathQuiz> createState() => _MathQuizState();
}

var num1;
var num2;

int part = 0;
int score = 0;

List answers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
var _stopwatch = Stopwatch();

class _MathQuizState extends State<MathQuiz> {
  @override
  void initState() {
    // TODO: implement initState
    _generateQuiz();
    _stopwatch.start();
    setState(() {
      part = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Expanded(child: Text('Ad')),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: responsiveHeight(201, context),
                          ),
                          Container(
                            width: responsiveWidth(162, context),
                            height: responsiveHeight(12, context),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFF0AE),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: responsiveWidth(
                                      double.parse((54 * part).toString()),
                                      context),
                                  height: responsiveHeight(12, context),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8A815),
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: responsiveHeight(45, context),
                          ),
                          SizedBox(
                            width: responsiveWidth(244, context),
                            height: responsiveHeight(57, context),
                            child: Center(
                              child: AutoSizeText(
                                '$num1 + $num2 = ..',
                                style: GoogleFonts.outfit(
                                  fontSize: responsiveText(45, context),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: responsiveHeight(45, context),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: responsiveWidth(24, context),
                              right: responsiveWidth(24, context),
                            ),
                            child: GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing:
                                          responsiveWidth(36, context),
                                      mainAxisSpacing:
                                          responsiveHeight(40, context)),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                for (var answer in answers)
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences _preferences =
                                          await SharedPreferences.getInstance();
                                      setState(() {
                                        if (answer == num1 + num2) {
                                          score++;
                                        }
                                        part++;
                                      });
                                      if (part != 3) {
                                        _generateQuiz();
                                      } else {
                                        _stopwatch.stop();
                                        if (part == 3) {
                                          await http
                                              .post(
                                            Uri.parse(
                                                'https://api.halftiicket.com/addPlayerContest'),
                                            headers: {
                                              'Content-Type':
                                                  'application/json',
                                            },
                                            body: jsonEncode({
                                              'user_id': _preferences
                                                  .getString('_id')
                                                  .toString(),
                                              'contest_id':
                                                  '639fe06f6deeaf05475f1775',
                                              'time':
                                                  _stopwatch.elapsed.inSeconds,
                                            }),
                                          )
                                              .then((value) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ScorePage(
                                                          timeElapsed:
                                                              _stopwatch
                                                                  .elapsed,
                                                          id: '639fe06f6deeaf05475f1775',
                                                          maths: true,
                                                          score: score,
                                                          rank: int.parse(
                                                            jsonDecode(value
                                                                        .body)[
                                                                    'rank']
                                                                .toString(),
                                                          ),
                                                        )));
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: responsiveWidth(90, context),
                                      height: responsiveHeight(90, context),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFD07B),
                                            Color(0xFFF7A001)
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: responsiveWidth(44, context),
                                          height: responsiveHeight(48, context),
                                          child: Center(
                                            child: AutoSizeText(
                                              answer.toString(),
                                              maxLines: 1,
                                              style: GoogleFonts.outfit(
                                                textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: responsiveText(
                                                      38, context),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Text('Ad')),
          ],
        ),
      ),
    );
  }

  void _generateQuiz() {
    setState(() {
      num1 = Random().nextInt(500);
      num2 = Random().nextInt(500);

      answers = [
        num1 + num2,
        Random().nextInt(500),
        Random().nextInt(500),
        Random().nextInt(500),
        Random().nextInt(500),
        Random().nextInt(500),
        Random().nextInt(500),
        Random().nextInt(500),
        Random().nextInt(500),
      ];
      answers.shuffle();
    });
  }
}
