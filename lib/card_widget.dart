import 'package:flutter/material.dart';

class CardWidget {

  String cryptoCoin;
  String rate;
  String dropdownValue;

  CardWidget(this.cryptoCoin, this.rate, this.dropdownValue);

  Card cardwidget() {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
      shadowColor: Colors.black,
      elevation: 5.0,
      color: Colors.blue,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            '1 ${cryptoCoin} = ${rate} ${dropdownValue}',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}