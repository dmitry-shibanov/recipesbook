import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'dart:math' as math;

class ProductDescription extends StatefulWidget {
  final int _index;
  ProductDescription(this._index);
  final PageController Page_controller = PageController(initialPage: 0);
  var currentPageValue = 0.0;

  @override
  State<StatefulWidget> createState() {
    return ProductDescriptionState();
  }
}

class ProductDescriptionState extends State<ProductDescription>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 256,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Our recipe'),
            background: Hero(
              tag: 'image_hero0',
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('public/food.jpg'),
                image: AssetImage('public/food.jpg'),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Text(
              'Описание',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Text(
                  'Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure officia hic blanditiis voluptates pariatur atque, id, in eos laudantium natus nihil obcaecati deleniti possimus voluptate, quia necessitatibus? Obcaecati, laboriosam ratione!'),
            ),
            Text(
              'Ингедиенты',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            buildIngredients(),
            Text(
              'Шаги',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text(
                """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce viverra purus neque, vitae commodo orci gravida ut. Sed at sem interdum, ullamcorper elit ut, bibendum ipsum. Sed non imperdiet velit. Nam quis elit id eros pharetra iaculis. Sed vulputate quam quis est pharetra, quis molestie urna dignissim. Donec ut urna maximus lorem tempor hendrerit vitae a purus. Nullam id tristique ligula. Duis vel varius augue. Ut mauris velit, rutrum non mollis eu, fermentum vitae nisi. Aenean lacus nisi, convallis vel tortor in, interdum pretium ex. Proin nec ultricies nibh, vitae varius ipsum. Donec lacinia turpis non porta elementum. Nunc augue ante, hendrerit et elit convallis, convallis commodo nulla. Suspendisse eget bibendum lectus, eu finibus sapien. Aenean a viverra eros. In aliquam leo non ligula maximus, id tempor mauris consequat.

Nullam tempor, risus vel scelerisque hendrerit, quam metus consequat mi, eget efficitur ante enim interdum quam. Nullam nibh augue, placerat nec auctor ac, euismod et leo. Aenean sit amet orci et augue posuere pretium. Maecenas at dignissim orci, non consectetur nibh. Suspendisse nec ligula et velit malesuada hendrerit sit amet a neque. Nulla at nisl elit. Pellentesque vel libero erat. In pharetra pharetra iaculis. Vivamus aliquam tristique sapien, nec porttitor nisl aliquam non. Duis tempor a erat ut efficitur. Nulla interdum ac dolor sed maximus. In accumsan nisl et felis cursus lobortis. Nulla ex ipsum, interdum quis malesuada at, facilisis in dui. Donec consectetur turpis enim, et mattis enim scelerisque in.

Morbi imperdiet, sapien ac dictum porta, quam quam efficitur urna, ut volutpat libero augue quis erat. Nulla euismod dolor a libero maximus, vitae posuere nisl dignissim. Quisque a quam dui. Suspendisse placerat eros non facilisis sagittis. Phasellus nisl magna, mollis non fringilla sed, molestie non ex. Aenean euismod, sapien ut pulvinar dapibus, eros dolor aliquet magna, sed condimentum ex metus eu lacus. Nunc hendrerit lacus efficitur tincidunt malesuada. Vivamus tincidunt blandit neque eget condimentum. Phasellus sodales libero orci, pharetra egestas massa iaculis at. In luctus odio et enim bibendum venenatis. Donec consectetur tincidunt ipsum nec ultrices.

Suspendisse potenti. Aliquam blandit diam ut tempor ultrices. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse laoreet cursus mauris, quis rhoncus dui tempor eget. Donec nisi ante, vestibulum ultrices ex quis, malesuada hendrerit leo. In bibendum ultrices nisl, quis convallis erat pharetra vitae. Duis dictum vehicula mi, a finibus leo facilisis in. Aenean tincidunt elit pulvinar rutrum pharetra.

Nullam vitae aliquam quam. Phasellus et ex rhoncus, ullamcorper lorem id, ornare ex. Vestibulum consequat ex vel urna imperdiet imperdiet. Vestibulum volutpat convallis dolor ac facilisis. Donec euismod, leo in congue fermentum, dolor sem fringilla ex, nec eleifend augue nulla nec odio. Proin efficitur orci sit amet malesuada facilisis. Morbi accumsan dui tellus, nec efficitur nibh posuere sit amet. Donec tincidunt aliquam faucibus. Phasellus quis mi mollis velit tincidunt imperdiet id id ante. Sed sit amet turpis placerat, molestie nibh at, venenatis sem. Etiam eu sapien risus. Quisque vel orci ut felis lobortis congue.

Sed facilisis in nibh varius fermentum. Fusce fermentum mauris diam, ac ullamcorper odio interdum auctor. Proin feugiat non libero non lobortis. In eleifend accumsan lacus nec rutrum. Ut et neque diam. Nulla vel justo interdum, ornare libero ut, ultricies libero. Vivamus efficitur orci vitae malesuada tincidunt. Ut feugiat pellentesque tempor. Donec pretium venenatis venenatis. Etiam pharetra vitae tortor vel ullamcorper. Duis iaculis ante massa, eget fringilla ligula congue eu. Aenean aliquet id ligula eget fermentum. Pellentesque placerat hendrerit purus at iaculis.

Curabitur iaculis laoreet volutpat. Ut tristique iaculis ipsum ut varius. Cras ultrices luctus turpis a sodales. Nam nisl dolor, laoreet mattis laoreet a, vestibulum vehicula ligula. Pellentesque vehicula felis at massa convallis, et porta sem dictum. Sed ut faucibus enim. Praesent sit amet lacinia dolor, luctus ultrices quam. Ut non placerat dolor. In sagittis luctus interdum. Curabitur fringilla tortor et scelerisque laoreet. Cras arcu ipsum, eleifend aliquam faucibus sed, dignissim nec dui. Nullam sollicitudin metus turpis, id suscipit tellus consectetur id.

Mauris pulvinar vestibulum lacus, in accumsan felis finibus eu. Praesent tincidunt ex sit amet felis fringilla, non sagittis ex tempor. Fusce et nulla volutpat massa mattis dictum. Praesent mattis leo quis felis sagittis consectetur. Donec sodales suscipit augue. Suspendisse leo odio, fermentum eget ante id, vestibulum consectetur tellus. Sed porttitor tortor sed dui fermentum, a sodales tellus rhoncus. Cras sed nibh accumsan, fermentum ex vitae, dapibus arcu. Donec est tortor, ultricies sit amet mauris a, laoreet maximus sem. Proin fringilla ultrices tellus, quis cursus dolor tempus blandit. Donec egestas lectus sit amet nunc tincidunt imperdiet. Curabitur varius luctus elit, in suscipit purus semper in. Morbi mattis euismod lectus, a scelerisque ante. Donec lacus eros, tincidunt quis nunc eget, malesuada vestibulum ipsum. Praesent ullamcorper hendrerit justo eu euismod."""),
            Container(
              // flex: 1,
              height: MediaQuery.of(context).size.height / 2,
              child: PageView.builder(
                // controller: controller,
                itemBuilder: _stepReceipt,
                itemCount: 10,
                // scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/12,)
          ]),
        )
      ]),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
                scale: CurvedAnimation(
                    curve: Interval(0.0, 1.0, curve: Curves.easeOut),
                    parent: controller),
                child: FloatingActionButton(
                  heroTag: 'favorite',
                  mini: true,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () => null,
                )),
          ),
          Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                  parent: controller,
                  curve: Interval(0.0, 1.0, curve: Curves.easeOut)),
              child: FloatingActionButton(
                heroTag: 'save_recipe',
                mini: true,
                backgroundColor: Theme.of(context).cardColor,
                child: Icon(
                  Icons.save,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () => null,
              ),
            ),
          ),
          Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: FloatingActionButton(
                heroTag: 'more_vert',
                child: AnimatedBuilder(
                  builder: (BuildContext context, Widget child) {
                    return Transform(
                      alignment: FractionalOffset.center,
                      transform:
                          Matrix4.rotationZ(controller.value * 0.5 * math.pi),
                      child: Icon(controller.isDismissed
                          ? Icons.more_vert
                          : Icons.close),
                    );
                  },
                  animation: controller,
                ),
                onPressed: () {
                  if (controller.isDismissed) {
                    controller.forward();
                  } else {
                    controller.reverse();
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget buildIngredients() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          FittedBox(
            child: Text(
              'Гриль',
              textAlign: TextAlign.start,
            ),
          ),
          FittedBox(
            child: Text(
              '12 гр',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepReceipt(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: <Widget>[
          Image.asset('public/food.jpg'),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure officia hic blanditiis voluptates pariatur atque, id, in eos laudantium natus nihil obcaecati deleniti possimus voluptate, quia necessitatibus? Obcaecati, laboriosam ratione!',
            ),
          ),
        ],
      ),
    );
  }
}
