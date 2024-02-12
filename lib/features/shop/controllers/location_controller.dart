import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:medishield/data/country_to_currency.dart';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  static LocationController get instance => Get.find();
  Position? userposition;
  late bool servicePermission = false;
  late LocationPermission permission;
  Placemark currentPlace = Placemark();
  String currencyCode = "";
  double rate = 0;
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    userposition = position;
    await _getAddressFromLatLng();
    await currency();
    await convertCurrency("INR", currencyCode, 1);
    debugPrint("CURRENCY CODE $currencyCode");
    debugPrint("COUNTRY NAME ${currentPlace.country}");
    debugPrint("Postal code ${currentPlace.postalCode}");
    debugPrint("RATE $rate");
  }

  Future<int> convertCurrency(String from, String to, int amount) async {
    if (from == to) {
      rate = amount.toDouble();
      return amount;
    }
    var url = Uri.parse(
        'https://currency-conversion-and-exchange-rates.p.rapidapi.com/convert');
    var headers = {
      'X-RapidAPI-Key': ' 782f442b41msh8383ee5761cbc6ap10e0f9jsn210af840c813',
      'X-RapidAPI-Host': 'currency-conversion-and-exchange-rates.p.rapidapi.com'
    };

    debugPrint('Converting $amount $from to $to');
    var params = {'from': 'INR', 'to': to, 'amount': amount.toString()};

    var response =
        await http.get(url.replace(queryParameters: params), headers: headers);

    if (response.statusCode == 200) {
      // Parse response body
      var responseBody = json.decode(response.body);
      double result = responseBody['result'];
      debugPrint('Converted $amount $from to $to: $result');
      // Round the result to one decimal place

      // Convert the rounded result to a string
      rate = double.parse(result.toStringAsFixed(2));
      return result.toInt();
    } else {
      throw Exception('Failed to convert currency: ${response.reasonPhrase}');
    }
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> place = await placemarkFromCoordinates(
          userposition!.latitude, userposition!.longitude);
      currentPlace = place[0];
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future currency() async {
    final currencydata = CurrencyData.getCurrencyList();
    // get currency code
    print("COUNTRY NAME ${currentPlace.country!.toUpperCase()}");
    currencyCode =
        await currencydata["ISO_4217"]["CcyTbl"]["CcyNtry"].firstWhere(
      (element) => element["CtryNm"] == currentPlace.country!.toUpperCase(),
      orElse: () => {"Ccy": "INR"},
    )["Ccy"];
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await _geolocatorPlatform.requestPermission();
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        _updatePositionList(_kPermissionDeniedMessage);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _updatePositionList(
        _kPermissionDeniedForeverMessage,
      );

      return false;
    }

    _updatePositionList(
      _kPermissionGrantedMessage,
    );
    return true;
  }

  void _updatePositionList(String displayValue) {
    debugPrint(displayValue);
  }
}
