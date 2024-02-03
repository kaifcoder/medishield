import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medishield/data/repositories/authentication_repository.dart';

class THttpHelper {
  static const String _baseUrl =
      'http://192.168.29.134:5000'; // Replace with your API base URL

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final token =
        await AuthenticationRepository.instance.deviceStorage.read('token');
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
    );
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final token =
        await AuthenticationRepository.instance.deviceStorage.read('token');
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(
      String endpoint, dynamic data, String token) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final token =
        await AuthenticationRepository.instance.deviceStorage.read('token');
    final response = await http.delete(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
    );
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('${json.decode(response.body)['message']}');
    }
  }
}
