import 'package:crypto_wallet/net/api_functions.dart';
import 'package:crypto_wallet/net/flutter_fire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'add_view.dart';
import 'custom_text_widget.dart';

class Homeview extends StatefulWidget {
  const Homeview({Key? key}) : super(key: key);

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    getCoinPriceFromApi();
    super.initState();
  }

  getCoinPriceFromApi() async {
    bitcoin = await getPriceFromApi("bitcoin");
    ethereum = await getPriceFromApi("ethereum");
    tether = await getPriceFromApi("tether");
    setState(() {}); // to update values on the ui
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "ethereum") {
        return ethereum * amount;
      } else {
        return tether * amount;
      }
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final documents = snapshot.data?.docs;
                List<CustomTextWidget> customTextList = [];
                for (var doc in documents!) {
                  final data = doc.data() as Map<String, dynamic>;

                  if (data == null) {
                    throw 'cannot fetch data';
                  }
                  Map<String, dynamic> dataMap = {
                    'id': doc.id,
                    'Amount': getValue(doc.id, data['Amount'])
                  };

                  final customTextWidget = CustomTextWidget(
                      docId: dataMap['id'], docAmount: dataMap['Amount']);
                  customTextList.add(customTextWidget);
                }

                return ListView(
                  children: customTextList,
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddView(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
