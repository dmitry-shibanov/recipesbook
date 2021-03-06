import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipesbook/data/db_helper.dart';
import 'package:recipesbook/services/api.dart';
import 'package:recipesbook/services/provider.dart';
import 'package:sqflite/sqflite.dart';

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
  AnimationController controllerPhrases;
  Animation<double> animation;
  Animation<double> animationPhrases;
  List<String> data = ['Десерты', 'Напитки', 'Кухня', 'Рецепты', 'Закуски'];
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
  dispose() {
    controller.stop();
    controllerPhrases.stop();
    super.dispose();
  }

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 6000), vsync: this);
    controllerPhrases = AnimationController(
        duration: const Duration(milliseconds: 1300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animationPhrases =
        CurvedAnimation(parent: controllerPhrases, curve: Curves.easeIn);
    animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        var future =
            new Future.delayed(const Duration(milliseconds: 1000), () async {

          DatabaseProvider provider = new DatabaseProvider();
          var databasePath = await getDatabasesPath();
          String path = databasePath + "/demo.db";
          await provider.open(path);

          FirebaseUser user = await Api.currentUser;
          if (user == null || user.getIdToken() == null) {
            Navigator.pushReplacementNamed(context, '/auth');
          } else {
            Provider.of(context).my_recipes = await Api.getRecipes();
            Navigator.pushReplacementNamed(context, '/main');
          }
        });

      }
    });
    controllerPhrases.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerPhrases.reverse();
      } else if (status == AnimationStatus.dismissed) {
        var random = Random();

        setState(() {
          _currentIndex = random.nextInt(data.length);
        });
        controllerPhrases.forward();
      }
    });
    controller.forward();
    new Future.delayed(
        const Duration(milliseconds: 2000), () => controllerPhrases.forward());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: _buildBakcgroundImage(),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeTransition(
              opacity: animation,
              child: Text(
                'Recipes',
                style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 76.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            FadeTransition(
              opacity: animationPhrases,
              child: Container(
                  child: Text(
                data[_currentIndex],
                style: TextStyle(
                    fontFamily: 'Chilanka', fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }
}
