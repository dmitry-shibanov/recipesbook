import 'package:moor_flutter/moor_flutter.dart';

// part 'filename.g.dart'; 
// part 'moor_database.g.dart';

// part 'tables.g.dart';

@DataClassName("Users")
class User extends Table{
  TextColumn get email => text().nullable()();
  TextColumn get password => text().nullable()();
  TextColumn get token => text().nullable()();
}