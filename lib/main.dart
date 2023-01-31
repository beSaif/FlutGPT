import 'package:flutgpt/config/pallete.dart';
import 'package:flutter/material.dart';

import 'views/home_view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkThemeData,
      home: const HomeView(),
    );
  }
}
