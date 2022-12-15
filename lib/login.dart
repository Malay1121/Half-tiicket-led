import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/constant.dart';
import 'package:leaderboard/public_voting.dart';
import 'package:leaderboard/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _passwordController = TextEditingController();
TextEditingController _phoneController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: responsiveHeight(148, context),
            child: Container(
              height: responsiveHeight(732, context),
              width: responsiveWidth(390, context),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/background.png'),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text('Register'),
              Text('Phone Number'),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  hintText: 'Enter Phone Number',
                ),
              ),
              Text('Password'),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  hintText: 'Enter Password',
                ),
              ),
              GestureDetector(
                onTap: () async {
                  SharedPreferences _preferences =
                      await SharedPreferences.getInstance();
                  final response = await http.post(
                    Uri.parse('http://26.243.151.253:8000/login'),
                    headers: {
                      'Content-Type': 'application/json',
                    },
                    body: jsonEncode({
                      'phone': _phoneController.text,
                      'password': _passwordController.text,
                    }),
                  );
                  var data = jsonDecode(response.body);
                  if (data != {"detail": "email or password incorrect"}) {
                    _preferences.setString('email', data['email']);
                    _preferences.setString('phoneNumber', data['phoneNumber']);
                    _preferences.setString('password', data['password']);
                    _preferences.setString('childAge', data['childAge']);
                    _preferences.setString('name', data['name']);
                    _preferences.setString('admin', data['admin']);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PublicVoting()));
                  } else {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return Text('Try again');
                        }));
                  }
                },
                child: Container(
                  height: 50,
                  width: 200,
                  child: Center(
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
