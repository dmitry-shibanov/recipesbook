import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LogoPageFull());
  }
}

class LogoPageFull extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogoPageState();
  }
}

class _LogoPageState extends State<LogoPageFull> with TickerProviderStateMixin {
  AnimationController controller;
    AnimationController controller1;
  Animation<double> animation;
    Animation<double> animation1;
  List<String> data = ['1','2','3'];
  int _currentIndex = 0;
  DecorationImage _buildBakcgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('public/splash.jpg'),
    );
  }

  @override
  dispose(){
    controller.stop();
    controller1.stop();
    super.dispose();
  }

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    controller1 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation1 = CurvedAnimation(parent: controller1, curve: Curves.easeIn);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        var future = new Future.delayed(const Duration(milliseconds: 1000),
            () => Navigator.pushReplacementNamed(context, '/auth'));
        // var subscription = future.asStream().listen(doStuffCallback);
        // subscription.cancel();

      }
      // if (status == AnimationStatus.completed) {
      //   controller.reverse();
      // } else if (status == AnimationStatus.dismissed) {
      //   controller.forward();
      // }
    });
    animation1.addStatusListener((status){
      if (status == AnimationStatus.completed) {
        controller1.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _currentIndex++;
        });
        controller1.forward();
      }
    });
    controller.forward();
    controller1.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: _buildBakcgroundImage(),
      ),
      child: Column(
        children: <Widget>[
          FadeTransition(
            opacity: animation,
            child: Center(
              child: Text(
                'Recipes',
                style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 46.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                data[_currentIndex],
                style: TextStyle(
                    fontFamily: 'Chilanka', fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
