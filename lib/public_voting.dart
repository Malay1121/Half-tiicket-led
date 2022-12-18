import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

class _PublicVotingState extends State<PublicVoting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var response = await http.get(
        Uri.parse(
          'https://api.halftiicket.com/getBands',
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
                    for (var band in _data['bands'])
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedBand = band['_id'];
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _selectedBand == band['_id']
                                    ? Colors.yellowAccent
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 3,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Image.network(
                                    band['logo'],
                                    width: 100,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        color: Colors.blue.withOpacity(0.4),
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    100) /
                                                _votes['votes'][_data['bands']
                                                    .indexOf(band)]['votes'],
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              band['name'],
                                            ),
                                            // Spacer(),
                                            _votes != {}
                                                ? Text(_votes['votes'][
                                                                _data['bands']
                                                                    .indexOf(
                                                                        band)]
                                                            ['votes']
                                                        .toStringAsFixed(1) +
                                                    ' %')
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
          _selectedBand != ''
              ? GestureDetector(
                  onTap: () async {
                    final response = await http.post(
                      Uri.parse(
                          'https://api.halftiicket.com/addVotes/$_selectedBand'),
                      headers: {
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode({'id': _selectedBand}),
                    );
                    final voteResponse = await http.get(
                      Uri.parse(
                        'https://api.halftiicket.com/getVotes',
                      ),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                    );
                    setState(() {
                      _votes = jsonDecode(voteResponse.body) as Map;
                    });
                    var channel = WebSocketChannel.connect(
                      Uri.parse('ws://26.243.151.253::8000/ws/connect'),
                    );
                    channel.stream.listen((event) {
                      String data = event.toString();

                      setState(() {
                        _votes = jsonDecode(data) == null
                            ? {
                                'name': 'Atharva',
                                'price': 10,
                                'image':
                                    'http://172.105.41.217:8000/get-image/atharva_dalal',
                                'bid_by': null,
                              }
                            : jsonDecode(data);
                      });
                    });
                    print(_votes);
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    child: Text('Vote!'),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
