import 'dart:io';

import 'package:nice_animals_flutter/app_constants.dart';
import 'package:nice_animals_flutter/base/base_specification.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseRepository<T> {
  Future<R> query<R>(BaseSpecification<R> specification);

  Future<T> insert(T entity, {reload: true});

  Future insertAll(List<T> entities);

  Future<T> insertOrUpdate(T entity);

  Future insertOrUpdateAll(List<T> entities);

  Future update(T entity);

  Future delete(T entity);

  Future close();

  Future open();

  Future<List<T>> getAll();

  Future<String> getAppDBPath() async {
    var databasesPath = await getDatabasesPath();
    // Make sure the directory exists
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    return join(databasesPath, Constants.databaseName);
  }
}
