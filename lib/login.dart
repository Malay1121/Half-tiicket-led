import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/public_voting.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _passwordController = TextEditingController();
TextEditingController _phoneController = TextEditingController();

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({super.key});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PublicVoting()));
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
    );
  }
}
