import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MyCamera extends StatefulWidget {
  @override
  _MyCameraState createState() => new _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  CameraController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<CameraDescription> cameras;
  _MyCameraState() {}

  Future<List<CameraDescription>> getCameras() async {
    return availableCameras();
  }

  @override
  void initState() {
    super.initState();

    getCameras().then((List<CameraDescription> onValue) {
      cameras = onValue;
      controller = new CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) return;
        setState(() {
          //TO DO - Anything we want
        });
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<String> saveImage() async {
    String timeStamp = new DateTime.now().millisecondsSinceEpoch.toString();
    String filePath = '/storage/emulated/0/Pictures/${timeStamp}.jpg';

    if (controller.value.isTakingPicture) return null;
    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      showInSnackBar(e.toString());
    }

    return filePath;
  }

  void takePicture() async {
    // bool hasCamera = await SimplePermissions.checkPermission(_permissionCamera);
    // bool hasStorage = await SimplePermissions.checkPermission(_permissionStorage);

    // if(hasStorage == false || hasCamera == false) {
    //   showInSnackBar('Lacking permissions to take a picture!');
    //   return;
    // }

    saveImage().then((String filePath) {
      if (mounted && filePath != null)
        showInSnackBar('Picture saved to ${filePath}');
    });
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Name here'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new RaisedButton(
                        onPressed: takePicture,
                        child: new Text('Take Picture'),
                      ),
                      // new RaisedButton(onPressed: SimplePermissions.openSettings, child: new Text('Settings'),),
                    ]),
                new AspectRatio(
                  aspectRatio: 1.0,
                  child: new CameraPreview(controller),
                )
              ],
            ),
          )),
    );
  }
}
