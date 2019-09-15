
import 'package:recipesbook/data/database.dart';

class RecipeFull{
  Recipes recipe;
  List<Steps> recipeSteps;

  RecipeFull(this.recipe, this.recipeSteps);
}