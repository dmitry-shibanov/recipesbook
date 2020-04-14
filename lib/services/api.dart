import 'dart:async';
import 'dart:io';

import 'package:firebase/firebase.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:device_info/device_info.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipesbook/models/Ingredients.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:recipesbook/models/steps.dart';

enum AuthVariant { Anonymously, GoogleSingIn, EmailPassword, NotAuth }

class Api {
  static Auth _auth = auth();
  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  User firebaseUser;

  static Future<User> get currentUser async => _auth?.currentUser;

  static Future<List<Recipes>> getRecipes() async {
    List<Recipes> recipes = [];

    (await Firestore.instance.collection('recipes').getDocuments())
        .documents
        .forEach((item) async {
      var recipe = Recipes.fromJson(item.data);
      recipe.documentId = item.documentID;
      recipe.path = item.data['steps'].path;
      final ref =
        FirebaseStorage.instance.ref().child(item.data['image']);
      recipe.image = await ref.getDownloadURL();
      // recipe.steps = await Api.getSteps(item.data['steps'].path);
      recipes.add(recipe);
    });

    return recipes;
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
      step.pathImage = images[i];
          final ref =
        FirebaseStorage.instance.ref().child(images[i]);
      step.image = await ref.getDownloadURL();

    // Stream stream = Stream.fromFuture(ref.getDownloadURL());
      steps.add(step);
    }

    return steps;
  }

  // static createRecipe(Recipes recipe) async {
  static createRecipe(String image) async {
    // Firestore.instance
    //                 .collection("users").orderBy(field).where("ingredients",arrayContains: "ingredient")

    final storageRef =
        FirebaseStorage.instance.ref().child("doprot/djsakldals");

    final StorageUploadTask uploadTask = storageRef.putFile(
      File(image),
      StorageMetadata(
        contentType: "image" + '/' + "jpeg",
      ),
    );

    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    print(downloadUrl.uploadSessionUri.path);
    print(downloadUrl.toString());

    print(downloadUrl.storageMetadata.path);

    // final String url = (await downloadUrl.ref.getDownloadURL());
    // print('URL Is $url');

    // Map<String, dynamic> regionData = new Map<String, dynamic>();
    // regionData = recipe.toMap();

    // DocumentReference currentRegion =
    //     Firestore.instance.collection("region").document("asdhkasdka");

    // Firestore.instance.runTransaction((transaction) async {
    //   await transaction.set(currentRegion, regionData);
    //   print("instance created");
    // });
  }

  // static void signInAnon() async {
  //   AuthResult result = await _auth.signInAnonymously();
  //   print(result.toString());
  //   FirebaseUser firebaseUser = result.user;
  //   if (firebaseUser != null) {}
  // }

  static Future<void> signOutAnon() async {
    _auth.signOut();
    _googleSignIn.signOut();
  }

  static Future<void> signOut() {
    return _auth.signOut();
  }

  static Future<void> signInWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      googleAuth.idToken,googleAuth.accessToken
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    final User currentUser = await _auth.currentUser;
    currentUser.delete();
  }

  static Future<User> handleSignInEmail(
      String email, String password) async {
         UserCredential result;
        try{
     result = await _auth.signInWithEmailAndPassword(
        email,  password);
        }catch(e){
print('Error in sign in with credentials: $e');
        }
    final User user = result.user;

    if (user == null || await user.getIdToken() == null) {
      return null;
    }

    final User currentUser = await _auth.currentUser;

    return user;
  }

  static Future<User> handleSignUp(email, password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
         email,  password);
    final user = result.user;

    if (user == null || await user.getIdToken() == null) {
      return null;
    }

    return user;
  }
}
