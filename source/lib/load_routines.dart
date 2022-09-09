import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> fetchVehicles(String language) async {
  final response = await http
      .get(Uri.parse('https://raw.githubusercontent.com/AudioSystemGermany/pfct/main/vehicles_${language}.csv'));
  if (response.statusCode == 200) {
    return response.body.toString();
  } else {
    return 'error';
  }
}

Future<String> fetchProducts(String language) async {
  final response = await http
      .get(Uri.parse('https://raw.githubusercontent.com/AudioSystemGermany/pfct/main/products_${language}.csv'));
  if (response.statusCode == 200) {
    return response.body.toString();
  } else {
    return 'error';
  }
}

Future<String> fetchSeries(String language) async {
  final response = await http
      .get(Uri.parse('https://raw.githubusercontent.com/AudioSystemGermany/pfct/main/series_${language}.csv'));
  if (response.statusCode == 200) {
    return response.body.toString();
  } else {
    return 'error';
  }
}

Future<String> fetchConfig() async {
  final response = await http
      .get(Uri.parse('https://raw.githubusercontent.com/AudioSystemGermany/pfct/main/config.csv'));
  if (response.statusCode == 200) {
    return response.body.toString();
  } else {
    return 'error';
  }
}