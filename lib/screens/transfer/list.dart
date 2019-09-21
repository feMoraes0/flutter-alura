import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

import 'form.dart';

const _titleAppBar = "Transfers";

class ListTransfers extends StatefulWidget {
  // deveria estar no state se fosse algo não constante
  final List<Transfer> _transfers = List();

  @override
  State<StatefulWidget> createState() {
    return ListTransfersState();
  }
}

class ListTransfersState extends State<ListTransfers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleAppBar)),
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
