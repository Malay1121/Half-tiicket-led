import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/responsive.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

var _selectedBand = '';

class PublicVoting extends StatefulWidget {
  const PublicVoting({super.key});

  @override
  State<PublicVoting> createState() => _PublicVotingState();
}

dynamic _data;
dynamic _votes = {
  "votes": [
    {"name": "demo1", "votes": 6.658291457286432},
    {"name": "demo2", "votes": 42.902010050251256},
    {"name": "demo3", "votes": 21.796482412060303},
    {"name": "demo4", "votes": 28.64321608040201}
  ]
};
bool _loading = true;

class _PublicVotingState extends State<PublicVoting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await http.get(
        Uri.parse(
          'https://api.halftiicket.com/getBands',
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
    return ModalProgressHUD(
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        color: Color(0xFFFBE43C),
        backgroundColor: Color(0xFFFFD18B),
      ),
      child: SafeArea(
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
                          width: responsiveWidth(250, context),
                          height: responsiveHeight(20, context),
                          child: Center(
                            child: AutoSizeText(
                              'Select to Vote your Favorite Band',
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
                        GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing:
                                      responsiveWidth(16, context)),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            for (var band in _data['bands'])
                              Padding(
                                padding: EdgeInsets.only(
                                    left: _data['bands']
                                            .toList()
                                            .indexOf(band)
                                            .isEven
                                        ? responsiveWidth(25, context)
                                        : 0,
                                    right: _data['bands']
                                            .toList()
                                            .indexOf(band)
                                            .isOdd
                                        ? responsiveWidth(25, context)
                                        : 0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBand = band['_id'];
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: responsiveWidth(162, context),
                                        height: responsiveHeight(222, context),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFFFF9BE),
                                            borderRadius:
                                                BorderRadius.circular(48),
                                            border: Border.all(
                                                color: Color(0xFFFBC53C),
                                                width: 9,
                                                strokeAlign:
                                                    StrokeAlign.inside),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                band['logo'],
                                              ),
                                            )),
                                      ),
                                      Container(
                                        width: responsiveWidth(162, context),
                                        height: responsiveHeight(222, context),
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Container(
                                              width:
                                                  responsiveWidth(162, context),
                                              height: responsiveHeight(
                                                  138, context),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(48),
                                                  bottomRight:
                                                      Radius.circular(48),
                                                ),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/vote.png',
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: responsiveHeight(
                                                            50, context)),
                                                    child: SizedBox(
                                                      child: AutoSizeText(
                                                        band['name'].toString(),
                                                        maxLines: 2,
                                                        style:
                                                            GoogleFonts.outfit(
                                                          textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                responsiveText(
                                                                    16,
                                                                    context),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  _selectedBand == band['_id']
                                                      ? Padding(
                                                          padding: EdgeInsets.only(
                                                              bottom:
                                                                  responsiveHeight(
                                                                      15,
                                                                      context)),
                                                          child: SizedBox(
                                                            height:
                                                                responsiveHeight(
                                                                    20,
                                                                    context),
                                                            width:
                                                                responsiveWidth(
                                                                    20,
                                                                    context),
                                                            child: Icon(
                                                              Icons
                                                                  .check_circle,
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(),
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _selectedBand != ''
                  ? GestureDetector(
                      onTap: () async {
                        setState(() {
                          _loading = true;
                        });
                        final response = await http
                            .post(
                          Uri.parse(
                              'https://api.halftiicket.com/addVotes/$_selectedBand'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({'id': _selectedBand}),
                        )
                            .then((value) {
                          setState(() {
                            _loading = false;
                          });
                        });
                        Navigator.pushNamed(context, '/votes');
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
                          child: Center(
                            child: SizedBox(
                              height: responsiveHeight(30, context),
                              width: responsiveWidth(130, context),
                              child: Center(
                                child: AutoSizeText(
                                  'Submit Vote!',
                                  style: GoogleFonts.outfit(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveText(20, context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: responsiveHeight(15, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
