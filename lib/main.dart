import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Transferências")),
        body: ListTransfers(),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add)),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListTransfers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransferCard(Transfer(100.0, 10000)),
        TransferCard(Transfer(200.0, 10000)),
        TransferCard(Transfer(300.0, 10000)),
      ],
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
        subtitle: Text(_transfer.billNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int billNumber;

  Transfer(this.value, this.billNumber);
}

