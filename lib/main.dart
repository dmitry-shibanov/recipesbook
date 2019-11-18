import 'package:flutter/material.dart';
import 'package:recipesbook/pages/CreateRecipes/create_recipe.dart';
import 'package:recipesbook/pages/CreateRecipes/custom/camera.dart';
import 'package:recipesbook/pages/CreateRecipes/custom/gallery.dart';
import 'package:recipesbook/pages/ReceiptDescription.dart';
import 'package:recipesbook/pages/auth/auth.dart';
import 'package:recipesbook/pages/logo.dart';
import 'package:recipesbook/pages/products.dart';
import 'package:recipesbook/pages/settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recipesbook/pages/user_profile.dart';
import 'package:recipesbook/services/api.dart';
import 'package:recipesbook/services/provider.dart';

import 'helpers/custom_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurple),
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage(title: 'Recipes'));
        },
        routes: {
          '/': (BuildContext context) => LogoPage(),
          '/auth': (BuildContext context) => AuthPage(),
          '/main': (BuildContext context) => MyHomePage(title: 'Recipes'),
          '/settings': (BuildContext context) => SettingsPage(),
          '/out': (BuildContext context) => null,
          // '/saved': (BuildContext context) {
          //   final _db = new MyDatabase();
          //   List<Steps> steps;
          //   //  _db.watchCart(id)
          //   List<Recipes> all;
          //   _db.allRecipes.then((recipes) {
          //     all = recipes;
          //     _db.watchCart(all[all.length - 1].id).then((step) {
          //       steps = step;
          //       return SavedRecipes(all, steps);
          //     });
          //   });
          // },
          '/favorite': (BuildContext context) => null,
          '/gallery': (BuildContext context) => Gallery(),
          '/camera': (BuildContext context) => MyCamera()
        },
        // onGenerateRoute: (RouteSettings settings) {
        //   final List<String> pathElements = settings.name.split('/');
        //   if (pathElements[0] != '') {
        //     return null;
        //   }
        //   if (pathElements[1] == 'product') {
        //     final int index = int.parse(pathElements[2]);
        //     return CustomRoute<bool>(
        //         builder: (BuildContext context) => ProductDescription.fromDB(index));
        //   }
        //   return null;
        // },
      ),
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

  Widget appBarTitle = new Text(
    "Рецепты",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _IsSearching;
  String _searchText = "";

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  void _createRecipe() {
    setState(() {
      _bottomIndex = 1;
    });
  }

  // https://medium.com/@lucassaltoncardinali/keeping-state-with-the-bottom-navigation-bar-in-flutter-69e4168878e1
//https://stackoverflow.com/questions/49966980/how-to-create-toolbar-searchview-in-flutter
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

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Рецепты",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          actions: <Widget>[
            _bottomIndex == 0
                ? new IconButton(
                    icon: actionIcon,
                    onPressed: () {
                      setState(() {
                        if (this.actionIcon.icon == Icons.search) {
                          this.actionIcon = new Icon(
                            Icons.close,
                            color: Colors.white,
                          );
                          this.appBarTitle = new TextField(
                            controller: _searchQuery,
                            style: new TextStyle(
                              color: Colors.white,
                            ),
                            decoration: new InputDecoration(
                                prefixIcon:
                                    new Icon(Icons.search, color: Colors.white),
                                hintText: "Search...",
                                hintStyle: new TextStyle(color: Colors.white)),
                          );
                          _handleSearchStart();
                        } else {
                          _handleSearchEnd();
                        }
                      });
                    },
                  )
                : Container(),
          ],
          title: appBarTitle,
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
                onTap: () async {
                  await Api.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/auth', (Route<dynamic> route) => false);
                  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  // LoginScreen()), (Route<dynamic> route) => false),
                  // Navigator.of(context).popUntil(ModalRoute.withName('/root'));
                  // Navigator.pushNamed(context, '/products');
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
