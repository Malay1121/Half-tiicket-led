import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => OffersPageState();
}

dynamic _data = {};

class OffersPageState extends State<OffersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var response = await http.get(
        Uri.parse(
          'https://api.halftiicket.com/getOffers',
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
    var _mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(),
                border: OutlineInputBorder()),
          ),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10),
              children: [
                for (var offer in _data['list'])
                  OfferCard(
                    name: offer['name'],
                    description: offer['description'],
                    img: offer['img'],
                    link: offer['link'],
                    title: offer['title'],
                    index: _data['list'].indexOf(offer),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key? key,
    required this.name,
    required this.img,
    required this.description,
    required this.title,
    required this.link,
    required this.index,
  }) : super(key: key);

  final String name;
  final String img;
  final String description;
  final String title;
  final String link;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10,
        right: index.isEven == false ? 10 : 0,
        left: index.isOdd == false ? 10 : 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 3,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              name,
            ),
            Image.network(
              img,
            ),
            Text(
              title,
            ),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text('More Details'),
          ],
        ),
      ),
    );
  }
}
