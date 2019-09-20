import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipesbook/components/title_default.dart';

class SavedRecipeItem extends StatelessWidget {
  final String _image;
  final String _title;

  SavedRecipeItem(this._image,this._title);

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
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed<bool>(context, '/product/1');
      },
      child: Card(
      child: Column(
        children: <Widget>[
          Image.file(new File(_image)),
          _buildTitlePriceRow(),
          SizedBox(
            height: 16.0,
          )
          // AddressTag('any address'),
          // _buildActionButtons(context)
        ],
      ),
     ),
    );
  }
}
