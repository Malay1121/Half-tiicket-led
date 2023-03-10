import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/constant.dart';
import 'package:leaderboard/responsive.dart';
import 'package:leaderboard/score.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _stopwatch = Stopwatch();
String timeTaken = '0:0:0';
dynamic _data = ['Loading'];

class TypingSpeed extends StatefulWidget {
  const TypingSpeed({super.key, required this.id});
  final String id;
  @override
  State<TypingSpeed> createState() => _TypingSpeedState();
}

var _loading = true;
List word = [];
List userWord = [];
TextEditingController _controller = TextEditingController();
String text = '';
int counter = 0;
List correct = [
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C),
  Color(0xFFFBC63C)
];

class _TypingSpeedState extends State<TypingSpeed> {
  @override
  void initState() {
    _stopwatch.reset();
    setState(() {
      counter = 0;
      word = [];
      List correct = [
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C),
        Color(0xFFFBC63C)
      ];
      userWord = [];
      text = '';
      _controller = TextEditingController(text: '');
    });
    // TODO: implement initState
    // Timer.periodic(Duration(seconds: 1), (s) {
    //   setState(() {});
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await http.get(
        Uri.parse(
          'https://6hp1qs.deta.dev/words',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((response) {
        setState(() {
          _loading = false;
          _data = json.decode(response.body);
        });
      });

      // word.removeAt(0);
      print(word);
    });
  }

  var click = true;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        color: Color(0xFFFBE43C),
        backgroundColor: Color(0xFFFFD18B),
      ),
      child: Scaffold(
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
                        height: responsiveHeight(45, context),
                      ),
                      SizedBox(
                        width: responsiveWidth(57, context),
                        height: responsiveHeight(18, context),
                        child: Center(
                          child: AutoSizeText(
                            'Test your',
                            style: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: responsiveText(14, context),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(5, context),
                      ),
                      SizedBox(
                        width: responsiveWidth(184, context),
                        height: responsiveHeight(38, context),
                        child: Center(
                          child: AutoSizeText(
                            'Typing Speed',
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
                      // Text(_data[0].toString()),
                      // Text(_stopwatch.elapsed.toString()),
                      // SizedBox(
                      //   width: 300,
                      //   height: 30,
                      //   child: TextField(
                      //     onTap: () {
                      //       _stopwatch.start();
                      //     },
                      //     onChanged: ((value) async {
                      //       SharedPreferences _preferences =
                      //           await SharedPreferences.getInstance();
                      //       if (value == _data[0].toString()) {
                      //         _stopwatch.stop();
                      //         setState(() {
                      //           timeTaken = _stopwatch.elapsed.toString();
                      //         });
                      //         final response = await http.post(
                      //           Uri.parse(
                      //               'https://6hp1qs.deta.dev/addPlayerContest/${widget.id}'),
                      //           headers: {
                      //             'Content-Type': 'application/json',
                      //             'x-api-key':
                      //                 _preferences.getString('_id').toString(),
                      //           },
                      //           body: jsonEncode({
                      //             'contest_id': widget.id.toString(),
                      //             'time': _stopwatch.elapsed.inSeconds,
                      //           }),
                      //         );
                      //       }
                      //     }),
                      //     onSubmitted: (s) async {
                      //       SharedPreferences _preferences =
                      //           await SharedPreferences.getInstance();
                      //       if (s == _data[0].toString()) {
                      //         _stopwatch.stop();
                      //         setState(() {
                      //           timeTaken = _stopwatch.elapsed.toString();
                      //         });
                      //         print(_preferences.getString('_id'));
                      //         final response = await http.post(
                      //           Uri.parse(
                      //               '6hp1qs.deta.dev/addPlayerContest/${widget.id}'),
                      //           headers: {
                      //             'Content-Type': 'application/json',
                      //             'x-api-key':
                      //                 _preferences.getString('_id').toString(),
                      //           },
                      //           body: jsonEncode({
                      //             'contest_id': widget.id.toString(),
                      //             'time': _stopwatch.elapsed.inSeconds,
                      //           }),
                      //         );
                      //       }
                      //     },
                      //   ),
                      // ),
                      // Text('Time taken:- ' +
                      //     (timeTaken == '0:0:0'
                      //         ? 'Not Started Yet'
                      //         : timeTaken)),
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
                          SizedBox(
                            height: responsiveHeight(51, context),
                          ),
                          DottedBorder(
                            radius: Radius.circular(7),
                            borderType: BorderType.RRect,
                            strokeWidth: 1,
                            dashPattern: [4, 4],
                            color: Color(0xFFFFC127),
                            child: Container(
                              width: responsiveWidth(283, context),
                              height: responsiveHeight(68, context),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      _data['word'],
                                      style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                          color: Color(0xFFFBC63C),
                                          fontSize: responsiveText(30, context),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: responsiveWidth(283, context),
                            height: responsiveHeight(51, context),
                            child: TextField(
                              controller: _controller,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Type Here',
                                hintStyle: GoogleFonts.outfit(
                                  textStyle: TextStyle(
                                    color: Color(0xFFFBC63C),
                                    fontSize: responsiveText(15, context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              style: GoogleFonts.outfit(
                                textStyle: TextStyle(
                                  color: Color(0xFFFBC63C),
                                  fontSize: responsiveText(30, context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onSubmitted: (s) async {
                                SharedPreferences _preferences =
                                    await SharedPreferences.getInstance();
                                if (s == _data) {
                                  _stopwatch.stop();
                                  setState(() {
                                    timeTaken = _stopwatch.elapsed.toString();
                                  });
                                  print(_preferences.getString('_id'));
                                  final response = await http.post(
                                    Uri.parse(
                                        '6hp1qs.deta.dev/addPlayerContest/${widget.id}'),
                                    headers: {
                                      'Content-Type': 'application/json',
                                    },
                                    body: jsonEncode({
                                      'user_id': _preferences
                                          .getString('_id')
                                          .toString(),
                                      'contest_id': '639cdb1675f95e42b54ff972',
                                      'time': _stopwatch.elapsed.inSeconds,
                                    }),
                                  );
                                }
                                print(correct);
                              },
                              onTap: () {
                                _stopwatch.start();
                              },
                              onChanged: (s) async {
                                SharedPreferences _preferences =
                                    await SharedPreferences.getInstance();
                                if (s == _data['word']) {
                                  print(
                                    _preferences.getString('_id').toString(),
                                  );
                                  _stopwatch.stop();
                                  setState(() {
                                    timeTaken = _stopwatch.elapsed.toString();
                                  });
                                  await http
                                      .post(
                                        Uri.parse(
                                            'https://6hp1qs.deta.dev/addPlayerContest'),
                                        headers: {
                                          'Content-Type': 'application/json',
                                        },
                                        body: jsonEncode({
                                          'user_id': _preferences
                                              .getString('_id')
                                              .toString(),
                                          'contest_id':
                                              '639cdb1675f95e42b54ff972',
                                          'time': _stopwatch.elapsed.inSeconds,
                                        }),
                                      )
                                      .then(
                                        (value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ScorePage(
                                              timeElapsed: _stopwatch.elapsed,
                                              id: '639cdb1675f95e42b54ff972',
                                              rank: int.parse(
                                                jsonDecode(value.body)['rank']
                                                    .toString(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                }
                                print(correct);
                              },
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
      ),
    );
  }
}
