import 'package:sqflite/sqflite.dart';

abstract class BaseSpecification<T> {
  T toResults(Database db);
}
