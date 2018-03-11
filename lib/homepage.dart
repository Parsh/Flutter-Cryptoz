import 'package:flutter/material.dart';
import 'dart:async';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List currencies;

  Future<List> getCurrencies() async{
    String cryptoURL = "";
  }

  Widget _cryptoWidget(){
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
  void initState(){
    super.initState();
    currencies = await getCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: _cryptoWidget(),
    );
  }

}

