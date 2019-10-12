import 'package:recipesbook/models/webData.dart';

class Ingredients extends WebData {
  String _title;
  String _count;
  String _metric;
  String recipeingredient;

  String get count => _count;
  String get title => _title;
  String get metric => _metric;

  void set count(String cou) {
    // /cou.trim().isEmpty ||
    if (cou == null) {
      throw ArgumentError.value(cou, "Неверный аргумент",
          "Count не может быть пустым или равным null");
    } else {
      _count = cou;
    }
  }

  void set metric(String metrics) {
    // if (metrics!=null && metrics.name != null && !metrics.name.trim().isEmpty) {
    //   throw ArgumentError.value(metrics, "Неверный аргумент",
    //       "metrics не может быть пустым или равным null");
    // } else {
    _metric = metrics;
    // }
  }

  void set title(String name) {
    if (name.trim().isEmpty || name == null) {
      throw ArgumentError.value(name, "Неверный аргумент",
          "title не может быть пустым или равным null");
    } else {
      _title = name;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();

    map['_id'] = id;
    map['title'] = title;
    map['count'] = count;
    map['metric'] = metric;
    map['recipeingredient'] = recipeingredient;
    return map;
  }

  Map<String, dynamic> toMapSave() {
    Map<String, dynamic> map = new Map();
    map['title'] = title;
    map['count'] = count;
    map['metric'] = metric;
    map['recipeingredient'] = recipeingredient;
    return map;
  }

  Ingredients();

  Ingredients.fromMap(Map<String, dynamic> map) {
    _title = map['title'];
    count = map['count'];
    metric = map['metric'];
    id = map['_id'];
  }

  Ingredients.fromJson(Map<dynamic, dynamic> map) {
    print('came');
    title = map["ingredient"];
    metric = map["metric"];
    count = map["count"];
  }
}
