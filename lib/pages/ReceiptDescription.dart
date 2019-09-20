import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'dart:math' as math;

class ProductDescription extends StatefulWidget {
  final int _index;
  ProductDescription(this._index);
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
    // TODO: implement build
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Our recipe'),
              // expandedHeight: 200.0,
              floating: true,
              snap: true,
              pinned: false,
              actions: <Widget>[
                IconButton(
                  onPressed: () => null,
                  icon: Icon(Icons.favorite),
                ),
              ],
              // flexibleSpace: FlexibleSpaceBar(
              //     centerTitle: true,
              //     collapseMode: CollapseMode.parallax,
              //     background: Image.asset(
              //       'public/food.jpg',
              //       fit: BoxFit.cover,
              //     )),
            ),
          ];
        },
        body:
            // Flex(
            // direction: Axis.vertical,
            // children: <Widget>[
            ListView(
                // controller: ScrollController(keepScrollOffset: false),
                // shrinkWrap: false,
                children: <Widget>[
              Image.asset('public/food.jpg'),
              Text(
                'Описание',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              Container(
                margin: EdgeInsets.all(16.0),
                child: Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure officia hic blanditiis voluptates pariatur atque, id, in eos laudantium natus nihil obcaecati deleniti possimus voluptate, quia necessitatibus? Obcaecati, laboriosam ratione!'),
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
              Expanded(
                child: PageView.builder(
                  // controller: controller,
                  itemBuilder: _stepReceipt,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ]),
        // ],
        // ),
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
                      transform: Matrix4.rotationZ(controller.value * 0.5 * math.pi),
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
          Image.asset('public/food.jpg'),
          Text(
              'Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure officia hic blanditiis voluptates pariatur atque, id, in eos laudantium natus nihil obcaecati deleniti possimus voluptate, quia necessitatibus? Obcaecati, laboriosam ratione!'),
        ],
      ),
    );
  }
}
