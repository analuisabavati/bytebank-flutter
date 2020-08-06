import 'package:bytebank/screens/transfer/form.dart';
import 'package:bytebank/screens/transfer/list.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var transferFormWidget = TransferForm();

    return MaterialApp(
      home: Scaffold(
        body: TransferList(),
      ),
      theme: ThemeData(
        primaryColor: Colors.red[900],
        accentColor: Colors.red[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.red[200],
          textTheme: ButtonTextTheme.primary,
        )
      ),
    );
  }
}
