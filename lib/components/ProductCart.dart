
import 'package:flutter/material.dart';
import 'package:recipesbook/components/address.dart';
import 'package:recipesbook/components/price_tag.dart';
import 'package:recipesbook/components/title_default.dart';

class ProductCard extends StatelessWidget {
  // final Product product;
  // final int productIndex;

  // ProductCard(this.product, this.productIndex);

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
          onPressed: () =>
              Navigator.pushNamed<bool>(context, '/product/1'),
        ),
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.red,
          onPressed: () =>
              Navigator.pushNamed<bool>(context, '/product/1'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('public/food.jpg'),
          _buildTitlePriceRow(),
        //  AddressTag('any address'),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}