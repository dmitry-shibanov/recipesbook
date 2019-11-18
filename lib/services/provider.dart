import 'package:flutter/material.dart';

import 'blockRecipes.dart';

class Provider extends InheritedWidget {
  final bloc = RecipesBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static RecipesBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
  
}
