import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/constant.dart';
import 'package:leaderboard/responsive.dart';
import 'package:leaderboard/slide_puzzle.dart';
import 'package:leaderboard/typing_speed.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
TextEditingController _nameController = TextEditingController();
TextEditingController _phoneController = TextEditingController();
TextEditingController _age = TextEditingController();

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
          imageSponsor = _data['contest']['img'];
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
                      // SizedBox(
                      //   height: responsiveHeight(30, context),
                      // ),
                      // Container(
                      //   width: responsiveWidth(228, context),
                      //   height: responsiveHeight(213, context),
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/yourposi.png'),
                      //     ),
                      //   ),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       SizedBox(
                      //         width: responsiveWidth(81, context),
                      //         height: responsiveHeight(18, context),
                      //         child: Center(
                      //           child: AutoSizeText(
                      //             'Your Position',
                      //             style: GoogleFonts.outfit(
                      //               textStyle: TextStyle(
                      //                 color: Colors.white,
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: responsiveText(14, context),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: responsiveWidth(56, context),
                      //         height: responsiveHeight(49, context),
                      //         child: Center(
                      //           child: AutoSizeText(
                      //             '99',
                      //             style: GoogleFonts.outfit(
                      //               textStyle: TextStyle(
                      //                 color: Colors.white,
                      //                 fontWeight: FontWeight.w700,
                      //                 fontSize: responsiveText(45, context),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: responsiveHeight(20, context),
                      ),
                      SizedBox(
                        height: responsiveHeight(30, context),
                        width: responsiveWidth(300, context),
                        child: Center(
                          child: AutoSizeText(
                            _data['contest']['name'].toString(),
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
                        height: responsiveHeight(20, context),
                      ),
                      Container(
                        height: responsiveHeight(654, context),
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
                                      color: _data['leaderboard']
                                                      .indexOf(user) +
                                                  1 ==
                                              1
                                          ? Color(0xFFFFEBC666).withOpacity(0.4)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: responsiveWidth(23, context),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:
                                                  responsiveHeight(20, context),
                                              child: AutoSizeText(
                                                user['name'].toString(),
                                                style: GoogleFonts.outfit(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: responsiveText(
                                                        16, context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  responsiveHeight(20, context),
                                              child: AutoSizeText(
                                                user['contests'][widget.id]
                                                            ['time']
                                                        .toString() +
                                                    ' Seconds',
                                                style: GoogleFonts.outfit(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: responsiveText(
                                                        14, context),
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
                                            (_data['leaderboard']
                                                        .indexOf(user) +
                                                    1)
                                                .toString(),
                                            style: GoogleFonts.outfit(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    responsiveText(16, context),
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
                      SizedBox(
                        height: responsiveHeight(21, context),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                        body: Row(
                                          children: [
                                            Expanded(
                                                child: Image.network(
                                                    imageSponsor)),
                                            SizedBox(
                                              width:
                                                  responsiveWidth(390, context),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: responsiveWidth(
                                                        193, context),
                                                    height: responsiveHeight(
                                                        40, context),
                                                    child: Center(
                                                      child: AutoSizeText(
                                                        'Enter Details',
                                                        maxLines: 1,
                                                        style:
                                                            GoogleFonts.outfit(
                                                          textStyle: TextStyle(
                                                            color: Color(
                                                                0xFF903838),
                                                            fontSize:
                                                                responsiveTextLogin(
                                                                    32,
                                                                    context),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: responsiveHeight(
                                                        6, context),
                                                  ),
                                                  SizedBox(
                                                    width: responsiveWidth(
                                                        222, context),
                                                    height: responsiveHeight(
                                                        20, context),
                                                    child: Center(
                                                      child: AutoSizeText(
                                                        'Register to play',
                                                        maxLines: 1,
                                                        style:
                                                            GoogleFonts.outfit(
                                                          textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                responsiveTextLogin(
                                                                    16,
                                                                    context),
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: responsiveHeight(
                                                        24, context),
                                                  ),
                                                  SizedBox(
                                                    width: responsiveWidth(
                                                        325, context),
                                                    height: responsiveHeight(
                                                        58, context),
                                                    child: TextField(
                                                      controller:
                                                          _nameController,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: responsiveWidth(
                                                              36, context),
                                                          top: responsiveHeight(
                                                              19, context),
                                                          bottom:
                                                              responsiveHeight(
                                                                  19, context),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFFFCC9D),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(37),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFFFCC9D),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(37),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xFFFEFBDD),
                                                        hintText:
                                                            'Child\'s Full Name',
                                                        hintStyle:
                                                            GoogleFonts.outfit(
                                                          textStyle: TextStyle(
                                                            color: Color(
                                                                0xFF7C5037),
                                                            fontSize:
                                                                responsiveTextLogin(
                                                                    16,
                                                                    context),
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: responsiveHeight(
                                                        16, context),
                                                  ),
                                                  SizedBox(
                                                    height: responsiveHeight(
                                                        16, context),
                                                  ),
                                                  SizedBox(
                                                    width: responsiveWidth(
                                                        325, context),
                                                    height: responsiveHeight(
                                                        58, context),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              responsiveWidth(
                                                                  125, context),
                                                          height:
                                                              responsiveHeight(
                                                                  58, context),
                                                          child: TextField(
                                                            controller: _age,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly,
                                                            ],
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left:
                                                                    responsiveWidth(
                                                                        36,
                                                                        context),
                                                                top: responsiveHeight(
                                                                    19,
                                                                    context),
                                                                bottom:
                                                                    responsiveHeight(
                                                                        19,
                                                                        context),
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFFFCC9D),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            37),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFFFCC9D),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            37),
                                                              ),
                                                              filled: true,
                                                              fillColor: Color(
                                                                  0xFFFEFBDD),
                                                              hintText: 'Age',
                                                              hintStyle:
                                                                  GoogleFonts
                                                                      .outfit(
                                                                textStyle:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF7C5037),
                                                                  fontSize:
                                                                      responsiveTextLogin(
                                                                          16,
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              responsiveWidth(
                                                                  184, context),
                                                          height:
                                                              responsiveHeight(
                                                                  58, context),
                                                          child: TextField(
                                                            controller:
                                                                _phoneController,
                                                            inputFormatters: [
                                                              LengthLimitingTextInputFormatter(
                                                                  10),
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly,
                                                            ],
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            decoration:
                                                                InputDecoration(
                                                              prefix: Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: responsiveWidth(
                                                                        10,
                                                                        context)),
                                                                child: SizedBox(
                                                                  width: responsiveWidth(
                                                                      23,
                                                                      context),
                                                                  height:
                                                                      responsiveHeight(
                                                                          20,
                                                                          context),
                                                                  child:
                                                                      AutoSizeText(
                                                                    '+91',
                                                                    style: GoogleFonts
                                                                        .outfit(
                                                                      textStyle:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF7C5037),
                                                                        fontSize: responsiveTextLogin(
                                                                            16,
                                                                            context),
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .symmetric(
                                                                vertical: (responsiveHeight(
                                                                            58,
                                                                            context) -
                                                                        responsiveTextLogin(
                                                                            16,
                                                                            context)) /
                                                                    2,
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFFFCC9D),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            37),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFFFCC9D),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            37),
                                                              ),
                                                              filled: true,
                                                              fillColor: Color(
                                                                  0xFFFEFBDD),
                                                              hintText: 'Phone',
                                                              hintStyle:
                                                                  GoogleFonts
                                                                      .outfit(
                                                                textStyle:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF7C5037),
                                                                  fontSize:
                                                                      responsiveTextLogin(
                                                                          16,
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: responsiveHeight(
                                                        20, context),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      setState(() {
                                                        _loading = true;
                                                      });

                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      if (int.parse(_age.text) >
                                                              3 &&
                                                          int.parse(_age.text) <
                                                              103) {
                                                        if (_phoneController
                                                                .text.length ==
                                                            10) {
                                                          await http
                                                              .post(
                                                            Uri.parse(
                                                                'https://api.halftiicket.com/addTempUser'),
                                                            headers: {
                                                              'Content-Type':
                                                                  'application/json',
                                                            },
                                                            body: jsonEncode({
                                                              'name':
                                                                  _nameController
                                                                      .text,
                                                              'childAge':
                                                                  int.parse(_age
                                                                      .text),
                                                              'phoneNumber':
                                                                  int.parse(
                                                                      _phoneController
                                                                          .text),
                                                              "contests": {},
                                                            }),
                                                          )
                                                              .then((value) {
                                                            setState(() {
                                                              _loading = false;
                                                            });

                                                            var data =
                                                                jsonDecode(
                                                                    value.body);
                                                            print(data);
                                                            if (data['contests']
                                                                    .keys
                                                                    .toList()
                                                                    .contains(
                                                                        widget
                                                                            .id) ==
                                                                false) {
                                                              if (data !=
                                                                      {
                                                                        "message":
                                                                            "minimum child age is 3"
                                                                      } ||
                                                                  data !=
                                                                      {
                                                                        "detail":
                                                                            [
                                                                          {
                                                                            "loc":
                                                                                [
                                                                              "body",
                                                                              "email"
                                                                            ],
                                                                            "msg":
                                                                                "value is not a valid email address",
                                                                            "type":
                                                                                "value_error.email"
                                                                          }
                                                                        ]
                                                                      } ||
                                                                  data !=
                                                                      "{detail: [{loc: [body], msg: value is not a valid dict, type: type_error.dict}]}") {
                                                                preferences.setInt(
                                                                    'phoneNumber',
                                                                    data[
                                                                        'phoneNumber']);
                                                                preferences.setInt(
                                                                    'childAge',
                                                                    data[
                                                                        'childAge']);
                                                                preferences
                                                                    .setString(
                                                                        'name',
                                                                        data[
                                                                            'name']);
                                                                preferences
                                                                    .setString(
                                                                        '_id',
                                                                        data[
                                                                            '_id']);

                                                                preferences.setString(
                                                                    'contests',
                                                                    data['contests']
                                                                        .toString());

                                                                _nameController =
                                                                    TextEditingController(
                                                                        text:
                                                                            '');

                                                                _phoneController =
                                                                    TextEditingController(
                                                                        text:
                                                                            '');

                                                                _age =
                                                                    TextEditingController(
                                                                        text:
                                                                            '');
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    '/${widget.id}');
                                                              } else {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        ((context) {
                                                                      return Column(
                                                                        children: [
                                                                          Text(
                                                                              'Try again'),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: responsiveWidth(200, context),
                                                                              height: responsiveHeight(50, context),
                                                                              color: Colors.yellow,
                                                                              child: Center(child: Text('Close')),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }));
                                                              }
                                                            } else {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Column(
                                                                      children: [
                                                                        Text(
                                                                            'Already Played This Contest'),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                responsiveWidth(200, context),
                                                                            height:
                                                                                responsiveHeight(50, context),
                                                                            color:
                                                                                Colors.yellow,
                                                                            child:
                                                                                Center(child: Text('Close')),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  });
                                                            }
                                                          });
                                                        } else {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Column(
                                                                  children: [
                                                                    Text(
                                                                        'Phone Number must be of 10 numbers'),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: responsiveWidth(
                                                                            200,
                                                                            context),
                                                                        height: responsiveHeight(
                                                                            50,
                                                                            context),
                                                                        color: Colors
                                                                            .yellow,
                                                                        child: Center(
                                                                            child:
                                                                                Text('Close')),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                        }
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Column(
                                                                children: [
                                                                  Text(
                                                                      'Please Enter An Appropriate Age'),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: responsiveWidth(
                                                                          200,
                                                                          context),
                                                                      height: responsiveHeight(
                                                                          50,
                                                                          context),
                                                                      color: Colors
                                                                          .yellow,
                                                                      child: Center(
                                                                          child:
                                                                              Text('Close')),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    },
                                                    child: Container(
                                                      height: responsiveHeight(
                                                          58, context),
                                                      width: responsiveWidth(
                                                          326, context),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(37),
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFFFFB2B2),
                                                            Color(0xFFFBC63C),
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: SizedBox(
                                                          height:
                                                              responsiveHeight(
                                                                  25, context),
                                                          width:
                                                              responsiveWidth(
                                                                  76, context),
                                                          child: Center(
                                                            child: AutoSizeText(
                                                              'Register',
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                textStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      responsiveTextLogin(
                                                                          20,
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
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
                                                    imageSponsor)),
                                          ],
                                        ),
                                      )));
                        }),
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
                                height: responsiveHeight(25, context),
                                width: responsiveWidth(100, context),
                                child: Center(
                                  child: AutoSizeText(
                                    'Participate',
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            responsiveTextLogin(20, context),
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
                    ],
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
