import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class StepRecipe extends StatefulWidget {
  Function _deleteRow;
  int _index;

  StepRecipe(this._deleteRow, this._index);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StepRecipeState(_deleteRow, _index);
  }
}

class StepRecipeState extends State<StepRecipe> {
  String key;
  final PermissionHandler _permissionHandler = PermissionHandler();
  var uuid;
  int _index;
  File file;
  TextEditingController controller;

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Function _deleteRow;

  StepRecipeState(this._deleteRow, this._index);

  @override
  void initState() {
    super.initState();

    var uuid = new Uuid();
    key = uuid.v1();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dismissible(
      key: ValueKey("dksaldaslka$_index"),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(color: Colors.red),
      ),
      onDismissed: (direction) {
        _deleteRow(key, _index);
      },
      child: Padding(
        // key: ValueKey(uuid.v1()),
        padding: EdgeInsets.all(16.0),
        child: Row(
          // key: ValueKey(uuid.v1()),
          children: <Widget>[
            Expanded(
              // key: ValueKey(uuid.v1()),
              flex: 1,
              child: Container(
                // key: ValueKey(uuid.v1()),
                margin: EdgeInsets.only(right: 8.0),
                height: MediaQuery.of(context).size.height / 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.black, width: 2.0)),
                child: file == null
                    ? IconButton(
                        // key: ValueKey(uuid.v1()),
                        icon: Icon(Icons.add),
                        alignment: Alignment.center,
                        onPressed: () {
                          showModalBottomSheet(
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
                                            setState(() {
                                              file = image;
                                            });
                                          }
                                          // file = await
                                          // images;
                                          // Navigator.pushNamed(context, '/gallery');
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
                                            setState(() {
                                              file = new File(image.toString());
                                            });
                                            // Navigator.pushNamed(context, '/camera');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      )
                    : Image.file(
                        file,
                        // key: ValueKey(uuid.v1()),
                      ),
              ),
            ),
            Expanded(
              // key: ValueKey(uuid.v1()),
              flex: 2,
              child: TextField(
                // key: ValueKey(uuid.v1()),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                onChanged: (String value) {
                  // data_step['description'] = value;
                },
                maxLines: 5,
                // controller: controllers[index],
                controller: controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
