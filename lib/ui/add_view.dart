import 'package:crypto_wallet/net/flutter_fire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = ['bitcoin', 'tether', 'ethereum'];
  String dropdownValue = 'bitcoin';

  final TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: coins.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Coin Amount'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.7,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(15),
                  child: MaterialButton(
                    onPressed: () async {
                      await addCoin(dropdownValue, _amountController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
