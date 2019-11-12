import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipesbook/models/Ingredients.dart';
import 'package:recipesbook/models/steps.dart';
import 'package:recipesbook/models/webData.dart';

class Recipes extends WebData {
  String content;
  String title;
  String image="";
  List<Ingredients> ingredients;
  List<Steps> steps;
  String _path;
  String _dataTime;
  String _pathImage;

  // String get date => _dateTime.

  String get pathImage => _pathImage;

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
    map['date'] = _dataTime ?? "";

    return map;
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
    _pathImage = map['image'];
    // final StorageReference ref =
    //     FirebaseStorage.instance.ref().child(map['image']);

    // Stream stream = Stream.fromFuture(ref.getDownloadURL());
    // stream.listen((data) {
    //   image = data;
    // }, onDone: () {
    //   print("Task Done");
    // }, onError: (error) {
    //   print("Some Error");
    // });

    ingredients = (map['ingredients'] as List)
        .asMap()
        .map((index, item) {
          print('dasdas');
          var ingredient = new Ingredients.fromJson(item);
          // var ingredient = new Ingredients();
          // ingredient.title = item["ingredient"];
          // ingredient.metric = item["metric"];
          // ingredient.count = item["count"];
          return MapEntry(index, ingredient);
        })
        .values
        .toList();
  }
}
