import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'dart:math' as math;

import 'package:recipesbook/models/recipes.dart';

class ProductDescription extends StatefulWidget {
  Recipes recipe;
  ProductDescription(this.recipe);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 256,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Our recipe'),
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
            Text(
              'Описание',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Text(widget.recipe == null ?
                  'Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure officia hic blanditiis voluptates pariatur atque, id, in eos laudantium natus nihil obcaecati deleniti possimus voluptate, quia necessitatibus? Obcaecati, laboriosam ratione!':
                  widget.recipe.content),
            ),
            Text(
              'Ингедиенты',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            buildIngredients(),
            Text(
              'Шаги',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Container(
              // flex: 1,
              height: MediaQuery.of(context).size.height / 2,
              child: PageView.builder(
                // controller: controller,
                itemBuilder: _stepReceipt,
                itemCount: widget.recipe.steps.length,
                // scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/12,)
          ]),
        )
      ]),
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
                onPressed: () => null,
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

  Widget buildIngredients() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          FittedBox(
            child: Text(
              'Гриль',
              textAlign: TextAlign.start,
            ),
          ),
          FittedBox(
            child: Text(
              '12 гр',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepReceipt(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: <Widget>[
          // Image.asset('public/food.jpg'),
              FadeInImage(
                image: NetworkImage(widget.recipe.steps[index].image),
                placeholder: AssetImage('public/food.jpg'),
              ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(widget.recipe == null?
              'Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure officia hic blanditiis voluptates pariatur atque, id, in eos laudantium natus nihil obcaecati deleniti possimus voluptate, quia necessitatibus? Obcaecati, laboriosam ratione!':
              widget.recipe.steps[index].content
            ),
          ),
        ],
      ),
    );
  }
}
