import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:recipesbook/models/Receipt.dart';
import 'package:recipesbook/pages/CreateRecipes/preview_steps.dart';
import 'dart:convert';
import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:recipesbook/pages/CreateRecipes/stepItem/step_recipe.dart';
import 'package:uuid/uuid_util.dart';

import '../../data/database.dart';

class CreateReceipt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateReceiptState();
  }
}

class CreateReceiptState extends State<CreateReceipt> {
  final List<TextEditingController> controllers = [];
  final List<File> images = [];
  final List<String> keys = [];
  final List<Map<String, dynamic>> _steps = [];
  final Map<String, String> _general_desc = {
    'description_receipt': '',
    'title': '',
    'ingredients': '',
    'time': ''
  };

  static final _formKey = new GlobalKey<FormState>();
  TimeOfDay _timeOfDay;
  final PermissionHandler _permissionHandler = PermissionHandler();

  @override
  void initState() {
    super.initState();
  }

  CreateReceiptState() {
    _timeOfDay = new TimeOfDay(hour: 0, minute: 0);
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  void _setImage(File f) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      f = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey timed = GlobalKey();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _CreateRow('Введите заголовок', _general_desc['title']),
            Divider(),
            _CreateRow('Введите описание', _general_desc['decription'], 5),
            Divider(),
            _CreateRow('Введите ингредиенты', _general_desc['ingredients']),
            Divider(),
            GestureDetector(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Время приготовления $_timeOfDay')),
                onTap: selectTime),
            Divider(),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Text('Введите шаги: '),
                  Container(
                    padding: EdgeInsets.only(right: 80.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                      ),
                      border: Border.all(width: 1.0, color: Colors.black),
                    ),
                    child: InkWell(
                      child: Icon(Icons.add),
                      onTap: () {
                        setState(() {
                          controllers.add(new TextEditingController());
                          var uuid =
                              new Uuid(options: {'grng': UuidUtil.cryptoRNG});
                          keys.add(uuid.v1());
                        });
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      border: Border.all(width: 1.0, color: Colors.black),
                    ),
                    child: InkWell(
                      child: Icon(Icons.remove),
                      onTap: () {
                        setState(() {
                          _steps.removeLast();
                          keys.removeLast();
                          controllers.removeLast();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              itemBuilder: _buildSteps,
              itemCount: keys.length,
            ),
            RaisedButton(
              key: timed,
              color: Colors.white,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewSteps(_steps),
                  )),
              // async {
              //     await _requestPermission(PermissionGroup.storage);
              //     final _db = new MyDatabase();
              //     // Recipes receipt = new Recipes(content: 'sklaklsalksa',title: 'try create');
              //     ReceiptCompanion companion = new ReceiptCompanion(content: moor.Value('sklaklsalksa'),title: moor.Value('Tanother time'));
              //                       var o = await _db.insertRecipe(companion);
              //     print(o);
              //     var all = await _db.allRecipes;
              //     print(all[all.length-1].title);

              // },
              child: Text('Создать рецепт'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(
                    MediaQuery.of(this.context).size.height / 2)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSteps(BuildContext context, int index) {
    Map<String, dynamic> data_step = {
      'content': "",
      'image': null,
    };
    _steps.add(data_step);
    // File file = new File('/storage/emulated/0/Android/data/shibanov.recipesbook/files/Pictures/scaled_49884ac3-294b-4377-8074-0a1cf843a4c95101920437980622551.jpg');
    File file;
    return Dismissible(
      key: Key('adsla;da$index'),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(color: Colors.red),
      ),
      onDismissed: (direction) {
        _deleteRow(keys[index], index);
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(right: 8.0),
                height: MediaQuery.of(context).size.height / 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.black, width: 2.0)),
                child: file == null
                    ? IconButton(
                        icon: Icon(Icons.add),
                        alignment: Alignment.center,
                        onPressed: () async {
                          var result = await showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.photo_album,
                                            color: Colors.red),
                                        title: Text('Галлерея'),
                                        onTap: () async {
                                          if (await _requestPermission(
                                              PermissionGroup.photos)) {
                                            var image =
                                                await ImagePicker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            _steps[index]['image'] =
                                                image.toString();
                                            Navigator.pop(
                                                context, image.toString());
                                          }
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.photo,
                                          color: Colors.red,
                                        ),
                                        title: Text('Фото'),
                                        onTap: () async {
                                          if (await _requestPermission(
                                              PermissionGroup.camera)) {
                                            var image =
                                                await ImagePicker.pickImage(
                                                    source: ImageSource.camera);
                                            print("from camera" +
                                                image.toString());
                                            print("from camera" +
                                                file.toString());
                                            _steps[index]['image'] =
                                                image.toString();
                                            setState(() {
                                              file = new File(image.toString());
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                          setState(() {
                            print(result);
                            _steps[index]['image'] = result;
                          });
                        },
                      )
                    : Image.file(file),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                onChanged: (String value) {
                  // data_step['description'] = value;
                  _steps[index]['content'] = value;
                },
                maxLines: 5,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _deleteRow(String item, int index) {
    setState(() {
      _steps.removeAt(index);
      keys.remove(item);
      controllers.removeAt(index);
    });
  }

  Widget _CreateRow(String title, String inf, [int maxLines = 1]) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(title),
            flex: 1,
          ),
          Expanded(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 10.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              maxLines: maxLines,
              onChanged: (String value) {
                setState(() => inf = value);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<Null> selectTime() async {
    final TimeOfDay responce =
        await showTimePicker(context: context, initialTime: _timeOfDay);

    setState(() {
      if (responce != null) {
        _timeOfDay = responce;
      }
    });
  }
}
