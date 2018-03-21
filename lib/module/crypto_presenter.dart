import "package:cryptoz/data/crypto_data.dart";

import '../data/dependency_injection.dart';

abstract class CryptoListViewContract{
  void onLoadCryptoComplete(List<CryptoModel> items);
  void onLoadCryptoError();
}

class CrytpoListPresenter{
  CryptoListViewContract _view;
  var _api;

  CrytpoListPresenter(this._view){
   _api = new Injector().cryptoAPI;
  }


  void loadCurrencies(){
    _api
    .fetchCurrencies()
    .then((currency)=> _view.onLoadCryptoComplete(currency))
    .catchError((onError)=> _view.onLoadCryptoError());
  }
}