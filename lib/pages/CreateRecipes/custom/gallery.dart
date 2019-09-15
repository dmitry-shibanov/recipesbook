import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:image_gallery/image_gallery.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => new _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<Object> allImage = new List();

  @override
  void initState() {
    super.initState();
    loadImageList();
  }

  Future<void> loadImageList() async {
    Map<dynamic, dynamic> allImageTemp;
      allImageTemp = await FlutterGallaryPlugin.getAllImages;


    setState(() {
      this.allImage = allImageTemp['URIList'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Image Gallery'),
        ),
        body: _buildGrid()
        ,
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.extent(
        maxCrossAxisExtent: 150.0,
        // padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _buildGridTileList(19));
  }

  List<Container> _buildGridTileList(int count) {

    return List<Container>.generate(
    count,
    (int index) =>
    Container(child: Image.file(File(allImage[index].toString()),
    width: 96.0,
    height: 96.0,
    fit: BoxFit.contain,)));
  }
}