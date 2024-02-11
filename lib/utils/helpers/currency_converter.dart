import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CurrencyConverter {
  static Future<int> convertCurrency(
      String from, String to, String amount) async {
    if (from == to) {
      return int.parse(amount);
    }
    var url = Uri.parse(
        'https://currency-conversion-and-exchange-rates.p.rapidapi.com/convert');
    var headers = {
      'X-RapidAPI-Key': ' 782f442b41msh8383ee5761cbc6ap10e0f9jsn210af840c813',
      'X-RapidAPI-Host': 'currency-conversion-and-exchange-rates.p.rapidapi.com'
    };

    debugPrint('Converting $amount $from to $to');
    var params = {'from': 'INR', 'to': to, 'amount': '1'};

    var response =
        await http.get(url.replace(queryParameters: params), headers: headers);

    if (response.statusCode == 200) {
      // Parse response body
      var responseBody = json.decode(response.body);
      print(responseBody);
      // Get the result
      var result = responseBody['result'];
      // Round the result to one decimal place
      result = double.parse(result).round();
      // Convert the rounded result to a string
      return result.toInt();
    } else {
      throw Exception('Failed to convert currency: ${response.reasonPhrase}');
    }
  }
}
