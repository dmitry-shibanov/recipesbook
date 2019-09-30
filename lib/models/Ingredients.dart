class Ingredients {
  int id;
  String title;

  Map<String, dynamic> toMap(){
    Map<String,dynamic> map = new Map();

    map['id'] = id;
    map['title'] = title;

    return map;
  }

  Map<String,dynamic> toMapSave(){
    Map<String,dynamic> map = new Map();

    map['title'] = title;
    return map;
  }

  Ingredients();

  Ingredients.fromMap(Map<String,dynamic> map){
    title = map['title'];
    id = map['_id'];
  }

  Ingredients.fromJson(Map<String,dynamic> map){
    title = map['name'];
  }
}