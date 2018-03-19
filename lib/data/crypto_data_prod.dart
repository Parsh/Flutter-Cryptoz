import 'dart:async';
import 'dart:convert';
import 'crypto_data.dart';

import 'package:http/http.dart' as http;

class ProductionCryptoAPI implements CryptoAPI{
  String cryptoURL = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
  @override
  Future<List<CryptoModel>> fetchCurrencies() async{
    // TODO: implement fetchCurrencies
    http.Response response = await http.get(Uri.encodeFull(cryptoURL));
    var statusCode = response.statusCode;
    List responseBody = JSON.decode(response.body);

    if(statusCode != 200 || responseBody == null){
      throw new FetchDataException("An error occured while fetching [StatusCode: $statusCode]");
    }

    return responseBody.map((currency)=> new CryptoModel.fromMap(currency)).toList();
  }
}

