import 'package:flutter/material.dart';
import 'package:yukbacaquran/screens/beranda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yuk Baca Quran',
      debugShowCheckedModeBanner: false,
      home: BerandaPage(),
    );
  }
}
