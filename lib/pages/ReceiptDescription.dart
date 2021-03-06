import 'package:flutter/material.dart';
import 'package:recipesbook/data/db_helper.dart';
import 'dart:math' as math;

import 'package:recipesbook/models/recipes.dart';
import 'package:recipesbook/services/api.dart';

class ProductDescription extends StatefulWidget {
  Recipes recipe;

  ProductDescription(this.recipe);

  ProductDescription.fromDb(int id) {
    var provider = new DatabaseProvider();
  }

  final PageController Page_controller = PageController(initialPage: 0);
  var currentPageValue = 0.0;

  @override
  State<StatefulWidget> createState() {
    return ProductDescriptionState();
  }
}

class ProductDescriptionState extends State<ProductDescription>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  Widget subTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Api.getSteps(widget.recipe.path),
        builder: (context, projectSnap) {
          if (!projectSnap.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            widget.recipe.steps = projectSnap.data;
            return CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 256,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.recipe.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  background: Hero(
                    tag: widget.recipe.documentId,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('public/food.jpg'),
                      image: NetworkImage(widget.recipe.image),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  subTitle('Описание'),
                  Container(
                    margin: EdgeInsets.all(16.0),
                    child: Text(widget.recipe == null
                        ? 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure officia hic blanditiis voluptates pariatur atque, id, in eos laudantium natus nihil obcaecati deleniti possimus voluptate, quia necessitatibus? Obcaecati, laboriosam ratione!'
                        : widget.recipe.content),
                  ),
                  subTitle('Ингедиенты'),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                    itemBuilder: _buildIngredients,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    itemCount: widget.recipe.ingredients.length,
                    shrinkWrap: true,
                  ),),
                  subTitle('Шаги'),
                  // Text(
                  //   'Шаги',
                  //   style:
                  //       TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: PageView.builder(
                      itemBuilder: _stepReceipt,
                      itemCount: widget.recipe.steps.length,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                  )
                ]),
              )
            ]);
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
                scale: CurvedAnimation(
                    curve: Interval(0.0, 1.0, curve: Curves.easeOut),
                    parent: controller),
                child: FloatingActionButton(
                  heroTag: 'favorite',
                  mini: true,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () => null,
                )),
          ),
          Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                  parent: controller,
                  curve: Interval(0.0, 1.0, curve: Curves.easeOut)),
              child: FloatingActionButton(
                heroTag: 'save_recipe',
                mini: true,
                backgroundColor: Theme.of(context).cardColor,
                child: Icon(
                  Icons.save,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  DatabaseProvider provider = new DatabaseProvider();
                  provider.insert(widget.recipe);
                },
              ),
            ),
          ),
          Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: FloatingActionButton(
                heroTag: 'more_vert',
                child: AnimatedBuilder(
                  builder: (BuildContext context, Widget child) {
                    return Transform(
                      alignment: FractionalOffset.center,
                      transform:
                          Matrix4.rotationZ(controller.value * 0.5 * math.pi),
                      child: Icon(controller.isDismissed
                          ? Icons.more_vert
                          : Icons.close),
                    );
                  },
                  animation: controller,
                ),
                onPressed: () {
                  if (controller.isDismissed) {
                    controller.forward();
                  } else {
                    controller.reverse();
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget _buildIngredients(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              "${widget.recipe.ingredients[index].count} ${widget.recipe.ingredients[index].metric}",
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              widget.recipe.ingredients[index].title,
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }

  Widget _stepReceipt(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(widget.recipe.steps[index].image),
            placeholder: AssetImage('public/food.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(widget.recipe == null
                ? 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure officia hic blanditiis voluptates pariatur atque, id, in eos laudantium natus nihil obcaecati deleniti possimus voluptate, quia necessitatibus? Obcaecati, laboriosam ratione!'
                : widget.recipe.steps[index].content),
          ),
        ],
      ),
    );
  }
}
