import 'package:flutter/material.dart';

import '../net/flutter_fire.dart';

class CustomTextWidget extends StatelessWidget {
  final String docId;
  final double docAmount;
  CustomTextWidget({required this.docId, required this.docAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: MediaQuery.of(context).size.height / 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                docId,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Text(
              "₹ $docAmount",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            IconButton(
              onPressed: () async {
                await deleteCoins(docId);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
