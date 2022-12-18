import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Login'),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Register')),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/contests');
                },
                child: Text('Contests')),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/offers');
                },
                child: Text('Offers')),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/voting');
                },
                child: Text('Vote Band')),
          ],
        ),
      ),
    );
  }
}
