import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:leaderboard/constant.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/home_page.dart';
import 'package:leaderboard/leaderboard.dart';
import 'package:leaderboard/login.dart';
import 'package:leaderboard/math_quiz.dart';
import 'package:leaderboard/offers_page.dart';
import 'package:leaderboard/public_voting.dart';
import 'package:leaderboard/register.dart';
import 'package:leaderboard/responsive.dart';
import 'package:leaderboard/slide_puzzle.dart';
import 'package:leaderboard/spin_the_wheel.dart';
import 'package:leaderboard/typing_speed.dart';
import 'package:leaderboard/voting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/votes': (context) => VotingScreen(),
        '/voting': (context) => PublicVoting(),
        '/login': (context) => LoginScreen(),
        '/spin-the-wheel': (context) => SpinWheelRegister(),
        '/leaderboard/639fe06f6deeaf05475f1775': (context) => LeaderBoard(
              id: '639fe06f6deeaf05475f1775',
            ),
        '/639fe06f6deeaf05475f1775': (context) => MathQuiz(),
        '/register': (context) => RegisterationScreen(),
        '/offers': (context) => OffersPage(),
        '/639cda5575f95e42b54ff971': (context) => SlidePuzzle(
            // id: '639cdb1675f95e42b54ff971',
            ),
        '/leaderboard/639cda5575f95e42b54ff971': (context) => LeaderBoard(
              id: '639cda5575f95e42b54ff971',
            ),
        '/639cdb1675f95e42b54ff972': (context) => TypingSpeed(
              id: '639cdb1675f95e42b54ff972',
            ),
        '/leaderboard/639cdb1675f95e42b54ff972': (context) => LeaderBoard(
              id: '639cdb1675f95e42b54ff972',
            ),
        '/spin-the-wheel-play': (context) => SpinTheWheel()
      },
    );
  }
}

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => MainScreenState();
// }

// dynamic data = {};
// dynamic formattedData = {};

// class MainScreenState extends State<MainScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       var response = await http.get(
//         Uri.parse(
//           'https://fluffy-aliens-lick-103-238-108-221.loca.lt/get',
//         ),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       setState(() {
//         data = jsonDecode(response.body) as Map;
//         formattedData = jsonDecode(response.body) as Map;
//         for (var dat in formattedData['data']) {
//           formattedData['data'][formattedData['data'].indexOf(dat)].addEntries({
//             'first': formattedData['data'][formattedData['data'].indexOf(dat)]
//                 ['scores'][0],
//           }.entries);
//           formattedData['data'][formattedData['data'].indexOf(dat)]['scores']
//               .remove(0);

//           // for (var da in dat['scores']) {
//           //   // formattedData['data'][dat['scores'].indexOf(da)]
//           //   if (dat['scores'].length - 1 <= 6) {}
//           // }
//         }
//       });
//       print(data);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _mediaQuery = MediaQuery.of(context).size;

