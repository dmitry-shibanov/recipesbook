import 'package:recipesbook/models/recipesData.dart';

class RecipeIngredient extends RecipeData {
  int _recipeId;
  int _ingredientId;
  int _recipeMetric;
  String _count;

  RecipeIngredient.fromMap(Map<String, dynamic> map) {
    id = map['_id'];
    _ingredientId = map['ingredient'];
    _recipeId = map['recipe'];
    _recipeMetric = map['metric'];
    _count = map['count'];
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String,dynamic> map = new Map();
    map['ingredient'] = _ingredientId;
    map['recipe'] = _recipeId;
    map['metric'] = _recipeMetric;
    map['count'] = _count;
    map['_id'] = id;

    return map;
  }

  @override
  Map<String, dynamic> toMapSave() {
    Map<String,dynamic> map = new Map();
    map['ingredient'] = _ingredientId;
    map['recipe'] = _recipeId;
    map['metric'] = _recipeMetric;
    map['count'] = _count;
    return map;
  }
}
