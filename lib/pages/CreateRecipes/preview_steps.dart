import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class PreviewSteps extends StatefulWidget {
  List<Map<String, dynamic>> steps;
  Map<String, dynamic> content;
  PreviewSteps(this.steps);

  @override
  State<StatefulWidget> createState() {
    print(steps.length);
    return PreviewStepsState(this.steps);
  }
}

class PreviewStepsState extends State<PreviewSteps> {
  List<Map<String, dynamic>> _steps;
  List<Widget> _steps_widget;

  PreviewStepsState(steps) {
    this._steps = steps;
    _steps_widget = _steps
        .asMap()
        .map((index, item) => MapEntry(index, _buildSteps(index, item)))
        .values
        .toList();
  }

  @override
  void initState() {
    _steps_widget = _steps
        .asMap()
        .map((index, item) => MapEntry(index, _buildSteps(index, item)))
        .values
        .toList();
    super.initState();
  }

  Widget _buildSteps(index, item) {
    var uuid = new Uuid(options: {'grng': UuidUtil.cryptoRNG});
    return Dismissible(
      key: Key(uuid.v1()),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(color: Colors.red),
      ),
      onDismissed: (direction) {
        _deleteRow(index);
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
                child: Image.file(new File(
                    '/Users/dmitry/Library/Developer/CoreSimulator/Devices/A7C99D2A-AB83-464C-BCC2-867DD5EE496F/data/Containers/Data/Application/E119EA96-A45D-4A83-B2EB-9E4F5BF5C6A9/tmp/image_picker_A85B9803-3B26-4BE5-95B5-DF296F71BA73-84590-000053ED7230DC46.jpg')),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(item['content']),
            )
          ],
        ),
      ),
    );
  }

  void _deleteRow(int index) {
    setState(() {
      _steps.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Шаги рецепта'),
        ),
        body: ReorderableListView(
          children: _steps_widget,
          // onReorder: (int start, int current) {
          //   // dragging from top to bottom
          //   if (start < current) {
          //     int end = current - 1;
          //     Map<String, dynamic> startItem = _steps[start];
          //     int i = 0;
          //     int local = start;
          //     do {
          //       _steps[local] = _steps[++local];
          //       i++;
          //     } while (i < end - start);
          //     _steps[end] = startItem;
          //   }
          //   // dragging from bottom to top
          //   else if (start > current) {
          //     Map<String, dynamic> startItem = _steps[start];
          //     for (int i = start; i > current; i--) {
          //       _steps[i] = _steps[i - 1];
          //     }
          //     _steps[current] = startItem;
          //   }
          // }
          onReorder: (int start, int current) {
            // dragging from top to bottom
            if (start < current) {
              int end = current - 1;
              Map<String, dynamic> startItem = _steps[start];
              int i = 0;
              int local = start;
              do {
                _steps[local] = _steps[++local];
                i++;
              } while (i < end - start);
              _steps[end] = startItem;
            }
            // dragging from bottom to top
            else if (start > current) {
              Map<String, dynamic> startItem = _steps[start];
              for (int i = start; i > current; i--) {
                _steps[i] = _steps[i - 1];
              }
              _steps[current] = startItem;
            }
            setState(() {});
          },
        ));
  }
}
