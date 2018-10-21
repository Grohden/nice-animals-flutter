import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum AnimalType { shibes, cats, birds }

class ShibeService {
  static Future<List<String>> get(AnimalType type, {int quantity}) async {
    var response = await http.get(
        'https://shibe.online/api/${describeEnum(type)}?count=${quantity ?? 10}');

    var jsonResponse = json.decode(response.body);

    return List<String>.from(jsonResponse);
  }
}
