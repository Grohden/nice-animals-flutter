import 'package:flutter/foundation.dart';
import 'package:nice_animals_flutter/base/base_repository.dart';
import 'package:nice_animals_flutter/base/base_specification.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';
import 'package:sqflite/sqflite.dart';

class NicePictureRepository extends BaseRepository<NicePicture> {
  static const String tableAnimalPicture = 'NicePicture';
  static const String columnPictureURL = "picture_url";
  static const String columnType = "animal_type";

  Database db;

  static Map<String, dynamic> entityToMap(NicePicture picture) {
    return {
      columnPictureURL: picture.url,
      columnType: describeEnum(picture.type)
    };
  }

  static NicePicture mapToEntity(Map<String, dynamic> map) {
    var type = map[columnType];
    return NicePicture(map[columnPictureURL] as String,
        AnimalType.values.firstWhere((it) => describeEnum(it) == type));
  }

  @override
  Future<List<NicePicture>> getAll() async {
    var list = await db.query(tableAnimalPicture);
    return list.map((map) => mapToEntity(map)).toList();
  }

  @override
  Future<R> query<R>(BaseSpecification<R> specification) async {
    return specification.toResults(db);
  }

  @override
  Future<NicePicture> insert(NicePicture entity, {reload: true}) async {
    await db.insert(tableAnimalPicture, entityToMap(entity));
    return entity;
  }

  @override
  Future<NicePicture> insertOrUpdate(NicePicture entity, {reload: true}) async {
    await db.insert(tableAnimalPicture, entityToMap(entity),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return entity;
  }

  @override
  Future insertAll(List<NicePicture> entities) async {
    var transactions = entities.map((entity) => insert(entity));
    await Future.wait(transactions);
  }

  @override
  Future insertOrUpdateAll(List<NicePicture> entities) async {
    var transactions = entities.map((entity) => insertOrUpdate(entity));
    await Future.wait(transactions);
  }

  @override
  Future update(NicePicture entity) async {
    await db.update(tableAnimalPicture, entityToMap(entity));
  }

  @override
  Future delete(NicePicture entity) async {
    await db.delete(tableAnimalPicture,
        where: '$columnPictureURL = ?', whereArgs: [entity.url]);
  }

  @override
  Future close() async {
    db.close();
  }

  @override
  Future open() async {
    var path = await getAppDBPath();
    db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableAnimalPicture ( 
        $columnPictureURL TEXT PRIMARY KEY NOT NULL,
        $columnType TEXT NOT NULL
      )
    ''');
  }
}
