import 'package:flutter/material.dart';
import 'package:recipesbook/pages/CreateRecipes/create_recipe.dart';
import 'package:recipesbook/pages/CreateRecipes/custom/camera.dart';
import 'package:recipesbook/pages/CreateRecipes/custom/gallery.dart';
import 'package:recipesbook/pages/ReceiptDescription.dart';
import 'package:recipesbook/pages/auth/auth.dart';
import 'package:recipesbook/pages/logo.dart';
import 'package:recipesbook/pages/products.dart';
import 'package:recipesbook/pages/savedRecipes/saved_resipes.dart';
import 'package:recipesbook/pages/settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recipesbook/pages/user_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
          buttonColor: Colors.deepPurple),
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                MyHomePage(title: 'Recipes'));
      },
      routes: {
        '/': (BuildContext context) => LogoPage(),
        '/auth': (BuildContext context) => AuthPage(),
        '/main': (BuildContext context) =>
            MyHomePage(title: 'Recipes'),
        '/settings': (BuildContext context) => SettingsPage(),
        '/out': (BuildContext context) => null,
        '/saved': (BuildContext context) => SavedRecipes(),
        '/favorite': (BuildContext context) => null,
        '/gallery': (BuildContext context) => Gallery(),
        '/camera': (BuildContext context) => MyCamera()
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductDescription(index));
        }
        return null;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  int _bottomIndex = 0;

  void _createRecipe() {
    setState(() {
      _bottomIndex = 1;
    });
  }

  Widget loadPage() {
    Widget widget = null;
    switch (_bottomIndex) {
      case 0:
        widget = ProductsList();
        break;
      case 1:
        widget = CreateReceipt();
        break;
      case 2:
        widget = UserProfile();
        break;
    }
    return widget;
  }

  void changeIndex(int index) {
    setState(() {
      _bottomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(widget.title),
          bottom: _bottomIndex == 0
              ? TabBar(
                  labelColor: Colors.white,
                  indicatorColor: Colors.green,
                  tabs: [
                    Tab(icon: Icon(Icons.list)),
                    Tab(icon: Icon(Icons.favorite)),
                  ],
                )
              : null,
        ),
        drawer: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Recipes'),
              ),
              ListTile(
                leading: Icon(Icons.save),
                title: Text('Сохраненные'),
                onTap: () {
                  Navigator.pushNamed(context, '/saved');
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings_applications),
                title: Text('Настройки'),
                onTap: () async {
                  bool isOpened = await PermissionHandler().openAppSettings();
                  // Navigator.pushNamed(context, '/settings');
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Выход'),
                onTap: () {
                  Navigator.pushNamed(context, '/products');
                },
              ),
            ],
          ),
        ),
        body: loadPage(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomIndex,
          type: BottomNavigationBarType.fixed,
          onTap: changeIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.view_list), title: Text('list')),
            BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('add')),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle), title: Text('asda'))
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        floatingActionButton: _bottomIndex == 0
            ? FloatingActionButton(
                onPressed: _createRecipe,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
