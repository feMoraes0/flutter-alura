import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListTransfers(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Form of Transfers

class FormTransfers extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return FormTransfersState();
  }
}



class FormTransfersState extends State<FormTransfers> {
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  void _createTransfer(context) {
    final int accountNumber = int.tryParse(_accountNumberController
      .text);
    final double value = double.tryParse(_valueController.text);
    if (accountNumber != null && value != null) {
      final newTransfer = Transfer(value, accountNumber);
      debugPrint(newTransfer.toString());
      Navigator.pop(context, newTransfer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Transfer")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controller: _accountNumberController,
              title: "Account Number",
              tip: "0000",
            ),
            Editor(
              controller: _valueController,
              title: "Value",
              tip: "0.00",
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              onPressed: () => _createTransfer(context),
              child: Text("Confirm"),
              color: Colors.blue[100],
            )
          ],
        )
      )
    );
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

class ListTransfers extends StatefulWidget {
  // deveria estar no state se fosse algo não constante
  final List<Transfer> _transfers = List();

  @override
  State<StatefulWidget> createState() {
    return ListTransfersState();
  }
}

class ListTransfersState extends State<ListTransfers>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transfers")),
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (BuildContext context, int index) {
          return TransferCard(widget._transfers[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transfer> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormTransfers();
              }
            )
          );
          // ativa quando retornar a pagina após navegação
          // pop notifica o future que vai para o 'then'
          future.then((receivedTransfer) {
            if(receivedTransfer != null) {
              setState(() {
                widget._transfers.add(receivedTransfer);
              });
            }
            debugPrint("future.then");
            debugPrint(receivedTransfer.toString());
          });
        },
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
