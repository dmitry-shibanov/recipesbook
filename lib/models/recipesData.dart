abstract class RecipeData {
  int _id;

  Map<String, dynamic> toMap();
  Map<String, dynamic> toMapSave();

  int get id => _id;
  void set id(int id) {
    if (id < 0) {
      throw ArgumentError.value(
          id, "Неверный аргумент", "id не может быть отрицательным");
    } else {
      _id = id;
    }
  }
}
