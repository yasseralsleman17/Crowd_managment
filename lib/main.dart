import 'package:flutter/material.dart';

import 'first_page.dart';


String API = "http://192.168.100.143/crowdmanagment/";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: FirstPage(),
    );
  }
}
