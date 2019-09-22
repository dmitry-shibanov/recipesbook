import 'package:flutter/material.dart';
import 'package:recipesbook/components/ProductCart.dart';
import 'package:recipesbook/models/recipes.dart';
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
  void initState() async {
    
    super.initState();
    recipes = await Api.getRecipes();
    if(recipes.length>0){
      setState(() {
       _isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator()) : TabBarView(
      // controller: _tabController,
        children: <Widget>[
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(recipes[index]);
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
