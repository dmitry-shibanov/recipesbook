import 'package:moor_flutter/moor_flutter.dart';

// part 'filename.g.dart'; 
// part 'moor_database.g.dart';
// part 'tables.g.dart';

@DataClassName("Recipes")
class Receipt extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 17)();
  TextColumn get content => text().named('body')();
  IntColumn get ingredients => integer().nullable()();
  IntColumn get steps => integer().nullable()();
}
