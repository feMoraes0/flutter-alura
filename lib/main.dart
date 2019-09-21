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
            appBar: AppBar(title: Text("New Transfer")),
            body: Column(
                children: <Widget>[
                    Editor(
                        controller: _accountNumberController,
                        title: "Account Number",
                        tip: "0000",
                    ),
                    Editor(
                        controller: _valueController,
                        title:"Value",
                        tip: "0.00",
                        icon: Icons.monetization_on
                    ),
                    RaisedButton(
                        onPressed: () => _createTransfer(),
                        child: Text("Confirm"),
                        color: Colors.blue[100],
                    )
                ],
            )
        );
    }

    void _createTransfer() {
        final int accountNumber = int.tryParse(_accountNumberController.text);
        final double value = double.tryParse(_valueController.text);
        if (accountNumber != null && value != null) {
            final newTransfer = Transfer(value, accountNumber);
            debugPrint(newTransfer.toString());
        }
    }
}

class Editor extends StatelessWidget {
    final TextEditingController controller;
    final String title;
    final String tip;
    final IconData icon;

    Editor({this.controller, this.title, this.tip, this.icon});

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
            ),
            child: TextField(
                controller: controller,
                style: TextStyle(
                    fontSize: 20.0,
                ),
                decoration: InputDecoration(
                    icon: (icon != null) ? Icon(icon) : null,
                    labelText: title,
                    hintText: tip,
                ),
                keyboardType: TextInputType.number,
            ),
        );
    }
}

// List of Transfers

class ListTransfers extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text("Transfers")),
            body: Column(
                children: <Widget>[
                    TransferCard(Transfer(100.0, 10000)),
                    TransferCard(Transfer(200.0, 10000)),
                    TransferCard(Transfer(300.0, 10000)),
                ],
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: null,
            ),
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
