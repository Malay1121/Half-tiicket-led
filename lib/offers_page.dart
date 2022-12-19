import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => OffersPageState();
}

dynamic _data = {
  "bands": [
    {
      "_id": "6397006722c744a2b5b6b5d0",
      "name": "demo1",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png"
    },
    {
      "_id": "639700cf22c744a2b5b6b5d1",
      "name": "demo2",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png"
    },
    {
      "_id": "639700d422c744a2b5b6b5d2",
      "name": "demo3",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png"
    },
    {
      "_id": "639700d922c744a2b5b6b5d3",
      "name": "demo4",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png"
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
