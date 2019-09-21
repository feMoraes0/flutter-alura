import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormTransfers(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Form of Transfers

class FormTransfers extends StatelessWidget {

  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Transfer")
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _accountNumberController,
              style: TextStyle(
                fontSize: 20.0
              ),
              decoration: InputDecoration(
                labelText: "Account number",
                hintText: "0000"
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _valueController,
              style: TextStyle(
                fontSize: 20.0
              ),
              decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: "Value",
                hintText: "0.00"
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          RaisedButton(
            onPressed: () {
              final int accountNumber = int.tryParse(_accountNumberController.text);
              final double value = double.tryParse(_valueController.text);
              if(accountNumber != null && value != null) {
                final newTransfer = Transfer(value, accountNumber);
                debugPrint(newTransfer.toString());
              }
            },
            child: Text("Confirm"),
            color: Colors.blue[100]
          )
        ],
      )
    );
  }
}


// List of Transfers

class ListTransfers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfers")
      ),
      body: Column(
        children: <Widget>[
          TransferCard(Transfer(100.0, 10000)),
          TransferCard(Transfer(200.0, 10000)),
          TransferCard(Transfer(300.0, 10000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: null,),
    );
  }
}

class TransferCard extends StatelessWidget {
  final Transfer _transfer;

  TransferCard(this._transfer);

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
    return "Transfer{value: $value, accountNumber: $accountNumber}";
  }
}

