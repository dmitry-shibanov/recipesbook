import 'dart:async';
import 'dart:io' as Io;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid_util.dart';

class SaveFile {
  Recipes recipe;

  // SaveFile(this.recipe);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<Io.File> getImageFromNetwork(String url) async {
    //  var cacheManager = await CacheManager.getInstance();
    Io.File file = await DefaultCacheManager().getSingleFile(url);
    return file;
  }

  Io.File getImageFromSystem(String path) {
    Io.File file = new Io.File(path);
    return file;
  }

//https://stackoverflow.com/questions/49455079/flutter-save-a-network-image-to-local-directory/51589008
//https://stackoverflow.com/questions/54197053/download-file-from-url-save-to-phones-storage
  Future<List<String>> saveImageNetwork(String url, String name,
      [String stepsFolder = ""]) async {

    Io.Directory dir = await createDirectory();

    String uri = Uri.decodeFull(url);
    final RegExp regex = RegExp('([^?/]*\.(jpg))');

    final File file = File('${dir.path}/$name');
    final StorageReference ref =
        FirebaseStorage.instance.ref().child(url);

    // var a2 = await ref.getDownloadURL();//path

    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);

    return [file.path, dir.path];
  }

  //    Future<Io.File> saveImageNetwork(String url,String name,[String stepsFolder = ""]) async {

  //   final file = await getImageFromNetwork(url);
  //   //retrieve local path for device
  //   // var path = await _localPath;
  //   // Image image = decodeImage(file.readAsBytesSync());

  //   // Image thumbnail = copyResize(image,height: 100,width: 100);
  //   Io.Directory dir = await createDirectory();
  //   // String imageName = stepsFolder.isEmpty ? DateTime.now().toUtc().toIso8601String():
  //   // Save the thumbnail as a PNG.
  //   Future<File> f = file.copy("${dir.path}${stepsFolder.isEmpty?'':'/steps'}/$name.png");
  //   return f;
  //   // return new Io.File('${dir.path}/${DateTime.now().toUtc().toIso8601String()}.png')
  //   //   ..writeAsBytesSync(encodePng(thumbnail));
  // }

  Future<String> saveImageSteps(String url, String path, String name) async {
    Io.Directory directory = await createDirectoryStrps(path);

    final File file = File('${directory.path}/$name');
    final StorageReference ref =
        FirebaseStorage.instance.ref().child(url);

    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);

    File f = await file.copy("${directory.path}/$name.png");

    return f.path;
  }

  Future<Io.File> saveImageLocal(String path) async {
    var path = await _localPath;

    final file = getImageFromSystem(path);

    Image image = decodeImage(file.readAsBytesSync());

    Image thumbnail = copyResize(image);

    Io.Directory dir = await createDirectory();

    return new Io.File(
        '${dir.path}/${DateTime.now().toUtc().toIso8601String()}.png')
      ..writeAsBytesSync(encodePng(thumbnail));
  }

  Future<Io.Directory> createDirectory() async {
    final directory = await getExternalStorageDirectory();
    var uuid = new Uuid(options: {'grng': UuidUtil.cryptoRNG});
    final myImagePath = '${directory.path}/${uuid.v1()}';
    final myImgDir = await new Io.Directory(myImagePath).create();
    return myImgDir;
  }

  Future<Io.Directory> createDirectoryStrps(String path) async {
    final myImagePath = '$path/steps';
    final myImgDir = await new Io.Directory(myImagePath).create();
    return myImgDir;
  }
}
