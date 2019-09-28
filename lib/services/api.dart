import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipesbook/models/Ingredients.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:recipesbook/models/steps.dart';

enum AuthVariant { Anonymously, GoogleSingIn, EmailPassword, NotAuth }

class Api {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  FirebaseUser firebaseUser;

  static Future<List<Recipes>> getRecipes() async {
    List<Recipes> recipes = [];
    (await Firestore.instance.collection('recipes').getDocuments())
        .documents
        .map((item) {
      var recipe = Recipes.fromMap(item.data);
      recipe.documentId = item.documentID;
      recipes.add(Recipes.fromMap(item.data));
    });
    return recipes;
  }

  static Future<List<Ingredients>> getIngredinets() async {
    List<Ingredients> ingredients = (await Firestore.instance.collection('ingredients').getDocuments()).documents.map((item){
      var ingredient = Ingredients.fromMap(item.data);
      return ingredient;
    });

    return ingredients;
  }

  static Future<List<Steps>> getSteps(String path) async {
    List<Steps> steps = [];
    Map<String, dynamic> map =
        (await Firestore.instance.document(path).get()).data;
    T cast<T>(x) => x is T ? x : null;
    List<String> content = (map['content'] as Iterable<dynamic>)
        .map((item) => cast<String>(item))
        .toList();
    List<String> images = (map['images'] as Iterable<dynamic>)
        .map((item) => cast<String>(item))
        .toList();
    for (int i = 0; i < content.length; i++) {
      Steps step = new Steps();
      step.content = content[i];
      step.image = images[i];
      steps.add(step);
    }

    return steps;
  }

  static createRecipe(Recipes recipe) async {
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child("djsakldals");

    final StorageUploadTask uploadTask = storageRef.putFile(
      File(recipe.image),
      StorageMetadata(
        contentType: "image" + '/' + "jpeg",
      ),
    );

    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print('URL Is $url');

    Map<String, dynamic> regionData = new Map<String, dynamic>();
    regionData = recipe.toMap();

    DocumentReference currentRegion =
        Firestore.instance.collection("region").document("asdhkasdka");

    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(currentRegion, regionData);
      print("instance created");
    });
  }

  static void signInAnon() async {
    AuthResult result = await _auth.signInAnonymously();
    print(result.toString());
    FirebaseUser firebaseUser = result.user;
    if (firebaseUser != null) {}
  }

  static Future<void> signOutAnon() async {
    _auth.signOut();
    _googleSignIn.signOut();
  }

  static Future<void> signInWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    final FirebaseUser currentUser = await _auth.currentUser();
    currentUser.delete();
  }
}
