import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recipesbook/data/db_helper.dart';
import 'package:recipesbook/models/Ingredients.dart';
import 'package:recipesbook/models/Metrics.dart';
import 'package:recipesbook/services/api.dart';
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
          // Api.signOutAnon();
          DatabaseProvider provider = new DatabaseProvider();
          var databasePath = await await getDatabasesPath();
          String path = databasePath + "/demo.db";
          await provider.open(path);
          int ingredientsLength = (await provider.getIngredients()).length;
          List<Ingredients> ingredients = await Api.getIngredinets();
          List<Metrics> metrics = await Api.getMetrics();
          int metricsLength = (await provider.getIngredients()).length;
          if (ingredients.length>ingredientsLength) {
            provider.insertIngredients(ingredients);
          }
          if (metrics.length<metricsLength){
            provider.insertMetrics(metrics);
          }

          Navigator.pushReplacementNamed(context, '/auth');
        });
        // var subscription = future.asStream().listen(doStuffCallback);
        // subscription.cancel();

      }
      // if (status == AnimationStatus.completed) {
      //   controller.reverse();
      // } else if (status == AnimationStatus.dismissed) {
      //   controller.forward();
      // }
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
                  // alignment: Alignment.bottomCenter,
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
