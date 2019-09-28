class CreateRecipeMixins {
  String validateTitle(String value) {
    String trimValue = value.trim();
    if (trimValue.length < 3 || trimValue.length > 15) {
      return "Название должно быть от 4 до 15 символов";
    }
    return null;
  }

  String validateContent(String value){
    String trimValue = value.trim();
    if(trimValue.length<20 || trimValue.length>300){
      return "Описание должно быть от 20 до 300 символов";
    }
    return null;
  }

  String validateStep(String value){
    String trimValue = value.trim();
    if(trimValue.length<10 || trimValue.length>120){
      return "Описание шага должно быть от 10 до 120 символов";
    }
    return null;
  }
}
