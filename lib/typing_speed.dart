import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
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
          'https://api.halftiicket.com/',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((response) {
        setState(() {
          _loading = false;
          _data = json.decode(response.body)[0].toList() == null
              ? ['haha']
              : json.decode(response.body)[0].toList();
          _data = _data[Random().nextInt(_data.length)];
        });
      });
      _data[0].split('').forEach((ch) {
        setState(() {
          word.add({counter: ch});
          counter++;
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
            Expanded(child: Text('Ad')),
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
                      Text(_data[0].toString()),
                      Text(_stopwatch.elapsed.toString()),
                      SizedBox(
                        width: 300,
                        height: 30,
                        child: TextField(
                          onTap: () {
                            _stopwatch.start();
                          },
                          onChanged: ((value) async {
                            SharedPreferences _preferences =
                                await SharedPreferences.getInstance();
                            if (value == _data[0].toString()) {
                              _stopwatch.stop();
                              setState(() {
                                timeTaken = _stopwatch.elapsed.toString();
                              });
                              final response = await http.post(
                                Uri.parse(
                                    'https://api.halftiicket.com/addPlayerContest/${widget.id}'),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'x-api-key':
                                      _preferences.getString('_id').toString(),
                                },
                                body: jsonEncode({
                                  'contest_id': widget.id.toString(),
                                  'time': _stopwatch.elapsed.inSeconds,
                                }),
                              );
                            }
                          }),
                          onSubmitted: (s) async {
                            SharedPreferences _preferences =
                                await SharedPreferences.getInstance();
                            if (s == _data[0].toString()) {
                              _stopwatch.stop();
                              setState(() {
                                timeTaken = _stopwatch.elapsed.toString();
                              });
                              print(_preferences.getString('_id'));
                              final response = await http.post(
                                Uri.parse(
                                    'api.halftiicket.com/addPlayerContest/${widget.id}'),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'x-api-key':
                                      _preferences.getString('_id').toString(),
                                },
                                body: jsonEncode({
                                  'contest_id': widget.id.toString(),
                                  'time': _stopwatch.elapsed.inSeconds,
                                }),
                              );
                            }
                          },
                        ),
                      ),
                      Text('Time taken:- ' +
                          (timeTaken == '0:0:0'
                              ? 'Not Started Yet'
                              : timeTaken)),
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
                          Visibility(
                            visible: click,
                            child: DottedBorder(
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
                                      for (Map character in word)
                                        AutoSizeText(
                                          character.values
                                              .toList()[0]
                                              .toString(),
                                          style: GoogleFonts.outfit(
                                            textStyle: TextStyle(
                                              color: correct[
                                                  character.keys.toList()[0]],
                                              fontSize:
                                                  responsiveText(30, context),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: responsiveWidth(283, context),
                            height: responsiveHeight(51, context),
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Type Here',
                                hintStyle: GoogleFonts.outfit(
                                  textStyle: TextStyle(
                                    color: Color(0xFFFBC63C),
                                    fontSize: responsiveText(30, context),
                                    fontWeight: FontWeight.w500,
                                  ),
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
                                        'api.halftiicket.com/addPlayerContest/${widget.id}'),
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'x-api-key': _preferences
                                          .getString('_id')
                                          .toString(),
                                    },
                                    body: jsonEncode({
                                      'contest_id': widget.id.toString(),
                                      'time': _stopwatch.elapsed.inSeconds,
                                    }),
                                  );
                                }
                                print(correct);
                              },
                              onChanged: (s) async {
                                setState(() {
                                  userWord = [];
                                });
                                _controller.text.split('').forEach((ch) {
                                  setState(() {
                                    userWord
                                        .add({_controller.text.length - 1: ch});
                                  });
                                });
                                // userWord.removeAt(0);
                                print(userWord[userWord.length - 1]);
                                if (word[userWord.length - 1] ==
                                    userWord[userWord.length - 1]) {
                                  setState(() {
                                    correct[userWord.length - 1] =
                                        Color(0xFF903838);
                                  });
                                } else {
                                  setState(() {
                                    correct[userWord.length - 1] = Colors.red;
                                  });
                                }
                                SharedPreferences _preferences =
                                    await SharedPreferences.getInstance();
                                if (s == _data) {
                                  _stopwatch.stop();
                                  setState(() {
                                    timeTaken = _stopwatch.elapsed.toString();
                                  });
                                  await http
                                      .post(
                                        Uri.parse(
                                            'https://api.halftiicket.com/addPlayerContest/${widget.id}'),
                                        headers: {
                                          'Content-Type': 'application/json',
                                        },
                                        body: jsonEncode({
                                          'user_id': _preferences
                                              .getString('_id')
                                              .toString(),
                                          'contest_id': widget.id.toString(),
                                          'time': _stopwatch.elapsed.inSeconds,
                                        }),
                                      )
                                      .then((value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ScorePage(
                                                  timeElapsed:
                                                      _stopwatch.elapsed,
                                                  id: widget.id))));
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
            Expanded(child: Text('Ad')),
          ],
        ),
      ),
    );
  }
}
