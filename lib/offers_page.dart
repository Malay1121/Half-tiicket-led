import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:leaderboard/responsive.dart';
import 'package:leaderboard/typing_speed.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => OffersPageState();
}

dynamic _data = {
  "list": [
    {
      "_id": "6395c868ed9d5a6f772a21ba",
      "name": "demo name",
      "img":
          "https://www.ssbcrack.com/wp-content/uploads/2022/11/IMA-POP-10-Dec-2022.png",
      "code": "demo code",
      "description": "demo description",
      "link": "demo.link",
      "expiry_date": "2022-12-11T12:15:38.211000",
      "title": "demo tittle"
    },
    {
      "_id": "6395ca01ed9d5a6f772a21bb",
      "name": "demo 1",
      "img":
          "https://www.ssbcrack.com/wp-content/uploads/2022/11/IMA-POP-10-Dec-2022.png",
      "code": "demo code",
      "description": "demo description",
      "link": "demo.link",
      "expiry_date": "2022-12-11T12:15:38.211000",
      "title": "demo tittle"
    },
    {
      "_id": "6395ca05ed9d5a6f772a21bc",
      "name": "demo 2",
      "img":
          "https://www.ssbcrack.com/wp-content/uploads/2022/11/IMA-POP-10-Dec-2022.png",
      "code": "demo code",
      "description": "demo description",
      "link": "demo.link",
      "expiry_date": "2022-12-11T12:15:38.211000",
      "title": "demo tittle"
    },
    {
      "_id": "6395ca0ced9d5a6f772a21bd",
      "name": "demo 3",
      "img":
          "https://www.ssbcrack.com/wp-content/uploads/2022/11/IMA-POP-10-Dec-2022.png",
      "code": "demo code",
      "description": "demo description",
      "link": "demo.link",
      "expiry_date": "2022-12-11T12:15:38.211000",
      "title": "demo tittle"
    }
  ]
};
bool _loading = true;

class OffersPageState extends State<OffersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await http.get(
        Uri.parse(
          'https://api.halftiicket.com/getOffers',
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
    var _mediaQuery = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        color: Color(0xFFFBE43C),
        backgroundColor: Color(0xFFFFD18B),
      ),
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(),
                  border: OutlineInputBorder()),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: responsiveHeight(60, context)),
                children: [
                  Column(
                    children: [
                      for (var offer in _data['list'])
                        Container(
                          width: responsiveWidth(341, context),
                          height: responsiveHeight(358, context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.center,
                              colors: [
                                Color(0xFFFFF8C6),
                                Color(0xFFF7DA00),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(90),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(offer['img']),
                            ),
                          ),
                          child: Column(
                            children: [
                              Spacer(),
                              Container(
                                width: responsiveWidth(341, context),
                                height: responsiveHeight(214, context),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: responsiveHeight(12, context),
                                    ),
                                    SizedBox(
                                      width: responsiveWidth(200, context),
                                      height: responsiveHeight(60, context),
                                      child: Center(
                                        child: AutoSizeText(
                                          offer['name'],
                                          style: GoogleFonts.outfit(
                                            textStyle: TextStyle(
                                              color: Color(0xFF903838),
                                              fontSize:
                                                  responsiveText(24, context),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(8, context),
                                    ),
                                    SizedBox(
                                      width: responsiveWidth(220, context),
                                      height: responsiveHeight(21, context),
                                      child: Center(
                                        child: AutoSizeText(
                                          offer['description'],
                                          style: GoogleFonts.outfit(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  responsiveText(17, context),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(23, context),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showCupertinoModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: responsiveHeight(
                                                    561, context),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(60),
                                                    topRight:
                                                        Radius.circular(60),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        height: responsiveHeight(54, context),
                                        width: responsiveWidth(157, context),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFFF89A0B),
                                              Color(0xFFE97522),
                                            ],
                                          ),
                                        ),
                                        child: SizedBox(
                                          child: Center(
                                            child: AutoSizeText(
                                              'View Details',
                                              style: GoogleFonts.outfit(
                                                textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: responsiveText(
                                                      20, context),
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
                        )
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
