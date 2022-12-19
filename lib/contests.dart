import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/leaderboard.dart';
import 'package:leaderboard/slide_puzzle.dart';
import 'package:leaderboard/typing_speed.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ContestsScreen extends StatefulWidget {
  const ContestsScreen({super.key});

  @override
  State<ContestsScreen> createState() => _ContestsScreenState();
}

bool _loading = true;
dynamic _data = {
  "contests": [
    {
      "_id": "639cda5575f95e42b54ff971",
      "type": "puzzle",
      "name": "insta Puzzle",
      "img":
          "https://pbs.twimg.com/profile_images/1526231349354303489/3Bg-2ZsT_400x400.jpg",
      "banner": "https://www.rupay.co.in/images/rupay/fampay-card.png"
    },
    {
      "_id": "639cdb1675f95e42b54ff972",
      "type": "typing",
      "name": "fampay typing",
      "img":
          "https://play-lh.googleusercontent.com/yZNjrlHTEGYSAoIKLFd4VMGtRfbE0HPva-ElVRmzll7aE2VPD15gVCu64UaCZoQsqA",
      "banner": "https://i.ytimg.com/vi/tqBiHY6Cvyw/maxresdefault.jpg"
    }
  ]
};

class _ContestsScreenState extends State<ContestsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await http.get(
        Uri.parse(
          'https://api.halftiicket.com/getContests',
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
      child: Scaffold(
        body: Column(
          children: [
            for (var contest in _data['contests'])
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LeaderBoard(id: contest['_id'])));
                },
                child: Container(
                  child: Column(
                    children: [
                      Image.network(
                        contest['banner'].toString(),
                        width: 300,
                        height: 100,
                      ),
                      Image.network(
                        contest['img'].toString(),
                        width: 100,
                        height: 100,
                      ),
                      Text(contest['name'].toString()),
                      Text(contest['type'].toString()),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
