import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/slide_puzzle.dart';
import 'package:leaderboard/typing_speed.dart';

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
      );
      setState(() {
        _data = jsonDecode(response.body) as Map;
      });
      print(_data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    for (var user in _data['leaderboard'])
                      Container(
                        child: Row(
                          children: [
                            Text(
                              user['name'].toString(),
                            ),
                            Text(
                              'Time:- ' +
                                  user['contests'][widget.id]['time']
                                      .toString(),
                            ),
                          ],
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${widget.id}');
            },
            child: Container(
              height: 100,
              width: double.infinity,
              child: Text('Participate'),
            ),
          ),
        ],
      ),
    );
  }
}
