import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:medishield/data/country_to_currency.dart';

class LocationController extends GetxController {
  static LocationController get instance => Get.find();
  Position? userposition;
  late bool servicePermission = false;
  late LocationPermission permission;
  Placemark currentPlace = Placemark();
  String currencyCode = "";
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
    debugPrint("CURRENCY CODE $currencyCode");
    debugPrint("COUNTRY NAME ${currentPlace.country}");
    debugPrint("Postal code ${currentPlace.postalCode}");
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
