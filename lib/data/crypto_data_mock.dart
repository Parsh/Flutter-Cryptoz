//A mock file for simulating API

import 'dart:async';

import './crypto_data.dart';

class MockCryptoAPI implements CryptoAPI {
  @override
  Future<List<CryptoModel>> fetchCurrencies() {
    // TODO: implement fetchCurrencies
    return new Future.value(dummyCurrecies);
  }
}

//Dummy Data
var dummyCurrecies = <CryptoModel>[
  new CryptoModel(
    name: 'Bitcoin',
    priceUSD: '8000.23',
    percentageChange1h: '-0.7',
  ),
  new CryptoModel(
    name: 'Ethereum',
    priceUSD: '740.23',
    percentageChange1h: '-0.85',
  ),
  new CryptoModel(
    name: 'Ripple',
    priceUSD: '300.00',
    percentageChange1h: '-0.25',
  ),
];
