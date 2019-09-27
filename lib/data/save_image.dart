import 'dart:async';
import 'dart:io' as Io;
import 'package:image/image.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid_util.dart';
class SaveFile {

  Recipes recipe;
  
  SaveFile(this.recipe);

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

   Future<Io.File> saveImageNetwork(String url) async {

    final file = await getImageFromNetwork(url);
    //retrieve local path for device
    var path = await _localPath;
    Image image = decodeImage(file.readAsBytesSync());

    Image thumbnail = copyResize(image);
    Io.Directory dir = await createDirectory();
    // Save the thumbnail as a PNG.
    return new Io.File('${dir.path}/${DateTime.now().toUtc().toIso8601String()}.png')
      ..writeAsBytesSync(encodePng(thumbnail));
  }

  Future<Io.File> saveImageLocal(String path) async {
    var path = await _localPath;

    final file = getImageFromSystem(path);

    Image image = decodeImage(file.readAsBytesSync());

    Image thumbnail = copyResize(image);

    Io.Directory dir = await createDirectory();

    return new Io.File('${dir.path}/${DateTime.now().toUtc().toIso8601String()}.png')
      ..writeAsBytesSync(encodePng(thumbnail));
  }

  Future<Io.Directory> createDirectory() async {
    final directory = await getExternalStorageDirectory();
                                var uuid =
                                new Uuid(options: {'grng': UuidUtil.cryptoRNG});
    final myImagePath = '${directory.path}/${uuid.v1()}' ;
    final myImgDir = await new Io.Directory(myImagePath).create();
    return myImgDir;
  }
}

// final directory = await getExternalStorageDirectory();
// You need to provide the permission on AndroidManifest.xml file of your android/app/src/main folder

// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
// then let's say that you want to create a folder named MyImages and add the new image to that folder,

// final myImagePath = '${directory.path}/MyImages' ;
// final myImgDir = await new Directory(myImagePath).create();
// then write to the file to the path.

// var kompresimg = new File("$myImagePath/image_$baru$rand.jpg")
//   ..writeAsBytesSync(img.encodeJpg(gambarKecilx, quality: 95));
// for getting the number of files, just obtain the files to a list and check the length of the list

// var listOfFiles = await myImgDir.list(recursive: true).toList();
// var count = countList.length;