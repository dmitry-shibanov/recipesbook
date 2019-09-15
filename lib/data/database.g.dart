// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Recipes extends DataClass implements Insertable<Recipes> {
  final int id;
  final String title;
  final String content;
  final int ingredients;
  final int steps;
  Recipes(
      {@required this.id,
      @required this.title,
      @required this.content,
      this.ingredients,
      this.steps});
  factory Recipes.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Recipes(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}body']),
      ingredients: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}ingredients']),
      steps: intType.mapFromDatabaseResponse(data['${effectivePrefix}steps']),
    );
  }
  factory Recipes.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Recipes(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      ingredients: serializer.fromJson<int>(json['ingredients']),
      steps: serializer.fromJson<int>(json['steps']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'ingredients': serializer.toJson<int>(ingredients),
      'steps': serializer.toJson<int>(steps),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Recipes>>(bool nullToAbsent) {
    return ReceiptCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      ingredients: ingredients == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredients),
      steps:
          steps == null && nullToAbsent ? const Value.absent() : Value(steps),
    ) as T;
  }

  Recipes copyWith(
          {int id, String title, String content, int ingredients, int steps}) =>
      Recipes(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        ingredients: ingredients ?? this.ingredients,
        steps: steps ?? this.steps,
      );
  @override
  String toString() {
    return (StringBuffer('Recipes(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('ingredients: $ingredients, ')
          ..write('steps: $steps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              content.hashCode, $mrjc(ingredients.hashCode, steps.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Recipes &&
          other.id == id &&
          other.title == title &&
          other.content == content &&
          other.ingredients == ingredients &&
          other.steps == steps);
}

class ReceiptCompanion extends UpdateCompanion<Recipes> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<int> ingredients;
  final Value<int> steps;
  const ReceiptCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.steps = const Value.absent(),
  });
  ReceiptCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> content,
      Value<int> ingredients,
      Value<int> steps}) {
    return ReceiptCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
    );
  }
}

