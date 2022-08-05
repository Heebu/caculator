import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'calculator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Calculator',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

//flutter pub add get
