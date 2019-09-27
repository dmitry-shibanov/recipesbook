import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipesbook/components/ProductCart.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:recipesbook/pages/ReceiptDescription.dart';
import 'package:recipesbook/services/api.dart';

class ProductsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductsListState();
  }
}

class ProductsListState extends State {
  // ProductsListState(this._tabController);
  var _isLoading = true;
  List<Recipes> recipes = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    List<DocumentSnapshot> docs =
        (await Firestore.instance.collection('recipes').getDocuments())
            .documents;

    // recipes = await Api.getRecipes();
    var recipe = new Recipes.fromMap(docs[0].data);
    recipe.documentId = docs[0].documentID;
    recipe.steps = await Api.getSteps(docs[0].data['steps'].path);
    recipes.add(recipe);
    if (recipes.length > 0) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : TabBarView(
            // controller: _tabController,
            children: <Widget>[
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: ProductCard(recipes[index]),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ProductDescription.withRecipe(
                            index,
                            recipes[index],
                          );
                        }),
                      )
                    },
                  );
                },
                itemCount: recipes.length,
              ),
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(recipes[index]);
                },
                itemCount: recipes.length,
              )
            ],
          );
  }
}
