import 'package:recipesbook/data/save_image.dart';
import 'package:recipesbook/models/Ingredients.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:recipesbook/models/steps.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String tableRecipes = 'recipes';
final String tableSteps = 'steps';
final String tableIngredients = 'ingredients';
final String tableUser = 'user';

final String columnId = '_id';
final String columnTitle = 'title';
final String ingredientCount = "count";
final String columnName = "name";
final String columnDate = "date";
final String columnMetric = "metric";
final String columnContent = 'content';
final String columnImage = 'image';
final String columnRecipeSteps = 'stepsrecipe';
final String columnRecipeIngredient = "recipeingredient";
final String columnRecipe = "recipe";
final String columnIngredient = "ingredient";
final String columnDocumentId = "documentId";

class DatabaseProvider {
  Database _db;
  static final DatabaseProvider _provider = DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _provider;
  }

  DatabaseProvider._internal();

  Future open(String path) async {
    _db = await openDatabase(path, version: 4,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableRecipes ( 
  $columnId integer primary key autoincrement,
  $columnDocumentId text, 
  $columnTitle text not null,
  $columnContent text not null,
  $columnDate text,
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
  $columnTitle text not null,
  $columnMetric text not null,
  $ingredientCount text not null,
  $columnRecipeIngredient text not null
  )
''');
    });
  }

  Future<void> insertIngredients(List<Ingredients> ingredients) async {
    ingredients.forEach(
        (item) async => await _db.insert(tableIngredients, item.toMapSave()));
  }

  Future<Recipes> insert(Recipes recipe) async {
    var saveFileInstance = SaveFile();
    List<String> results =
        await saveFileInstance.saveImageNetwork(recipe.pathImage, "p0");
    recipe.image = results[0];
    String path = results[1];
    int id = await _db.insert(tableRecipes, recipe.toMapSave());
    // saveFileInstance.saveImageNetwork(recipe.image,"p0");
    await _insertIngredients(recipe.ingredients, id);
    await _insertSteps(recipe.steps, path, id);
    return recipe;
  }

  Future<void> _insertSteps(List<Steps> steps, String path, int id) async {
    steps.asMap().forEach((index, item) async {
      var saveFileInstance = SaveFile();
      item.stepsrecipe = id.toString();
      item.image = await saveFileInstance.saveImageSteps(
          item.pathImage, path, "p${index + 1}");
      item.id = await _db.insert(tableSteps, item.toMapSave());
    });
  }

  Future<void> _insertIngredients(List<Ingredients> ingredients, int id) {
    ingredients.forEach((item) async {
      item.recipeingredient = id.toString();
      item.id = await _db.insert(tableSteps, item.toMapSave());
    });
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

  Future<List<Recipes>> getAllRecipes() async {
    List<Recipes> recipes = (await _db.query(tableRecipes)).map((item) {
      Recipes recipe = Recipes.fromMap(item);
      return recipe;
    }).toList();

    return recipes;
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
