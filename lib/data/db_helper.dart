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
final String columnContent = 'content';
final String columnImage = 'image';
final String columnRecipeSteps = 'stepsrecipe';

class DatabaseProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
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
    });
  }

  Future<Recipes> insert(Recipes recipe) async {
    recipe.id = await db.insert(tableRecipes, recipe.toMap());
    return recipe;
  }

  Future<Recipes> getRecipes(int id) async {
    List<Map> maps = await db.query(tableRecipes,
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
    List<Map> maps = await db.query(tableSteps,
        columns: [columnId, columnContent, columnRecipeSteps, columnImage],
        where: '$columnRecipeSteps = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  Future<int> delete(int id) async {
    await db.delete(tableRecipes, where: '$columnId = ?', whereArgs: [id]);
    return await db
        .delete(tableSteps, where: '$columnRecipeSteps = ?', whereArgs: [id]);
  }

  Future<int> update(Recipes recipes) async {
    return await db.update(tableRecipes, recipes.toMap(),
        where: '$columnId = ?', whereArgs: [recipes.id]);
  }

  Future close() async => db.close();
}
