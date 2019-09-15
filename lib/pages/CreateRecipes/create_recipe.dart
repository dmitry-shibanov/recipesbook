import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:uuid/uuid.dart';


import 'package:recipesbook/pages/CreateRecipes/stepItem/step_recipe.dart';
import 'package:uuid/uuid_util.dart';

class CreateReceipt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateReceiptState();
  }
}

class CreateReceiptState extends State<CreateReceipt> {
  final List<TextEditingController> controllers = [];
  final List<File> images = [];
  int _i=0;
  final List<Widget> _recipeSteps = [
    Expanded(
      child: Text(
        'djdskjak',
      ),
      key: ValueKey("ajk1"),
    ),
    Expanded(
      child: Text(
        'djdskjak',
      ),
      key: ValueKey("ajk2"),
    ),
    Expanded(
      child: Text(
        'djdskjak',
      ),
      key: ValueKey("ajk3"),
    ),
  ];
  final List<String> keys = [];
  final List<Map<String, dynamic>> _steps = [];
  ScrollController _scrollController;
  final Map<String, String> _general_desc = {
    'description_receipt': '',
    'title': '',
    'ingredients': '',
    'time': ''
  };
  int i = 0;
  TimeOfDay _timeOfDay;
  final PermissionHandler _permissionHandler = PermissionHandler();
  List<String> _list = ["Apple", "Ball", "Cat", "Dog", "Elephant"];
  @override
  void initState() {
    super.initState();
    // _timeOfDay = new TimeOfDay(hour: 0, minute: 0);
    // _scrollController =
    //     PrimaryScrollController.of(context) ?? ScrollController();
  }
  var _key;
  CreateReceiptState(){
    _key = new Uuid(options: {'grng': UuidUtil.cryptoRNG});
    
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  List<Widget> testList() {
    List<Widget> l = [];
    for (int i = 0; i < 11; i++) {
      l.add(Text('skalsklaklas', key: ValueKey("ajk$i")));
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey timed = GlobalKey();
    return
        // GestureDetector(
        //   onTap: () {
        //     FocusScope.of(context).requestFocus(FocusNode());
        //   },
        //   child:
        // CustomScrollView(
        // controller: _scrollController,
        // slivers:<Widget>[
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     _CreateRow('Введите заголовок', _general_desc['title']),
        //     Divider(),
        //     _CreateRow('Введите описание', _general_desc['decription'], 5),
        //     Divider(),
        //     _CreateRow('Введите ингредиенты', _general_desc['ingredients']),
        //     Divider(),
        //     GestureDetector(
        //         child: Padding(
        //             padding: EdgeInsets.all(10.0),
        //             child: Text('Время приготовления $_timeOfDay')),
        //         onTap: selectTime),
        //     Divider(),
        //     Padding(
        //       padding: EdgeInsets.all(10.0),
        //       child: Row(
        //         children: <Widget>[
        //           Text('Введите шаги: '),
        //           Container(
        //             padding: EdgeInsets.only(right: 80.0),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.only(
        //                   bottomLeft: Radius.circular(10.0),
        //                   topLeft: Radius.circular(10.0)),
        //             ),
        //           ),
        //           Container(
        //             alignment: Alignment.centerRight,
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.only(
        //                 bottomLeft: Radius.circular(10.0),
        //                 topLeft: Radius.circular(10.0),
        //               ),
        //               border: Border.all(width: 1.0, color: Colors.black),
        //             ),
        //             child: InkWell(
        //               child: Icon(Icons.add),
        //               onTap: () {
        //                 setState(() {
        //                   _recipeSteps.add(new StepRecipe(_deleteRow, i));
        //                   controllers.add(new TextEditingController());
        //                   keys.add("value $i");
        //                   i++;
        //                 });
        //               },
        //             ),
        //           ),
        //           Container(
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.only(
        //                 bottomRight: Radius.circular(10.0),
        //                 topRight: Radius.circular(10.0),
        //               ),
        //               border: Border.all(width: 1.0, color: Colors.black),
        //             ),
        //             child: InkWell(
        //               child: Icon(Icons.remove),
        //               onTap: () {
        //                 //controllers.remove(new TextEditingControlle);
        //                 // showModalBottomSheet(
        //                 //     context: context,
        //                 //     builder: (BuildContext context) {
        //                 //       return Container(
        //                 //         child: Wrap(
        //                 //           children: <Widget>[
        //                 //             ListTile(
        //                 //               leading: Icon(Icons.photo_album,
        //                 //                   color: Colors.red),
        //                 //               title: Text('Галлерея'),
        //                 //               onTap: () {
        //                 //                 Navigator.pushNamed(context, '/gallery');
        //                 //               },
        //                 //             ),
        //                 //             ListTile(
        //                 //               leading: Icon(
        //                 //                 Icons.photo,
        //                 //                 color: Colors.red,
        //                 //               ),
        //                 //               title: Text('Фото'),
        //                 //               onTap: () async {
        //                 //                 if(await _requestPermission(PermissionGroup.camera)){
        //                 //                 Navigator.pushNamed(context, '/camera');
        //                 //                 }
        //                 //               },
        //                 //             ),
        //                 //           ],
        //                 //         ),
        //                 //       );
        //                 //     });
        //                 keys.add("value $i");
        //                 // i++;
        //               },
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        // ListView.builder(
        //   controller: ScrollController(keepScrollOffset: false),
        //   shrinkWrap: true,
        //   itemBuilder: _buildSteps,
        //   itemCount: i,
        // ),
        //   Column(
        //     mainAxisSize: MainAxisSize.min,
        // children:<Widget>[ Expanded(
        // child:
        // Expanded(child:SliverToBoxAdapter(child:
        ReorderableListView(
      // header:
      //       Padding(
      //     padding: EdgeInsets.all(10.0),
      //     child: Row(
      //       children: <Widget>[
      //         Text('Введите шаги: '),
      //         Container(
      //           padding: EdgeInsets.only(right: 80.0),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.only(
      //                 bottomLeft: Radius.circular(10.0),
      //                 topLeft: Radius.circular(10.0)),
      //           ),
      //         ),
      //         Container(
      //           alignment: Alignment.centerRight,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.only(
      //               bottomLeft: Radius.circular(10.0),
      //               topLeft: Radius.circular(10.0),
      //             ),
      //             border: Border.all(width: 1.0, color: Colors.black),
      //           ),
      //           child: InkWell(
      //             child: Icon(Icons.add),
      //             onTap: () {
      //               setState(() {
      //                 _recipeSteps.add(new StepRecipe(_deleteRow, i));
      //                 controllers.add(new TextEditingController());
      //                 keys.add("value $i");
      //                 i++;
      //               });
      //             },
      //           ),
      //         ),
      //         Container(
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.only(
      //               bottomRight: Radius.circular(10.0),
      //               topRight: Radius.circular(10.0),
      //             ),
      //             border: Border.all(width: 1.0, color: Colors.black),
      //           ),
      //           child: InkWell(
      //             child: Icon(Icons.remove),
      //             onTap: () {
      //               //controllers.remove(new TextEditingControlle);
      //               // showModalBottomSheet(
      //               //     context: context,
      //               //     builder: (BuildContext context) {
      //               //       return Container(
      //               //         child: Wrap(
      //               //           children: <Widget>[
      //               //             ListTile(
      //               //               leading: Icon(Icons.photo_album,
      //               //                   color: Colors.red),
      //               //               title: Text('Галлерея'),
      //               //               onTap: () {
      //               //                 Navigator.pushNamed(context, '/gallery');
      //               //               },
      //               //             ),
      //               //             ListTile(
      //               //               leading: Icon(
      //               //                 Icons.photo,
      //               //                 color: Colors.red,
      //               //               ),
      //               //               title: Text('Фото'),
      //               //               onTap: () async {
      //               //                 if(await _requestPermission(PermissionGroup.camera)){
      //               //                 Navigator.pushNamed(context, '/camera');
      //               //                 }
      //               //               },
      //               //             ),
      //               //           ],
      //               //         ),
      //               //       );
      //               //     });
      //               keys.add("value $i");
      //               // i++;
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // scrollDirection: Axis.vertical,
      // onReorder: (oldIndex, newIndex) {
      //   setState(() {
      //     var oldElement = _recipeSteps[oldIndex];
      //     _recipeSteps[oldIndex] = _recipeSteps[newIndex];
      //     _recipeSteps[newIndex] = oldElement;
      //   });
      // },
      children: _list.map((item) => Container(key: ValueKey(new Uuid(options: {'grng': UuidUtil.cryptoRNG}).v4()),child: StepRecipe(_deleteRow,_i++))).toList(),
      onReorder: (int start, int current) {
        // dragging from top to bottom
        if (start < current) {
          int end = current - 1;
          String startItem = _list[start];
          int i = 0;
          int local = start;
          do {
            _list[local] = _list[++local];
            i++;
          } while (i < end - start);
          _list[end] = startItem;
        }
        // dragging from bottom to top
        else if (start > current) {
          String startItem = _list[start];
          for (int i = start; i > current; i--) {
            _list[i] = _list[i - 1];
          }
          _list[current] = startItem;
        }
      }
    );
    // ),]
    // ),
    // RaisedButton(
    //   key: timed,
    //   color: Colors.white,
    //   onPressed: () async =>
    //       await _requestPermission(PermissionGroup.storage),
    //   child: Text('Создать рецепт'),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(
    //         MediaQuery.of(this.context).size.height / 2)),
    //   ),
    // ),
    //   ],
    // ),
    // ),
    // ),
    // ]),
    // );
  }

  // Widget _buildSteps(BuildContext context, int index) {
  //   Map<String, dynamic> data_step = {
  //     'description': "",
  //     'image': null,
  //   };
  //   _steps.add(data_step);
  //   // File file = new File('/storage/emulated/0/Android/data/shibanov.recipesbook/files/Pictures/scaled_49884ac3-294b-4377-8074-0a1cf843a4c95101920437980622551.jpg');
  //   File file;
  //   return Dismissible(
  //     key: Key(keys[index]),
  //     direction: DismissDirection.endToStart,
  //     background: Container(
  //       decoration: BoxDecoration(color: Colors.red),
  //     ),
  //     onDismissed: (direction) {
  //       _deleteRow(keys[index], index);
  //     },
  //     child: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Row(
  //         children: <Widget>[
  //           Expanded(
  //             flex: 1,
  //             child: Container(
  //               margin: EdgeInsets.only(right: 8.0),
  //               height: MediaQuery.of(context).size.height / 8,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                   border: Border.all(color: Colors.black, width: 2.0)),
  //               child: file == null ? IconButton(
  //                 icon: Icon(Icons.add),
  //                 alignment: Alignment.center,
  //                 onPressed: () {
  //                   showModalBottomSheet(
  //                       context: context,
  //                       builder: (BuildContext context) {
  //                         return Container(
  //                           child: Wrap(
  //                             children: <Widget>[
  //                               ListTile(
  //                                 leading: Icon(Icons.photo_album,
  //                                     color: Colors.red),
  //                                 title: Text('Галлерея'),
  //                                 onTap: () async {
  //                                   if(await _requestPermission(PermissionGroup.photos)){
  //                                   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //                                   setState(() {
  //                                    file = image;
  //                                   });
  //                                   }
  //                                   // file = await
  //                                   // images;
  //                                   // Navigator.pushNamed(context, '/gallery');
  //                                 },
  //                               ),
  //                               ListTile(
  //                                 leading: Icon(
  //                                   Icons.photo,
  //                                   color: Colors.red,
  //                                 ),
  //                                 title: Text('Фото'),
  //                                 onTap: () async {
  //                                   if (await _requestPermission(
  //                                       PermissionGroup.camera)) {
  //                                         var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //                                         print("from camera"+image.toString());
  //                                         print("from camera"+file.toString());
  //                                      setState(() {
  //                                         file = new File(image.toString());
  //                                      });
  //                                     // Navigator.pushNamed(context, '/camera');
  //                                   }
  //                                 },
  //                               ),
  //                             ],
  //                           ),
  //                         );
  //                       });
  //                 },
  //               ):Image.file(file),
  //             ),
  //           ),
  //           Expanded(
  //             flex: 2,
  //             child: TextField(
  //               decoration: InputDecoration(
  //                   border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(10.0)))),
  //               onChanged: (String value) {
  //                 data_step['description'] = value;
  //               },
  //               maxLines: 5,
  //               controller: controllers[index],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _deleteRow(String item, int index) {
    setState(() {
      _steps.removeAt(index);
      keys.remove(item);
      controllers.removeAt(index);
      i--;
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
