class Ingredients {
  int id;
  String title;

  Map<String, dynamic> toMap(){
    Map<String,dynamic> map = new Map();

    map['id'] = id;
    map['title'] = title;

    return map;
  }

  Ingredients();

  Ingredients.fromMap(Map<String,dynamic> map){
    id = int.parse(map['id']);
    title = map['title'];
  }
}