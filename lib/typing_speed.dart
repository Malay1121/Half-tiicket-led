import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

class _TypingSpeedState extends State<TypingSpeed> {
  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(Duration(seconds: 1), (s) {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var response = await http.get(
        Uri.parse(
          'https://random-word-api.herokuapp.com/word?length=15',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      setState(() {
        _data = json.decode(response.body).cast<String>().toList();
      });
      print(_data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                      'x-api-key': _preferences.getString('_id').toString(),
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
                        'api.halftiicket.com/addPlayerContest/${widget.id}?time=1'),
                    headers: {
                      'Content-Type': 'application/json',
                      'x-api-key': _preferences.getString('_id').toString(),
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
              (timeTaken == '0:0:0' ? 'Not Started Yet' : timeTaken)),
        ],
      ),
    );
  }
}
