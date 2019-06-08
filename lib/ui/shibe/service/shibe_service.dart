import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';

class ShibeService {
  static Future<List<NicePicture>> get(AnimalType type, {int quantity}) async {
    final response = await http.get(
        'https://shibe.online/api/${describeEnum(type)}?count=${quantity ?? 10}');

    // ignore: avoid_as
    final jsonResponse = json.decode(response.body) as List<dynamic>;

    return jsonResponse
        .cast<String>()
        .map((url) => NicePicture(url, type))
        .toList();
  }
}
