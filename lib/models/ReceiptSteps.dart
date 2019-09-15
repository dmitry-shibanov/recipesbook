import 'package:moor_flutter/moor_flutter.dart';

// part 'filename.g.dart'; 
// part 'moor_database.g.dart';
// part 'tables.g.dart';

@DataClassName("Steps")
class ReceiptSteps extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  TextColumn get image => text()();
  IntColumn get recipe_asoc => integer()();
  
}
