import 'package:flutter/material.dart';
import 'package:recipesbook/components/ProductCart.dart';

class ProductsList extends StatefulWidget {
  

  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductsListState();
  }
}

class ProductsListState extends State {

  // ProductsListState(this._tabController);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      // controller: _tabController,
        children: <Widget>[
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ProductCard();
            },
            itemCount: 12,
          ),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ProductCard();
            },
            itemCount: 2,
          )
        ],
    );
  }
}
