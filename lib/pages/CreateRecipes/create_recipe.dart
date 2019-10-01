import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:recipesbook/data/db_helper.dart';
import 'package:recipesbook/mixins/create_recipe_mixins.dart';
import 'package:recipesbook/models/Ingredients.dart';
import 'package:recipesbook/pages/CreateRecipes/preview_steps.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:uuid/uuid_util.dart';

class CreateReceipt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateReceiptState();
  }
}

class CreateReceiptState extends State<CreateReceipt> with CreateRecipeMixins {
  final List<TextEditingController> controllers = [];
  final List<String> images = [];
  final List<File> imagesFiles = [];
  var provider = new DatabaseProvider();
  List<Ingredients> listIngredients;

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
  bool tapped = false;
  final GlobalKey<FormState> _globalKey = GlobalKey();
  String _productCount = "";

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

  Future<List<Ingredients>> load_ingredients() async {
    List<Map<String, dynamic>> maps = await provider.getIngredients();
    if (maps == null) {}

    List<Ingredients> ingredients = maps.map((item) {
      var ingredient = Ingredients.fromMap(item);
      return ingredient;
    }).toList();
    return ingredients;
  }

  void _setImage(File path, int index) {
    print(path);
    print("it is our path ${path.toString().replaceFirst('File: ', '')}");
    setState(() {
      images[index] = path.toString();
      imagesFiles[index] = path;
      _steps[index]['image'] = path;
    });
  }

  submitForm() async {
    if (!_globalKey.currentState.validate()) {
      return;
    }
    _globalKey.currentState.save();
    var dir = await getApplicationDocumentsDirectory();
    print(dir.path);
    await _requestPermission(PermissionGroup.storage);
    var _db = new DatabaseProvider();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewSteps(_steps),
        ));
    // Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey timed = GlobalKey();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          tapped = false;
        });
      },
      child: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _CreateRow(
                  'Введите заголовок', _general_desc['title'], validateTitle),
              Divider(),
              _CreateRow('Введите описание', _general_desc['decription'],
                  validateContent, 5),
              Divider(),
              Row(
                children: <Widget>[Expanded(child:
                  TextField(
                    onChanged: (String value){
                      _productCount = value;
                    },
                  ),
                  flex: 1,),
                  Expanded(
                    flex: 2,
                    child:
                  FutureBuilder<List<Ingredients>>(
                    future: load_ingredients(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Ingredients>> list) {
                          String dropdownValue = "Шафран";
                      if (!list.hasData) {
                        return Text('Идет загрузка');
                      }

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.0,),
                        child: DropdownButton<String>(
                        // value: 'Шафран',
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        isExpanded: true,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                        items: list.data
                            .map<DropdownMenuItem<String>>((Ingredients value) {
                          return DropdownMenuItem<String>(
                            value: value.title,
                            child: Text(value.title),
                          );
                        }).toList(),
                      ),
                      );
                    },
                  ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(icon: Icon(Icons.check),onPressed: (){

                    },),
                  )
                ],
              ),
              Divider(),
              GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          'Время приготовления ${_timeOfDay.format(context)}')),
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
                            Map<String, dynamic> data_step = {
                              'content': "",
                              'image': null,
                            };
                            _steps.add(data_step);
                            controllers.add(new TextEditingController());
                            images.add("");
                            imagesFiles.add(null);
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
              SizedBox(
                height: tapped ? MediaQuery.of(context).size.height / 2 : 0,
              ),
              RaisedButton(
                key: timed,
                color: Colors.white,
                onPressed: submitForm,
                child: Text('Посмотреть шаги'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(this.context).size.height / 2)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSteps(BuildContext context, int index) {
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
                child: images[index] == ""
                    ? IconButton(
                        icon: Icon(Icons.add),
                        alignment: Alignment.center,
                        onPressed: () async {
                          var files = await showModalBottomSheet(
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
                                            Navigator.pop(context, image);
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
                          print('came');
                          Future.delayed(Duration(milliseconds: 2000),
                              () => _setImage(files, index));
                        },
                      )
                    : Image.file(imagesFiles[index]),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                validator: validateStep,
                onSaved: (String value) {
                  _steps[index]['content'] = value;
                },
                onTap: () {
                  setState(() {
                    tapped = true;
                  });
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

  Widget _CreateRow(String title, String save, Function validator,
      [int maxLines = 1]) {
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
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 10.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              maxLines: maxLines,
              validator: validator,
              onSaved: (String value) {
                save = value;
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