//     return Column(
//       children: [
//         CarouselSlider(
//           items: [
//             for (var grades in formattedData['data'])
//               Row(
//                 children: [
//                   SizedBox(
//                     width: responsiveWidth(30, context),
//                   ),
//                   SizedBox(
//                     height: responsiveHeight(820, context),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           grades['grade'].toString(),
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: responsiveText(29, context),
//                             fontWeight: FontWeight.w600,
//                             decoration: TextDecoration.none,
//                           ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.blue.shade900,
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 4,
//                                 spreadRadius: 2,
//                                 color: Colors.grey,
//                               ),
//                             ],
//                           ),
//                           width: responsiveWidth(400, context),
//                           height: responsiveHeight(780, context),
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: responsiveHeight(40, context),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     '1',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: responsiveText(25, context),
//                                       fontWeight: FontWeight.w900,
//                                       decoration: TextDecoration.none,
//                                     ),
//                                   ),
//                                   Text(
//                                     'st ',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: responsiveText(15, context),
//                                       fontWeight: FontWeight.w900,
//                                       decoration: TextDecoration.none,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Rank',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: responsiveText(25, context),
//                                       fontWeight: FontWeight.w900,
//                                       decoration: TextDecoration.none,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: responsiveHeight(40, context),
//                               ),
//                               CircleAvatar(
//                                 radius: responsiveText(150, context),
//                                 backgroundImage: NetworkImage(
//                                   'https://www.shareicon.net/data/512x512/2016/02/07/715342_people_512x512.png',
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: responsiveHeight(10, context),
//                               ),
//                               Text(
//                                 grades['first']['name'].toString(),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: responsiveText(25, context),
//                                   fontWeight: FontWeight.w700,
//                                   decoration: TextDecoration.none,
//                                 ),
//                               ),
//                               Text(
//                                 grades['grade'].toString(),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: responsiveText(20, context),
//                                   fontWeight: FontWeight.w600,
//                                   decoration: TextDecoration.none,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: responsiveHeight(40, context),
//                               ),
//                               Text(
//                                 grades['first']['name'].toString(),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: responsiveText(25, context),
//                                   fontWeight: FontWeight.w700,
//                                   decoration: TextDecoration.none,
//                                 ),
//                               ),
//                               Text(
//                                 'Points',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: responsiveText(20, context),
//                                   fontWeight: FontWeight.w600,
//                                   decoration: TextDecoration.none,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: responsiveHeight(10, context),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: responsiveWidth(40, context),
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(
//                         height: responsiveHeight(30, context),
//                       ),
//                       for (var classlist in grades['scores'])
//                         Padding(
//                           padding: EdgeInsets.only(
//                             bottom: responsiveHeight(20, context),
//                           ),
//                           child: Container(
//                             height: responsiveHeight(100, context),
//                             width: responsiveWidth(940, context),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: Colors.blue.shade200,
//                               boxShadow: [
//                                 BoxShadow(
//                                   blurRadius: 4,
//                                   spreadRadius: 2,
//                                   color: Colors.grey,
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: responsiveWidth(15, context),
//                                 ),
//                                 CircleAvatar(
//                                   radius: responsiveText(30, context),
//                                   backgroundImage: NetworkImage(
//                                     'https://www.shareicon.net/data/512x512/2016/02/07/715342_people_512x512.png',
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: responsiveWidth(50, context),
//                                 ),
//                                 Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     SizedBox(
//                                       height: responsiveHeight(10, context),
//                                     ),
//                                     Text(
//                                       classlist['name'].toString(),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: responsiveText(25, context),
//                                         fontWeight: FontWeight.w700,
//                                         decoration: TextDecoration.none,
//                                       ),
//                                     ),
//                                     Text(
//                                       grades['grade'].toString(),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: responsiveText(20, context),
//                                         fontWeight: FontWeight.w600,
//                                         decoration: TextDecoration.none,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: responsiveHeight(10, context),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: responsiveWidth(300, context),
//                                 ),
//                                 Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     SizedBox(
//                                       height: responsiveHeight(10, context),
//                                     ),
//                                     Text(
//                                       grades['points'].toString(),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: responsiveText(25, context),
//                                         fontWeight: FontWeight.w700,
//                                         decoration: TextDecoration.none,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Points',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: responsiveText(20, context),
//                                         fontWeight: FontWeight.w600,
//                                         decoration: TextDecoration.none,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: responsiveHeight(10, context),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: responsiveWidth(300, context),
//                                 ),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '2',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: responsiveText(35, context),
//                                         fontWeight: FontWeight.w900,
//                                         decoration: TextDecoration.none,
//                                       ),
//                                     ),
//                                     Text(
//                                       'nd',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: responsiveText(20, context),
//                                         fontWeight: FontWeight.w900,
//                                         decoration: TextDecoration.none,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       Text(
//                         'Made By Uvesh & Malay',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: responsiveText(15, context),
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: responsiveWidth(30, context),
//                   ),
//                 ],
//               ),
//           ],
//           options: CarouselOptions(
//             height: _mediaQuery.height,
//             initialPage: 0,
//             enableInfiniteScroll: true,
//             reverse: false,
//             autoPlay: true,
//             autoPlayInterval: Duration(seconds: 3),
//             autoPlayAnimationDuration: Duration(milliseconds: 800),
//             autoPlayCurve: Curves.fastOutSlowIn,
//             scrollDirection: Axis.horizontal,
//             aspectRatio: 1440 / 900,
//             viewportFraction: 1,
//           ),
//         ),
//       ],
//     );
//   }
// }
