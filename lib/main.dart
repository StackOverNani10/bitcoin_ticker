import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'api_key.dart';
import 'card_widget.dart';

void main() => runApp(CoinTicker());

class CoinTicker extends StatefulWidget {
  @override
  State<CoinTicker> createState() => _CoinTickerState();
}

class _CoinTickerState extends State<CoinTicker> {
  String dropdownValue = currenciesList.first;

  String rateBTC = '?';
  String rateETH = '?';
  String rateLTC = '?';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {

    String cryptoValueBTC = "BTC";
    String cryptoValueETH = "ETH";
    String cryptoValueLTC = "LTC";
    String selectedCurrencyValue = dropdownValue;

    final apiUrlBTC = 'https://rest.coinapi.io/v1/exchangerate/${cryptoValueBTC}/${selectedCurrencyValue}?apikey=${apiKey}';
    final apiUrlETH = 'https://rest.coinapi.io/v1/exchangerate/${cryptoValueETH}/${selectedCurrencyValue}?apikey=${apiKey}';
    final apiUrlLTC = 'https://rest.coinapi.io/v1/exchangerate/${cryptoValueLTC}/${selectedCurrencyValue}?apikey=${apiKey}';

    try {
      CoinData currentBTCCoinData = CoinData(apiUrlBTC);
      var coinDataBTC = await currentBTCCoinData.getRate();
      setState(() {
        rateBTC = coinDataBTC.toStringAsFixed(2);
      });

      CoinData currentETHCoinData = CoinData(apiUrlETH);
      var coinDataETH = await currentETHCoinData.getRate();
      setState(() {
        rateETH = coinDataETH.toStringAsFixed(2);
      });

      CoinData currentLTCCoinData = CoinData(apiUrlLTC);
      var coinDataLTC = await currentLTCCoinData.getRate();
      setState(() {
        rateLTC = coinDataLTC.toStringAsFixed(2);
      });
    } catch (error) {
      print('Error: ${error}');
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinTicker App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('🤑 Coin Ticker'),
          backgroundColor: Colors.grey.shade800,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CardWidget(cryptoList[0], rateBTC, dropdownValue).cardwidget(),
                    CardWidget(cryptoList[1], rateETH, dropdownValue).cardwidget(),
                    CardWidget(cryptoList[2], rateLTC, dropdownValue).cardwidget(),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                height: 170.0,
                width: double.infinity,
                child: Center(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.grey.shade800,
                    items: currenciesList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: dropdownValue,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(
                        () {
                          dropdownValue = value!;
                          getData();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

