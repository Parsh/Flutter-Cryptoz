import 'crypto_data.dart';
import 'crypto_data_mock.dart';
import 'crypto_data_prod.dart';

enum Flavor{
  mock,
  production
}

class Injector{
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configuration(Flavor flavor){
    _flavor = flavor;
  }

  factory Injector(){
    return _singleton;
  }

  Injector._internal();

  CryptoAPI get cryptoAPI{
    switch(_flavor){
      case Flavor.mock: return new MockCryptoAPI();
      default: return new ProductionCryptoAPI();
    }
  }
}