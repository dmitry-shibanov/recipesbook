import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipesbook/components/ProductCart.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:recipesbook/services/provider.dart';

class ProductsList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ProductsListState();
  }
}

class ProductsListState extends State {
  // ProductsListState(this._tabController);
  ScrollController _controllerCommon;
  ScrollController _controllerLiked;
  final StreamController _streamController = StreamController();

  List<Recipes> recipes = [];
  @override
  void initState() {
    super.initState();
    _controllerCommon = ScrollController();
    _controllerCommon.addListener(_scrollListController);
  }

  void _scrollListController(){
      if(_controllerCommon.offset >= _controllerCommon.position.maxScrollExtent && !_controllerCommon.position.outOfRange){
      //  setState(() {
      //     // load data;
      //   }); 
      // _streamController.sink.addStream(stream)
      // _streamController.sink.add()
      }

      if(_controllerCommon.offset <= _controllerCommon.position.minScrollExtent && !_controllerCommon.position.outOfRange){
        setState(() {
          // load data; reach top
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    recipes = Provider.of(context).my_recipes;
    return  TabBarView(
            // controller: _tabController,
            children: <Widget>[
              // StreamBuilder(key: new Key("All recipes"),builder: (context,snapshot){

              // },stream: ,)
              ListView.builder(
                controller: _controllerCommon,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: ProductCard(recipes[index]),
                    onTap: () => {

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
    // return StreamBuilder(
    //   stream: Firestore.instance.collection('recipes').snapshots(),
    //   builder: (context,snapshot){
    //     if(!snapshot.hasData){
    //       return Center(child: CircularProgressIndicator());
    //     }else{
    //       List<Future<Recipes>> recipes = (snapshot.data.documents as Iterable).map((item) async {
    //         var recipe = new Recipes.fromMap(item);

    //         recipe.steps = await Api.getSteps(item['steps'].path);
    //         recipe.documentId = item.documentID;
    //         return recipe;
    //       }).toList();

    //     }
    //   },
    // );
  }
}
