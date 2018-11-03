import 'package:flutter/material.dart';
import 'package:phoot_shoot_v1/market/market.dart';

void main() => runApp(new PhootShoot());

class PhootShoot extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MarketPage(title: 'Market'),
    );
  }
}


