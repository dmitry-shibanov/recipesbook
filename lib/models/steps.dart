import 'package:firebase_storage/firebase_storage.dart';

class Steps {
  int id;
  String content;
  String image;
  String stepsrecipe;
  String _pathImage;

  String get pathImage => _pathImage;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map['content'] = content;
    map['image'] = image;
    map['_id'] = id;

    return map;
  }

  Map<String, dynamic> toMapSave() {
    Map<String, dynamic> map = new Map();
    map['content'] = content;
    map['image'] = image;
    map['stepsrecipe'] = stepsrecipe;

    return map;
  }

  Steps();

  Steps.fromMap(Map<String, dynamic> map) {
    // id = int.parse(map['id']);
    content = map['content'];

    _pathImage = map['image'];
    final StorageReference ref =
        FirebaseStorage.instance.ref().child(map['image']);

    Stream stream = Stream.fromFuture(ref.getDownloadURL());

    stream.listen((data) {
      image = data;
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });
  }
}
