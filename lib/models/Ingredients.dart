import 'package:recipesbook/models/Metrics.dart';
import 'package:recipesbook/models/webData.dart';

class Ingredients extends WebData {
  String _title;
  String _count;
  Metrics _metric;

  String get count => _count;
  String get title => _title;
  Metrics get metric => _metric;

  void set count(String cou) {
    if (cou.trim().isEmpty || cou == null) {
      throw ArgumentError.value(cou, "Неверный аргумент",
          "Count не может быть пустым или равным null");
    } else {
      _count = cou;
    }
  }

  void set metric(Metrics metrics) {
    if (metrics!=null && metrics.name != null && !metrics.name.trim().isEmpty) {
      throw ArgumentError.value(metrics, "Неверный аргумент",
          "metrics не может быть пустым или равным null");
    } else {
      _metric = metrics;
    }
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

    map['id'] = id;
    map['title'] = title;

    return map;
  }

  Map<String, dynamic> toMapSave() {
    Map<String, dynamic> map = new Map();
    map['title'] = title;
    return map;
  }

  Ingredients();

  Ingredients.fromMap(Map<String, dynamic> map) {
    _title = map['title'];
    id = map['_id'];
  }

  Ingredients.fromJson(Map<String, dynamic> map) {
    _title = map['name'];
  }
}
