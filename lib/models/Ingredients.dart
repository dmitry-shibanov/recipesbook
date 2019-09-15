import 'package:moor_flutter/moor_flutter.dart';

// part 'filename.g.dart'; 
// part 'moor_database.g.dart';
// part 'tables.g.dart';

@DataClassName("Ingredients")
class Ingredient extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ingredient => text()();
}