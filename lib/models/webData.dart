
import 'package:recipesbook/models/recipesData.dart';

abstract class WebData extends RecipeData{
  String _documentId;

  Map<String, dynamic> toMap();
  Map<String, dynamic> toMapSave();

  String get documentId => _documentId;

  void set documentId(String doc) {
    if (doc.trim().isEmpty || doc == null) {
      throw ArgumentError.value(doc, "Неверный аргумент",
          "DocumentId не может быть пустым или равным null");
    } else {
      _documentId = doc;
    }
  }

  void set id(int id) {
    if (id < 0) {
      throw ArgumentError.value(
          id, "Неверный аргумент", "id не может быть отрицательным");
    } else {
      super.id = id;
    }
  }
}
