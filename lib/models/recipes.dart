import 'package:recipesbook/models/Ingredients.dart';
import 'package:recipesbook/models/steps.dart';
import 'package:recipesbook/models/webData.dart';

class Recipes extends WebData {
  String content;
  String title;
  String image;
  List<Ingredients> ingredients;
  List<Steps> steps;
  String _path;
  DateTime _dateTime;

  // String get date => _dateTime.

  String get path => _path;
  void set path(String my_path) {
    _path = my_path;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();

    map['content'] = content;
    map['title'] = title;
    map['image'] = image;
    map['_id'] = super.id;

    return map;
  }

  Map<String, dynamic> toMapSave() {
    Map<String, dynamic> map = new Map();

    map['content'] = content;
    map['title'] = title;
    map['image'] = image;
    map['documentId'] = documentId;
  }

  Recipes();

  Recipes.fromMap(Map<String, dynamic> map) {
    content = map['content'];
    documentId = map['documentId'];
    title = map['title'];
    image = map['image'];
    id = int.parse(map['_id']);
  }

  Recipes.fromJson(Map<String, dynamic> map) {
    content = map['content'];
    title = map['title'];
    image = map['image'];
    ingredients = (map['ingredients'] as List).asMap().map((index,item){
      print('dasdas');
      var ingredient = new Ingredients.fromJson(item as Map<String,dynamic>);
      // var ingredient = new Ingredients();
      // ingredient.title = item["ingredient"];
      // ingredient.metric = item["metric"];
      // ingredient.count = item["count"];
      return MapEntry(index, ingredient);
    }).values.toList();
  }
}
