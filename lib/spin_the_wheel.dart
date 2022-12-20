import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SpinTheWheel extends StatefulWidget {
  const SpinTheWheel({super.key});

  @override
  State<SpinTheWheel> createState() => _SpinTheWheelState();
}

StreamController<int> controller = StreamController<int>();

class _SpinTheWheelState extends State<SpinTheWheel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FortuneWheel(
            selected: controller.stream,
            items: [
              FortuneItem(child: Text('Han Solo')),
              FortuneItem(child: Text('Yoda')),
              FortuneItem(child: Text('Obi-Wan Kenobi')),
            ],
          ),
        ],
      ),
    );
  }
}
