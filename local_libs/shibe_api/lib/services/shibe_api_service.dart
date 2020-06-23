import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/animal_picture.dart';

class ShibeApiService {
  String _describeType(AnimalType type) {
    switch (type) {
      case AnimalType.shibes:
        return 'shibes';
      case AnimalType.cats:
        return 'cats';
      case AnimalType.birds:
        return 'birds';
    }
  }

  Future<Iterable<AnimalPicture>> get(AnimalType type, {int quantity}) async {
    final response = await http.get(
        'https://shibe.online/api/${_describeType(type)}?count=${quantity ?? 10}');

    final jsonResponse = json.decode(response.body) as List<dynamic>;

    return jsonResponse.cast<String>().map((url) => AnimalPicture(url, type));
  }
}
