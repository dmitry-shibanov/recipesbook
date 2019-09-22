import 'package:flutter/material.dart';
import 'package:recipesbook/pages/savedRecipes/savedRecipeItem/saved_item.dart';

class SavedRecipes extends StatelessWidget {
  // Recipes receipt = new Recipes(content: 'sklaklsalksa',title: 'try create');

  // Future<List<Recipes>> getAllRecipes() async {
  //   var allRecipes = _db.allRecipes;

  //   return allRecipes;
  // }

  // SavedRecipes() {
  //   getAllRecipes().then((recipes) {
  //     all = recipes;
  //     _db.watchCart(all[all.length - 1].id).then((onValue) => steps = onValue);
  //     print((steps.length));
  //     print(all.length);
  //     print(all[0].title);
  //     print(steps[0].image);
  //   });
  // }

  // SavedRecipes(this.all,this.steps);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сохранненые рецепты'),
      ),
      // body: ListView.builder(
      //   itemBuilder: (contex, index) =>
      //       SavedRecipeItem(steps[0].image, all[index].title),
      //   itemCount: all.length,
      // ),
    );
  }
}
