import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard/responsive.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

dynamic _votes;
bool _loading = true;

class _VotingScreenState extends State<VotingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await http.get(
        Uri.parse(
          'https://6hp1qs.deta.dev/getVotes',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((voteResponse) {
        setState(() {
          _loading = false;
          _votes = jsonDecode(voteResponse.body) as Map;
        });
      });

      var channel = WebSocketChannel.connect(
        Uri.parse('wss://6hp1qs.deta.dev/ws/votes'),
      );
      channel.stream.listen((event) {
        String data = event.toString();

        setState(() {
          _votes = jsonDecode(data) == null
              ? {
                  'name': 'Atharva',
                  'price': 10,
                  'image': 'http://172.105.41.217:8000/get-image/atharva_dalal',
                  'bid_by': null,
                }
              : jsonDecode(data);
        });
      });
      //   print(_votes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        color: Color(0xFFFBE43C),
        backgroundColor: Color(0xFFFFD18B),
      ),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: responsiveHeight(69, context),
                      ),
                      SizedBox(
                        width: responsiveWidth(139, context),
                        height: responsiveHeight(40, context),
                        child: Center(
                          child: AutoSizeText(
                            'Vote Now',
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
                        width: responsiveWidth(159, context),
                        height: responsiveHeight(20, context),
                        child: Center(
                          child: AutoSizeText(
                            'Thanks for your vote!',
                            style: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize: responsiveText(16, context),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(39, context),
                      ),
                      for (var band in _votes['votes'])
                        Stack(
                          children: [
                            Container(
                              width: responsiveWidth(342, context),
                              height: responsiveHeight(60, context),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(37),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    offset: Offset(0, 4),
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: responsiveWidth(342, context) *
                                  (band['votes'] / 100),
                              height: responsiveHeight(60, context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(37),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFF9FC00),
                                    Color(0xFFF7D700),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    offset: Offset(0, 4),
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: responsiveWidth(342, context),
                              height: responsiveHeight(60, context),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: responsiveHeight(60, context),
                                    width: responsiveHeight(60, context),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFFFCC9D), width: 1),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveWidth(15, context),
                                  ),
                                  SizedBox(
                                    width: responsiveWidth(136, context),
                                    child: AutoSizeText(
                                      band['name'],
                                      style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: responsiveText(16, context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    child: AutoSizeText(
                                      '10,800 votes',
                                      style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: responsiveText(14, context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveWidth(20, context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
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
