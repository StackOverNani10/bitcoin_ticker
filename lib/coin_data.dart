import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'api_key.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  final url;

  CoinData(this.url);

  Future getRate() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body)['rate'];
      return jsonResponse;
    } else {
      print('Status code: ${response.statusCode}');
    }
  }
}

