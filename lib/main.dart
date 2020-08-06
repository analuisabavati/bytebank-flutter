import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var transferFormWidget = TransferForm();

    return MaterialApp(
      home: TransferList(),
      theme: ThemeData.dark(),
    );
  }
}

class TransferForm extends StatefulWidget {
  @override
  _TransferFormState createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  bool _isValueFieldValid = false;
  bool _isAccountFieldValid = false;
  bool _isValueFieldDirty = false;
  bool _isAccountFieldDirty = false;

  final TextEditingController _accountNumberFieldController =
  TextEditingController();

  final TextEditingController _valueFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _accountNumberFieldController.addListener(() {
      _validateFields();
    });
    _valueFieldController.addListener(() {
      _validateFields();
    });
  }

  bool _isFormValid() {
    return _isValueFieldValid && _isAccountFieldValid;
  }

  _validateFields() {
    setState(() {
      _isAccountFieldValid =
          int.tryParse(_accountNumberFieldController.text) != null;
      _isValueFieldValid = int.tryParse(_valueFieldController.text) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transfer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: _accountNumberFieldController,
              label: 'Account number',
              hint: '0000',
              autofocus: true,
              onChanged: (value) => _isValueFieldDirty = true,
              hasError: _isValueFieldDirty && !_isValueFieldDirty,
            ),
            Editor(
              controller: _valueFieldController,
              label: 'Value',
              hint: '0000',
              icon: Icons.monetization_on,
              onChanged: (value) => _isValueFieldDirty = true,
              hasError: _isValueFieldDirty && !_isValueFieldDirty,
            ),
            RaisedButton(
              child: Text('Confirm'),
              onPressed: () => _createdTransfer(context),
            ),
          ],
        ),
      ),
    );
  }

  void _createdTransfer(BuildContext context) {
    final int accountNumber = int.tryParse(_accountNumberFieldController.text);
    final double value = double.tryParse(_valueFieldController.text);

    if (accountNumber != null && value != null) {
      final transferCreated =
      Transfer(accountNumber: accountNumber, value: value);
      debugPrint('$transferCreated');
      Navigator.pop(context, transferCreated);
    }
  }

  @override
  void dispose() {
    debugPrint('Dispose called from TransferForm');
    _accountNumberFieldController.dispose();
    _valueFieldController.dispose();
    super.dispose();
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool autofocus;

  const Editor({@required this.controller,
    @required this.label,
    @required this.hint,
    this.autofocus,
    this.icon,
    bool Function(String) onChanged,
    bool hasError});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 24,
        ),
        decoration: InputDecoration(
          icon: icon != null ? Icon(this.icon) : null,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
        autofocus: autofocus != null ? autofocus : false,
      ),
    );
  }
}

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

class Transfer {
  final double value;
  final int accountNumber;

  const Transfer({this.value, this.accountNumber});

  @override
  String toString() {
    return 'Transfer{value: $value, accountNumber: $accountNumber}';
  }
}
