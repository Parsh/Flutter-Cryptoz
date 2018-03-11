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
  final List<MaterialColor> colors = [Colors.blue, Colors.red, Colors.indigo];

  Future<List> getCurrencies() async{
    number = 50;
    String cryptoURL = "https://api.coinmarketcap.com/v1/ticker/?limit=$number";
    http.Response response = await http.get(Uri.encodeFull(cryptoURL));
    return JSON.decode(response.body);
  }

  Widget getSubtitle(String priceUSD, String percentageChange){
  
    TextSpan priceTextWidget = new TextSpan(
      text: "\$$priceUSD\n", // \$ is interpreted as $ character and the 2nd $ represents String interpolation
      style: new TextStyle(color: Colors.black)
    );
    
    String precentageChangeText = "1 hour: $percentageChange%";
    
    TextSpan percentageChangeWidget = double.parse(percentageChange)>0? new TextSpan(
      text: precentageChangeText, style: new TextStyle(color: Colors.green)
    ): new TextSpan(
      text: precentageChangeText, style: new TextStyle(color: Colors.red)
    );

    return new RichText(
      text: new TextSpan(
        children: [priceTextWidget, percentageChangeWidget]
      )
    );
  }

  Widget getUI(Map currency, MaterialColor color){
      return new ListTile(
        leading: new CircleAvatar(
          backgroundColor: color,
          child: new Text(currency['name'][0]),
          ),
        title: new Text(currency['name'], style: new TextStyle(fontWeight: FontWeight.bold)),
        subtitle: getSubtitle(currency['price_usd'], currency['percent_change_1h']),
      );
  }

  Widget cryptoWidget(){
   return new Container(
     child: new Flexible(
       child: new ListView.builder(
         itemCount: currencies.length,
         itemBuilder: (BuildContext context, int index){
           
           Map currency = currencies[index];
           MaterialColor color = colors[index % colors.length];
           return getUI(currency, color);

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

