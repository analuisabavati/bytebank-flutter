import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: TransferForm()));
  }
}

class TransferForm extends StatelessWidget {
  final TextEditingController _accountNumberFieldController =
      TextEditingController();
  final TextEditingController _valueFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Creating Transfer'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _accountNumberFieldController,
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                  hintText: '0000',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _valueFieldController,
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Value',
                  hintText: '0.00',
                ),
              ),
            ),
            RaisedButton(
              child: Text('Confirm'),
              onPressed: () {
                debugPrint('pressed!');

                final int accountNumber =
                    int.tryParse(_accountNumberFieldController.text);
                final double value =
                    double.tryParse(_valueFieldController.text);

                if (accountNumber != null && value != null) {
                  final transferCreated = Transfer(value, accountNumber);
                debugPrint('$transferCreated');
                }
              },
            ),
          ],
        ));
  }
}

class TransferList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TransferItem(Transfer(200.00, 2000)),
          TransferItem(Transfer(300.00, 3001)),
        ],
      ),
      appBar: AppBar(
        title: Text('Transfers'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);

  @override
  String toString() {
    return 'Transfer {value: $value, accountNumber: $accountNumber}';
  }
}