class $ReceiptTable extends Receipt with TableInfo<$ReceiptTable, Recipes> {
  final GeneratedDatabase _db;
  final String _alias;
  $ReceiptTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 6, maxTextLength: 17);
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedTextColumn _content;
  @override
  GeneratedTextColumn get content => _content ??= _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn(
      'body',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ingredientsMeta =
      const VerificationMeta('ingredients');
  GeneratedIntColumn _ingredients;
  @override
  GeneratedIntColumn get ingredients =>
      _ingredients ??= _constructIngredients();
  GeneratedIntColumn _constructIngredients() {
    return GeneratedIntColumn(
      'ingredients',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stepsMeta = const VerificationMeta('steps');
  GeneratedIntColumn _steps;
  @override
  GeneratedIntColumn get steps => _steps ??= _constructSteps();
  GeneratedIntColumn _constructSteps() {
    return GeneratedIntColumn(
      'steps',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, ingredients, steps];
  @override
  $ReceiptTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'receipt';
  @override
  final String actualTableName = 'receipt';
  @override
  VerificationContext validateIntegrity(ReceiptCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.content.present) {
      context.handle(_contentMeta,
          content.isAcceptableValue(d.content.value, _contentMeta));
    } else if (content.isRequired && isInserting) {
      context.missing(_contentMeta);
    }
    if (d.ingredients.present) {
      context.handle(_ingredientsMeta,
          ingredients.isAcceptableValue(d.ingredients.value, _ingredientsMeta));
    } else if (ingredients.isRequired && isInserting) {
      context.missing(_ingredientsMeta);
    }
    if (d.steps.present) {
      context.handle(
          _stepsMeta, steps.isAcceptableValue(d.steps.value, _stepsMeta));
    } else if (steps.isRequired && isInserting) {
      context.missing(_stepsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipes map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Recipes.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ReceiptCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.content.present) {
      map['body'] = Variable<String, StringType>(d.content.value);
    }
    if (d.ingredients.present) {
      map['ingredients'] = Variable<int, IntType>(d.ingredients.value);
    }
    if (d.steps.present) {
      map['steps'] = Variable<int, IntType>(d.steps.value);
    }
    return map;
  }

  @override
  $ReceiptTable createAlias(String alias) {
    return $ReceiptTable(_db, alias);
  }
}

class Ingredients extends DataClass implements Insertable<Ingredients> {
  final int id;
  final String ingredient;
  Ingredients({@required this.id, @required this.ingredient});
  factory Ingredients.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Ingredients(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      ingredient: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}ingredient']),
    );
  }
  factory Ingredients.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Ingredients(
      id: serializer.fromJson<int>(json['id']),
      ingredient: serializer.fromJson<String>(json['ingredient']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'ingredient': serializer.toJson<String>(ingredient),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Ingredients>>(bool nullToAbsent) {
    return IngredientCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      ingredient: ingredient == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredient),
    ) as T;
  }

  Ingredients copyWith({int id, String ingredient}) => Ingredients(
        id: id ?? this.id,
        ingredient: ingredient ?? this.ingredient,
      );
  @override
  String toString() {
    return (StringBuffer('Ingredients(')
          ..write('id: $id, ')
          ..write('ingredient: $ingredient')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, ingredient.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Ingredients &&
          other.id == id &&
          other.ingredient == ingredient);
}

class IngredientCompanion extends UpdateCompanion<Ingredients> {
  final Value<int> id;
  final Value<String> ingredient;
  const IngredientCompanion({
    this.id = const Value.absent(),
    this.ingredient = const Value.absent(),
  });
  IngredientCompanion copyWith({Value<int> id, Value<String> ingredient}) {
    return IngredientCompanion(
      id: id ?? this.id,
      ingredient: ingredient ?? this.ingredient,
    );
  }
}

class $IngredientTable extends Ingredient
    with TableInfo<$IngredientTable, Ingredients> {
  final GeneratedDatabase _db;
  final String _alias;
  $IngredientTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _ingredientMeta = const VerificationMeta('ingredient');
  GeneratedTextColumn _ingredient;
  @override
  GeneratedTextColumn get ingredient => _ingredient ??= _constructIngredient();
  GeneratedTextColumn _constructIngredient() {
    return GeneratedTextColumn(
      'ingredient',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, ingredient];
  @override
  $IngredientTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'ingredient';
  @override
  final String actualTableName = 'ingredient';
  @override
  VerificationContext validateIntegrity(IngredientCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.ingredient.present) {
      context.handle(_ingredientMeta,
          ingredient.isAcceptableValue(d.ingredient.value, _ingredientMeta));
    } else if (ingredient.isRequired && isInserting) {
      context.missing(_ingredientMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingredients map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Ingredients.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(IngredientCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.ingredient.present) {
      map['ingredient'] = Variable<String, StringType>(d.ingredient.value);
    }
    return map;
  }

  @override
  $IngredientTable createAlias(String alias) {
    return $IngredientTable(_db, alias);
  }
}

class Steps extends DataClass implements Insertable<Steps> {
  final int id;
  final String description;
  final String image;
  final int recipe_asoc;
  Steps(
      {@required this.id,
      @required this.description,
      @required this.image,
      @required this.recipe_asoc});
  factory Steps.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Steps(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      recipe_asoc: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}recipe_asoc']),
    );
  }
  factory Steps.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Steps(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      image: serializer.fromJson<String>(json['image']),
      recipe_asoc: serializer.fromJson<int>(json['recipe_asoc']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
      'image': serializer.toJson<String>(image),
      'recipe_asoc': serializer.toJson<int>(recipe_asoc),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Steps>>(bool nullToAbsent) {
    return ReceiptStepsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      recipe_asoc: recipe_asoc == null && nullToAbsent
          ? const Value.absent()
          : Value(recipe_asoc),
    ) as T;
  }

  Steps copyWith({int id, String description, String image, int recipe_asoc}) =>
      Steps(
        id: id ?? this.id,
        description: description ?? this.description,
        image: image ?? this.image,
        recipe_asoc: recipe_asoc ?? this.recipe_asoc,
      );
  @override
  String toString() {
    return (StringBuffer('Steps(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('image: $image, ')
          ..write('recipe_asoc: $recipe_asoc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          description.hashCode, $mrjc(image.hashCode, recipe_asoc.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Steps &&
          other.id == id &&
          other.description == description &&
          other.image == image &&
          other.recipe_asoc == recipe_asoc);
}

class ReceiptStepsCompanion extends UpdateCompanion<Steps> {
  final Value<int> id;
  final Value<String> description;
  final Value<String> image;
  final Value<int> recipe_asoc;
  const ReceiptStepsCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.image = const Value.absent(),
    this.recipe_asoc = const Value.absent(),
  });
  ReceiptStepsCompanion copyWith(
      {Value<int> id,
      Value<String> description,
      Value<String> image,
      Value<int> recipe_asoc}) {
    return ReceiptStepsCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      image: image ?? this.image,
      recipe_asoc: recipe_asoc ?? this.recipe_asoc,
    );
  }
}

class $ReceiptStepsTable extends ReceiptSteps
    with TableInfo<$ReceiptStepsTable, Steps> {
  final GeneratedDatabase _db;
  final String _alias;
  $ReceiptStepsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  final VerificationMeta _recipe_asocMeta =
      const VerificationMeta('recipe_asoc');
  GeneratedIntColumn _recipe_asoc;
  @override
  GeneratedIntColumn get recipe_asoc => _recipe_asoc ??= _constructRecipeAsoc();
  GeneratedIntColumn _constructRecipeAsoc() {
    return GeneratedIntColumn(
      'recipe_asoc',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, description, image, recipe_asoc];
  @override
  $ReceiptStepsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'receipt_steps';
  @override
  final String actualTableName = 'receipt_steps';
  @override
  VerificationContext validateIntegrity(ReceiptStepsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.image.present) {
      context.handle(
          _imageMeta, image.isAcceptableValue(d.image.value, _imageMeta));
    } else if (image.isRequired && isInserting) {
      context.missing(_imageMeta);
    }
    if (d.recipe_asoc.present) {
      context.handle(_recipe_asocMeta,
          recipe_asoc.isAcceptableValue(d.recipe_asoc.value, _recipe_asocMeta));
    } else if (recipe_asoc.isRequired && isInserting) {
      context.missing(_recipe_asocMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Steps map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Steps.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ReceiptStepsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.image.present) {
      map['image'] = Variable<String, StringType>(d.image.value);
    }
    if (d.recipe_asoc.present) {
      map['recipe_asoc'] = Variable<int, IntType>(d.recipe_asoc.value);
    }
    return map;
  }

  @override
  $ReceiptStepsTable createAlias(String alias) {
    return $ReceiptStepsTable(_db, alias);
  }
}

class Users extends DataClass implements Insertable<Users> {
  final String email;
  final String password;
  final String token;
  Users({this.email, this.password, this.token});
  factory Users.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Users(
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      token:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}token']),
    );
  }
  factory Users.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Users(
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      token: serializer.fromJson<String>(json['token']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'token': serializer.toJson<String>(token),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Users>>(bool nullToAbsent) {
    return UserCompanion(
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
    ) as T;
  }

  Users copyWith({String email, String password, String token}) => Users(
        email: email ?? this.email,
        password: password ?? this.password,
        token: token ?? this.token,
      );
  @override
  String toString() {
    return (StringBuffer('Users(')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('token: $token')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(email.hashCode, $mrjc(password.hashCode, token.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Users &&
          other.email == email &&
          other.password == password &&
          other.token == token);
}

class UserCompanion extends UpdateCompanion<Users> {
  final Value<String> email;
  final Value<String> password;
  final Value<String> token;
  const UserCompanion({
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.token = const Value.absent(),
  });
  UserCompanion copyWith(
      {Value<String> email, Value<String> password, Value<String> token}) {
    return UserCompanion(
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }
}

class $UserTable extends User with TableInfo<$UserTable, Users> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserTable(this._db, [this._alias]);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      true,
    );
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn(
      'password',
      $tableName,
      true,
    );
  }

  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  GeneratedTextColumn _token;
  @override
  GeneratedTextColumn get token => _token ??= _constructToken();
  GeneratedTextColumn _constructToken() {
    return GeneratedTextColumn(
      'token',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [email, password, token];
  @override
  $UserTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'user';
  @override
  final String actualTableName = 'user';
  @override
  VerificationContext validateIntegrity(UserCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.email.present) {
      context.handle(
          _emailMeta, email.isAcceptableValue(d.email.value, _emailMeta));
    } else if (email.isRequired && isInserting) {
      context.missing(_emailMeta);
    }
    if (d.password.present) {
      context.handle(_passwordMeta,
          password.isAcceptableValue(d.password.value, _passwordMeta));
    } else if (password.isRequired && isInserting) {
      context.missing(_passwordMeta);
    }
    if (d.token.present) {
      context.handle(
          _tokenMeta, token.isAcceptableValue(d.token.value, _tokenMeta));
    } else if (token.isRequired && isInserting) {
      context.missing(_tokenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Users map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Users.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UserCompanion d) {
    final map = <String, Variable>{};
    if (d.email.present) {
      map['email'] = Variable<String, StringType>(d.email.value);
    }
    if (d.password.present) {
      map['password'] = Variable<String, StringType>(d.password.value);
    }
    if (d.token.present) {
      map['token'] = Variable<String, StringType>(d.token.value);
    }
    return map;
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $ReceiptTable _receipt;
  $ReceiptTable get receipt => _receipt ??= $ReceiptTable(this);
  $IngredientTable _ingredient;
  $IngredientTable get ingredient => _ingredient ??= $IngredientTable(this);
  $ReceiptStepsTable _receiptSteps;
  $ReceiptStepsTable get receiptSteps =>
      _receiptSteps ??= $ReceiptStepsTable(this);
  $UserTable _user;
  $UserTable get user => _user ??= $UserTable(this);
  @override
  List<TableInfo> get allTables => [receipt, ingredient, receiptSteps, user];
}
