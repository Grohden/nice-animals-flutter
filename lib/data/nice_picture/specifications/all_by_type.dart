import 'package:flutter/foundation.dart';
import 'package:nice_animals_flutter/base/base_specification.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture_repository.dart';
import 'package:sqflite/sqflite.dart';

class AllByType extends BaseSpecification<List<NicePicture>> {
  AnimalType type;

  AllByType(AnimalType type) {
    this.type = type;
  }

  @override
  Future<List<NicePicture>> toResults(Database db) async {
    var results = await db.query(NicePictureRepository.tableAnimalPicture,
        where: '${NicePictureRepository.columnType} = ?',
        whereArgs: [describeEnum(type)]);

    return results.map((it) => NicePictureRepository.mapToEntity(it)).toList();
  }
}
