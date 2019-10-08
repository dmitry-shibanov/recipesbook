class Steps {
  int id;
  String content;
  String image;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map['content'] = content;
    map['image'] = image;
    map['_id'] = id;

    return map;
  }

  Map<String,dynamic> toMapSave(){
    Map<String, dynamic> map = new Map();
    map['content'] = content;
    map['image'] = image;

    return map;
  }

  Steps();

  Steps.fromMap(Map<String, dynamic> map){
    // id = int.parse(map['id']);
    content = map['content'];
    image = map['image'];

  }
}
