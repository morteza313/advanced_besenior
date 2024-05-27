import 'dart:async';
import 'package:advanced_besenior/features/fearture_bookmark/data/dataSource/local/city_dao.dart';
import 'package:advanced_besenior/features/fearture_bookmark/domain/entities/city_entity.dart';
import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [City])
abstract class AppDatabase extends FloorDatabase {
  CityDao get cityDao;
}
