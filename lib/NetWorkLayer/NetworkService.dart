import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

abstract class NetworkLayer {
  Future<T> request<T>(
      Uri url, T Function(dynamic) fromJson, {Map<String, String>? headers});
}

class DBNetworkLayer extends NetworkLayer {
  @override
  Future<T> request<T>(
      Uri url, T Function(dynamic) fromJson, {Map<String, String>? headers}) async {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      _logPrettyPrintedJSON(jsonData);
      return fromJson(jsonData);
    } else {
      print("what the fuck");
      throw Exception('Failed to load data');
    }
  }

  void _logPrettyPrintedJSON(dynamic jsonData) {
    final encoder = JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(jsonData);
    print('Response Data (Pretty-Printed JSON):\n$prettyString');
  }
}
