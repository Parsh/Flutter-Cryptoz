import 'package:flutter/material.dart';

import "./homepage.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "The Crypto App",
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      home: new HomePage()
    );  
  }
}