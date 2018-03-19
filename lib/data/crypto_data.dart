import 'dart:async';

class CryptoModel {
  String name;
  String priceUSD;
  String percentageChange1h;

  CryptoModel({
    this.name,
    this.priceUSD,
    this.percentageChange1h
  });

  CryptoModel.fromMap(Map<String, dynamic> currencyMap){
    name = currencyMap['name'];
    priceUSD = currencyMap['priceUSD'];
    percentageChange1h = currencyMap['percentageChange1h'];
  }

}

abstract class CryptoAPI  {
  Future<List<CryptoModel>> fetchCurrencies();
}

class FetchDataException implements Exception{
   final message;

  FetchDataException([this.message]);

  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}