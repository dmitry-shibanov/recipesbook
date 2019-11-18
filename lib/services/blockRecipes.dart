import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:recipesbook/services/api.dart';

class RecipesBloc {
  final _recipesController = StreamController();

  static List<Recipes> _recipes = [];

  final recipeTransformer =
      StreamTransformer.fromHandlers(handleData: (item, sink) async {
    var recipe = Recipes.fromJson(item.data);
    recipe.documentId = item.documentID;
    recipe.path = item.data['steps'].path;
    final StorageReference ref =
        FirebaseStorage.instance.ref().child(item.data['image']);
    recipe.image = await ref.getDownloadURL();
    recipe.steps = await Api.getSteps(item.data['steps'].path);
    sink.add(recipe);
  });

  RecipesBloc() {
    _recipesController.stream
        .transform(recipeTransformer)
        .listen((recipe) => _recipes.add(recipe));
  }

  Stream get recipes => _recipesController.stream;

  Function get addRecipe => _recipesController.sink.add;

  set my_recipes(List<Recipes> recipes) => _recipes = recipes;

  List<Recipes> get my_recipes => _recipes;

  dispose() {
    _recipesController.close();
  }
}
