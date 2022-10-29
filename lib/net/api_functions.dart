import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

Future<double> getPriceFromApi(String id) async {
  try {
    var url = "https://api.coingecko.com/api/v3/coins/$id";
    var response = await http.get(
      Uri.parse(url),
    );
    var json = jsonDecode(response
        .body); // take the response object, get the body element from it and format it in json format
    var value = json['market_data']['current_price']['inr'].toString();
    return double.parse(value);
  } catch (e) {
    log(e.toString());
    return 0.0;
  }
}
