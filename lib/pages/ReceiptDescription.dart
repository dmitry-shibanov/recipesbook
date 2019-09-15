import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  int _index;
  ProductDescription(this._index);
  PageController controller = PageController();
  var currentPageValue = 0.0;

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: NestedScrollView(
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
                )
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
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            ListView(children: <Widget>[
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
                  controller: controller,
                  itemBuilder: _stepReceipt,
                  itemCount: 10,
                ),
              ),
            ]),
          ],
        ),
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
        ));
  }
}
