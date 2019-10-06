import 'package:recipesbook/models/steps.dart';
import 'package:recipesbook/models/webData.dart';

class Recipes extends WebData {
  String content;
  String title;
  String image;
  List<String> ingredients;
  List<Steps> steps;
  String _path;

  String get path => _path;
  void set path(String my_path){
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

  Map<String, dynamic> toMapSave(){
    Map<String, dynamic> map = new Map();

    map['content'] = content;
    map['title'] = title;
    map['image'] = image;
    map['documentId'] = documentId;
  }

  Recipes();

  Recipes.fromMap(Map<String, dynamic> map) {
    content = map['content'];
    title = map['title'];
    image = map['image'];
    id = int.parse(map['_id']);
  }

  Recipes.fromJson(Map<String, dynamic> map) {
    content = map['content'];
    title = map['title'];
    image = map['image'];
  }
}
