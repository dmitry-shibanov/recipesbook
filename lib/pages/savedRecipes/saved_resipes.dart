import 'package:flutter/material.dart';
import 'package:recipesbook/components/ProductCart.dart';
import 'package:recipesbook/data/db_helper.dart';
import 'package:recipesbook/models/recipes.dart';

class SavedRecipes extends StatelessWidget {

  Future<List<Recipes>> getAllRecipes() async {
    var provider = DatabaseProvider();
    var allRecipes = provider.getAllRecipes();
    return allRecipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сохранненые рецепты'),
      ),
      body: FutureBuilder(
        future: getAllRecipes(),
        builder: (context, snpashot) {
          if (snpashot.hasData) {
            List<Recipes> recipes = (snpashot.data as List<Recipes>);
            return ListView.builder(
              itemBuilder: (contex, index) => ProductCard(recipes[index]),
              itemCount: recipes.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
