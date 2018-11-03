import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';

class ShibeService {
  static Future<List<NicePicture>> get(AnimalType type, {int quantity}) async {
    var response = await http.get(
        'https://shibe.online/api/${describeEnum(type)}?count=${quantity ?? 10}');

    Iterable jsonResponse = json.decode(response.body);

    return List<String>.from(jsonResponse)
        .map((url) => NicePicture(url, type))
        .toList();
  }
}
