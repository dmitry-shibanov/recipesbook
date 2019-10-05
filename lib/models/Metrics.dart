import 'package:recipesbook/models/recipesData.dart';

class Metrics extends RecipeData{
    String name;

  Metrics.fromMap(Map<String, dynamic> map) {
    id = map['_id'];
    name = map['name'];
  }

  Metrics.fromJson(Map<String, dynamic> map) {
    name = map['name'];
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String,dynamic> map = new Map();
    name = map['name'];
    map['_id'] = id;

    return map;
  }

  @override
  Map<String, dynamic> toMapSave() {
    Map<String,dynamic> map = new Map();
    name = map['name'];

    return map;
  }
}