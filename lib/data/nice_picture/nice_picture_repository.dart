import 'package:nice_animals_flutter/base/base_repository.dart';
import 'package:nice_animals_flutter/base/base_specification.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';
import 'package:sqflite/sqflite.dart';

const String NICE_PICTURE_TABLE = 'NicePicture';
const String NICE_PICTURE_URL = "picture_url";

class NicePictureRepository extends BaseRepository<NicePicture> {
  Database db;

  @override
  Future<List<NicePicture>> getAll() async {
    var list = await db.query(NICE_PICTURE_TABLE);
    return list.map((map) => NicePicture(map[NICE_PICTURE_URL]));
  }

  @override
  Future<R> query<R>(BaseSpecification<R> specification) async {
    return specification.toResults(db);
  }

  @override
  Future<NicePicture> insert(NicePicture entity, {reload: true}) async {
    await db.insert(NICE_PICTURE_TABLE, {NICE_PICTURE_URL: entity.url});
    return entity;
  }

  @override
  Future update(NicePicture entity) async {
    await db.update(NICE_PICTURE_TABLE, {NICE_PICTURE_URL: entity.url});
  }

  @override
  Future delete(NicePicture entity) async {
    await db.delete(NICE_PICTURE_TABLE,
        where: '$NICE_PICTURE_URL = ?', whereArgs: [entity.url]);
  }

  @override
  Future close() async {
    db.close();
  }

  @override
  Future open() async {
    var path = await getDatabasesPath();
    db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $NICE_PICTURE_TABLE ( 
        $NICE_PICTURE_URL TEXT PRIMARY KEY NOT NULL
      )
    ''');
  }
}
