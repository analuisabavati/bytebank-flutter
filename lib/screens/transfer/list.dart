
import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer/form.dart';
import 'package:flutter/material.dart';

class TransferList extends StatefulWidget {
  final List<Transfer> _transfers = List();

  @override
  State<StatefulWidget> createState() {
    return TransfersListState();
  }
}

class TransfersListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget._transfers.length,
          itemBuilder: (context, index) {
            final transfer = widget._transfers[index];
            return TransferItem(transfer);
          }),
      appBar: AppBar(
        title: Text('Transfers'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: () {
              debugPrint('bulb');
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future =
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForm();
          }));
          future.then((transferReceived) {
            debugPrint('Future');
            debugPrint('$transferReceived');
            if (transferReceived != null) {
              setState(() {
                widget._transfers.add(transferReceived);
              });
            }
          });
        },
      ),
    );
  }
}


class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  const TransferItem(this._transfer);

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
