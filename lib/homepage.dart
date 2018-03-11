import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List currencies;
  int number;
  final List<MaterialColor> colors = [Colors.blue, Colors.red, Colors.indigo,]

  Future<List> getCurrencies() async{
    number = 50;
    String cryptoURL = "https://api.coinmarketcap.com/v1/ticker/?limit=${number}";
    http.Response response = await http.get(Uri.encodeFull(cryptoURL));
    return JSON.decode(response.body);
  }

  Widget cryptoWidget(){
   return new Container(
     child: new Flexible(
       child: new ListView.builder(
         itemBuilder: (BuildContext context, int index){

         },
       )
     ),
   ); 
  }

  @override
  void initState() async {
    super.initState();
    currencies = await getCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: cryptoWidget(),
    );
  }

}

