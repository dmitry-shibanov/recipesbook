import 'package:recipesbook/models/Ingredients.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:recipesbook/models/steps.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String tableRecipes = 'recipes';
final String tableSteps = 'steps';
final String tableIngredients = 'ingredients';
final String tableUser = 'user';
final String tableRecipeIngredient = 'recipeingredient';

final String columnId = '_id';
final String columnTitle = 'title';
final String columnContent = 'content';
final String columnImage = 'image';
final String columnRecipeSteps = 'stepsrecipe';
final String columnRecipe = "recipe";
final String columnIngredient = "ingredient";

class DatabaseProvider {
  Database _db;
  static final DatabaseProvider _provider = DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _provider;
  }

  DatabaseProvider._internal();

  Future open(String path) async {
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableRecipes ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnContent text not null,
  $columnImage text not null)
''');

      await db.execute('''
create table $tableSteps ( 
  $columnId integer primary key autoincrement, 
  $columnContent text not null,
  $columnImage text not null,
    $columnRecipeSteps integer not null)
''');

      await db.execute('''
create table $tableIngredients ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null)
''');
      await db.execute('''
      create table $tableRecipeIngredient (
        $columnId integer primary key autoincrement,
        $
      )
      ''');
    });
  }

  Future<void> insertIngredients(List<Ingredients> ingredients) async {
    ingredients.forEach((item) async =>await _db.insert(tableIngredients, item.toMapSave()));
    
    // await _db.rawInsert(
    //     tableIngredients,
    //     ingredients
    //         .asMap()
    //         .map((index, item) => MapEntry(index, item.toMapSave()))
    //         .values
    //         .toList());
  }

  Future<Recipes> insert(Recipes recipe) async {
    recipe.id = await _db.insert(tableRecipes, recipe.toMap());
    await _insertSteps(recipe.steps, recipe.id);
    return recipe;
  }

  Future<void> _insertSteps(List<Steps> steps, int id) async {
    await _db.rawInsert(
        tableSteps,
        steps
            .asMap()
            .map((index, item) {
              return MapEntry(index, item.toMap());
            })
            .values
            .toList());
  }

  Future<Recipes> getRecipe(int id) async {
    List<Map> maps = await _db.query(tableRecipes,
        columns: [columnId, columnContent, columnTitle, columnImage],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      Recipes recipe = Recipes.fromMap(maps.first);
      List<Steps> steps = new List();
      List<Map<String, dynamic>> stepsMap = await getSteps(id);
      stepsMap.forEach((item) => steps.add(Steps.fromMap(item)));
      recipe.steps = steps;
      return recipe;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getSteps(int id) async {
    List<Map> maps = await _db.query(tableSteps,
        columns: [columnId, columnContent, columnRecipeSteps, columnImage],
        where: '$columnRecipeSteps = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getIngredients() async {
    List<Map<String, dynamic>> maps = await _db.query(tableIngredients);
    if (maps.length > 0) {
      return maps;
    }
    return [];
  }

  Future<int> delete(int id) async {
    await _db.delete(tableRecipes, where: '$columnId = ?', whereArgs: [id]);
    return await _db
        .delete(tableSteps, where: '$columnRecipeSteps = ?', whereArgs: [id]);
  }

  Future<int> update(Recipes recipes) async {
    return await _db.update(tableRecipes, recipes.toMap(),
        where: '$columnId = ?', whereArgs: [recipes.id]);
  }

  Future close() async => _db.close();
}
