import 'package:cat_out_of_the_box/src/screens/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Out of the Box',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home()
    );
  }

}