
import 'package:moor_flutter/moor_flutter.dart';
import 'package:recipesbook/models/Ingredients.dart';
import 'package:recipesbook/models/Receipt.dart';
import 'package:recipesbook/models/ReceiptSteps.dart';
import 'package:recipesbook/models/User.dart';

// part 'moor_database.g.dart';
part 'database.g.dart';

// @DataClassName("Ingredients")
// class Ingredient extends Table{
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get ingredient => text()();
// }

// @DataClassName("Recipe")
// class Receipt extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get title => text().withLength(min: 6, max: 17)();
//   TextColumn get content => text().named('body')();
//   IntColumn get ingredients => integer().nullable()();
//   IntColumn get steps => integer().nullable()();
// }

// @DataClassName("Steps")
// class ReceiptSteps extends Table {

//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get description => text()();
//   TextColumn get image => text()();
  
// }

// @DataClassName("Users")
// class User extends Table{
//   TextColumn get email => text().nullable()();
//   TextColumn get password => text().nullable()();
//   TextColumn get token => text().nullable()();
// }

@UseMoor(tables: [Receipt, Ingredient, ReceiptSteps, User])
class MyDatabase extends _$MyDatabase{
  MyDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
        ));

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

Future<List<Steps>> watchCart(int id) {
  // load information about the cart
  // final cartQuery = select(receipt)..where((cart) => cart.id.equals(id));

  // and also load information about the entries in this cart
  final recipeSteps = select(receiptSteps)..where((item) => item.recipe_asoc.equals(id));
  
  return recipeSteps.get();
  // final contentQuery = select(shoppingCartEntries).join(
  //   [
  //     innerJoin(
  //       buyableItems,
  //       buyableItems.id.equalsExp(shoppingCartEntries.item),
  //     ),
  //   ],
  // )..where(shoppingCartEntries.shoppingCart.equals(id));

  // final cartStream = cartQuery.watchSingle();

  // final contentStream = contentQuery.watch().map((rows) {
  //   // we join the shoppingCartEntries with the buyableItems, but we
  //   // only care about the item here.
  //   return rows.map((row) => row.readTable(buyableItems)).toList();
  // });

  // // now, we can merge the two queries together in one stream
  // return Observable.combineLatest2(cartStream, contentStream,
  //     (ShoppingCart cart, List<BuyableItem> items) {
  //   return CartWithItems(cart, items);
  // });
}

  Future<List<Recipes>> get allRecipes => select(receipt).get();
  Future<List<Ingredients>> get allIngredients => select(ingredient).get();
  Future<int> insertRecipe(Insertable<Recipes> recipe) => into(receipt).insert(recipe); 
}

// @UseDao(
//   tables: [Receipt, ReceiptSteps],
// )
// class RecipeDao extends DatabaseAccessor<MyDatabase> {
//   RecipeDao(MyDatabase db) : super(db);
  
// }

// @UseDao(tables: [ReceiptSteps])
// class IngredientDao extends DatabaseAccessor<MyDatabase> {
//   IngredientDao(MyDatabase db) : super(db);

