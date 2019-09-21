import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const _titleAppBar = "New Transfer";

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
    final int accountNumber = int.tryParse(_accountNumberController.text);
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
      appBar: AppBar(title: Text(_titleAppBar)),
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
                child: Text("Confirm")),
          ],
        ),
      ),
    );
  }
}
