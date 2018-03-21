import 'package:flutter/material.dart';
import './homepage.dart';
import 'data/dependency_injection.dart';

void main(){
  Injector.configure(Flavor.production);
  runApp(new MyApp());
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "The Crypto App",
        theme: new ThemeData(primarySwatch: Colors.blue),
        home: new HomePage());
  }
}
