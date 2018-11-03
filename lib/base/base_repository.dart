import 'package:nice_animals_flutter/app_constants.dart';
import 'package:nice_animals_flutter/base/base_specification.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseRepository<T> {
  Future<R> query<R>(BaseSpecification<R> specification);

  Future<T> insert(T entity, {reload: true});

  Future update(T entity);

  Future delete(T entity);

  Future close();

  Future open();

  Future<List<T>> getAll();

  Future<String> getDbPath() async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, Constants.DB_NAME);
  }
}
