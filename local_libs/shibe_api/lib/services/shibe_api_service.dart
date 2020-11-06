import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/animal_picture.dart';

class ShibeApiService {
  ShibeApiService(this.dio);

  Dio dio;

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
    final response = await dio.get<String>(
      'https://shibe.online/api/${_describeType(type)}?count=${quantity ?? 10}',
    );

    final jsonResponse = json.decode(response.data) as List<dynamic>;

    return jsonResponse.cast<String>().map((url) => AnimalPicture(url, type));
  }
}
