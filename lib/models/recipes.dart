import 'package:recipesbook/models/steps.dart';

class Recipes {
  String content;
  String title;
  int id;
  String image;
  String documentId;
  List<Steps> steps;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();

    map['content'] = content;
    map['title'] = title;
    map['image'] = image;

    return map;
  }

  Recipes();

  Recipes.fromMap(Map<String, dynamic> map) {
    content = map['content'];
    title = map['title'];
    image = map['image'];
    // id = int.parse(map['id']);
  }
}
