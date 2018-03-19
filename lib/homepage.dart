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

  Future<List> getCurrencies() async {
    number = 50;
    String cryptoURL = "https://api.coinmarketcap.com/v1/ticker/?limit=$number";
    http.Response response = await http.get(Uri.encodeFull(cryptoURL));
    return JSON.decode(response.body);
  }

  Widget getSubtitle(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = new TextSpan(
        text:
            "\$$priceUSD\n", // \$ is interpreted as $ character and the 2nd $ represents String interpolation
        style: new TextStyle(color: Colors.black, fontSize: 15.0));

    String precentageChangeText = "Past hour: $percentageChange%";

    TextSpan percentageChangeWidget = double.parse(percentageChange) > 0
        ? new TextSpan(
            text: precentageChangeText,
            style: new TextStyle(color: Colors.green, fontSize: 15.0))
        : new TextSpan(
            text: precentageChangeText,
            style: new TextStyle(color: Colors.red, fontSize: 15.0));

    return new RichText(
        text:
            new TextSpan(children: [priceTextWidget, percentageChangeWidget]));
  }

  Widget getUI(Map currency, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(currency['name'],
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
      subtitle:
          getSubtitle(currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
      trailing: new Icon(
        double.parse(currency['percent_change_1h']) > 0
            ? Icons.arrow_drop_up
            : Icons.arrow_drop_down,
        color: double.parse(currency['percent_change_1h']) > 0
            ? Colors.green
            : Colors.red,
        size: 45.0,
      ),
    );
  }

  Widget cryptoWidget() {
    print("Running the cryptoWidget..");
    return new Container(
        child: new ListView.builder(
      itemCount: currencies == null ? 0 : currencies.length,
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          return new Divider();
        }

        final index = i ~/ 2;
        Map currency = currencies[index];
        MaterialColor color = colors[index % colors.length];
        return getUI(currency, color);
      },
    ));
  }

  void fetchCurrencyData() async {
    print('Fetching..');
    currencies =
        await getCurrencies(); // as the data get's fetched it is fed to the currencies variable
    setState(
        () {}); // as the currencies data get's fetched we use set state fxn to re-render the widget UI and
    //therefore the build fxn and hence the cryptoWidget runs again, thereby, displaying the list.
  }

  @override
  void initState() {
    print('Initiated HomePage');
    super.initState();
    fetchCurrencyData();
  }

  @override
  Widget build(BuildContext context) {
    print('The build fxn Runs..');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("The Crypto Report"),
      ),
      body: cryptoWidget(),
    );
  }
}
