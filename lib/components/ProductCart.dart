import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipesbook/components/address.dart';
import 'package:recipesbook/components/price_tag.dart';
import 'package:recipesbook/components/title_default.dart';
import 'package:recipesbook/models/recipes.dart';

class ProductCard extends StatelessWidget {
  // final Product product;
  final Recipes _recipe;

  ProductCard(this._recipe);

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault('any title'),
          SizedBox(
            width: 8.0,
          ),
          //PriceTag('12312')
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(context, '/product/1'),
        ),
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.red,
          onPressed: () => Navigator.pushNamed<bool>(context, '/product/1'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'image_hero${_recipe.documentId}',
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: FadeInImage(
                image: NetworkImage(_recipe.image),
                placeholder: AssetImage('public/food.jpg'),
              ),
            ),
          ),
          // Image.asset('public/food.jpg'),
          _buildTitlePriceRow(),
          //  AddressTag('any address'),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}
