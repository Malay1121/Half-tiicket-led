import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/responsive.dart';
import 'package:leaderboard/slide_puzzle.dart';
import 'package:leaderboard/typing_speed.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key, required this.id});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
  final String id;
}

dynamic _data = {
  "leaderboard": [
    {
      "name": "string",
      "contests": {
        "639cda5575f95e42b54ff971": {"time": 1}
      }
    },
    {
      "name": "uvesh",
      "contests": {
        "639cda5575f95e42b54ff971": {"time": 6}
      }
    },
    {
      "name": "uvesh4",
      "contests": {
        "639cda5575f95e42b54ff971": {"time": 7}
      }
    },
    {
      "name": "uvesh3",
      "contests": {
        "639cda5575f95e42b54ff971": {"time": 10.6}
      }
    },
    {
      "name": "uvesh1",
      "contests": {
        "639cda5575f95e42b54ff971": {"time": 13}
      }
    },
    {
      "name": "uvesh2",
      "contests": {
        "639cda5575f95e42b54ff971": {"time": 13.6}
      }
    }
  ]
};
bool _loading = true;
var channel;

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var response = await http.get(
        Uri.parse(
          'https://api.halftiicket.com/contestLeaderboard/${widget.id}',
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
      channel = WebSocketChannel.connect(
        Uri.parse('wss://api.halftiicket.com/ws/${widget.id}'),
      );
      channel.stream.listen((event) {
        String data = event.toString();

        setState(() {
          _data = jsonDecode(data) == null
              ? {
                  'name': 'Atharva',
                  'price': 10,
                  'image': 'http://172.105.41.217:8000/get-image/atharva_dalal',
                  'bid_by': null,
                }
              : jsonDecode(data);
        });
      });
      // channel.sink.add('data');
    });
  }

// Navigator.pushNamed(context, '/${widget.id}')
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        color: Color(0xFFFBE43C),
        backgroundColor: Color(0xFFFFD18B),
      ),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                  height: responsiveHeight(64, context),
                ),
                SizedBox(
                  width: responsiveWidth(181, context),
                  height: responsiveHeight(38, context),
                  child: Center(
                    child: AutoSizeText(
                      'Leaderboard',
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
                SizedBox(
                  height: responsiveHeight(30, context),
                ),
                Container(
                  width: responsiveWidth(228, context),
                  height: responsiveHeight(213, context),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/yourposi.png'),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: responsiveWidth(81, context),
                        height: responsiveHeight(18, context),
                        child: Center(
                          child: AutoSizeText(
                            'Your Position',
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
                      SizedBox(
                        width: responsiveWidth(56, context),
                        height: responsiveHeight(49, context),
                        child: Center(
                          child: AutoSizeText(
                            '99',
                            style: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: responsiveText(45, context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: responsiveHeight(30, context),
                ),
                Container(
                  height: responsiveHeight(400, context),
                  width: responsiveWidth(357, context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: responsiveHeight(29, context),
                          ),
                          for (var user in _data['leaderboard'])
                            Container(
                              width: responsiveWidth(284, context),
                              height: responsiveHeight(70, context),
                              decoration: BoxDecoration(
                                color:
                                    _data['leaderboard'].indexOf(user) + 1 == 1
                                        ? Color(0xFFFFEBC666).withOpacity(0.4)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: responsiveWidth(23, context),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: responsiveHeight(20, context),
                                        child: AutoSizeText(
                                          user['name'].toString(),
                                          style: GoogleFonts.outfit(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  responsiveText(16, context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: responsiveHeight(20, context),
                                        child: AutoSizeText(
                                          user['contests'][widget.id]['time']
                                                  .toString() +
                                              ' Seconds',
                                          style: GoogleFonts.outfit(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize:
                                                  responsiveText(14, context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    height: responsiveHeight(20, context),
                                    width: responsiveWidth(25, context),
                                    child: AutoSizeText(
                                      (_data['leaderboard'].indexOf(user) + 1)
                                          .toString(),
                                      style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: responsiveText(16, context),
                                          color: Color(0xFFF58B01),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container();
                        });
                    Navigator.pushNamed(context, '/${widget.id}');
                  }),
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
                          width: responsiveWidthLogin(100, context),
                          child: Center(
                            child: AutoSizeText(
                              'Participate',
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
                ),
                SizedBox(
                  height: responsiveHeight(30, context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
