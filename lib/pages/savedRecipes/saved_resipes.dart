import 'package:flutter/material.dart';
import 'package:recipesbook/pages/savedRecipes/savedRecipeItem/saved_item.dart';

class SavedRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Сохранненые рецепты'),
      ),
      body: ListView.builder(
        itemBuilder: (contex, index) => SavedRecipeItem(),
        itemCount: 21,
      ),
    );
  }
}
