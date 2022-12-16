import 'dart:async';

import 'package:flutter/material.dart';

final _stopwatch = Stopwatch();
String timeTaken = '0:0:0';

class TypingSpeed extends StatefulWidget {
  const TypingSpeed({super.key});

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('quizzifications'),
          Text(_stopwatch.elapsed.toString()),
          SizedBox(
            width: 300,
            height: 30,
            child: TextField(
              onTap: () {
                _stopwatch.start();
              },
              onChanged: ((value) {
                if (value == 'quizzifications') {
                  _stopwatch.stop();
                  setState(() {
                    timeTaken = _stopwatch.elapsed.toString();
                  });
                }
              }),
              onSubmitted: (s) {
                if (s == 'quizzifications') {
                  _stopwatch.stop();
                  setState(() {
                    timeTaken = _stopwatch.elapsed.toString();
                  });
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
