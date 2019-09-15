import 'package:flutter/material.dart';
import 'package:recipesbook/components/title_default.dart';

class SavedRecipeItem extends StatelessWidget {
  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 8.0,
          ),
          TitleDefault('any title'),
          SizedBox(
            width: 8.0,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('public/food.jpg'),
          _buildTitlePriceRow(),
          SizedBox(
            height: 16.0,
          )
          // AddressTag('any address'),
          // _buildActionButtons(context)
        ],
      ),
    );
  }
}
