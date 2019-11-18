import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipesbook/models/Ingredients.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:recipesbook/models/steps.dart';

// https://stackoverflow.com/questions/49241477/how-can-i-populate-the-reference-field-using-firestore
enum AuthVariant { Anonymously, GoogleSingIn, EmailPassword, NotAuth }

class Api {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  FirebaseUser firebaseUser;

  static Future<FirebaseUser> get currentUser async => _auth.currentUser();

  static Future<List<Recipes>> getRecipes() async {
    List<Recipes> recipes = [];
    // List<DocumentSnapshot> docs =
    //     (await Firestore.instance.collection('recipes').getDocuments())
    //         .documents;
    // StreamBuilder builder = new StreamBuilder(
    //   builder: ,
    // );

    (await Firestore.instance.collection('recipes').getDocuments())
        .documents
        .forEach((item) async {
      var recipe = Recipes.fromJson(item.data);
      recipe.documentId = item.documentID;
      recipe.path = item.data['steps'].path;
      final StorageReference ref =
        FirebaseStorage.instance.ref().child(item.data['image']);
      recipe.image = await ref.getDownloadURL();
      // recipe.steps = await Api.getSteps(item.data['steps'].path);
      recipes.add(recipe);
    });

    return recipes;
  }

// save cache images
  Future<File> _saveToTemporaryDirectory(String name) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print(androidInfo.hardware);

    final Directory temp = await getTemporaryDirectory();
    final File imageFile = File('${temp.path}/images/someImageFile.png');

    if (await imageFile.exists()) {
      return imageFile;
    } else {
      // Image doesn't exist in cache
      await imageFile.create(recursive: true);
      // Download the image and write to above file
    }

    return null;
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
          final StorageReference ref =
        FirebaseStorage.instance.ref().child(images[i]);
      step.image = await ref.getDownloadURL();

    // Stream stream = Stream.fromFuture(ref.getDownloadURL());
      steps.add(step);
    }

    return steps;
  }
  // https://stackoverflow.com/questions/51857796/flutter-upload-image-to-firebase-storage
//https://stackoverflow.com/questions/50877398/flutter-load-image-from-firebase-storage
  // static createRecipe(Recipes recipe) async {
  static createRecipe(String image) async {
    // Firestore.instance
    //                 .collection("users").orderBy(field).where("ingredients",arrayContains: "ingredient")

    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child("doprot/djsakldals");

    final StorageUploadTask uploadTask = storageRef.putFile(
      File(image),
      StorageMetadata(
        contentType: "image" + '/' + "jpeg",
      ),
    );
//https://firebasestorage.googleapis.com/v0/b/flutter-univer-work.appspot.com/o/doprot%2Fdjsakldals?alt=media&token=68809744-ac23-4a5d-b3a3-f315bc6bc9e3
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

  static Future<void> signOut() {
    return _auth.signOut();
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

  static Future<FirebaseUser> handleSignInEmail(
      String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final FirebaseUser user = result.user;

    if (user == null || await user.getIdToken() == null) {
      return null;
    }

    final FirebaseUser currentUser = await _auth.currentUser();

    return user;
  }

  static Future<FirebaseUser> handleSignUp(email, password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final FirebaseUser user = result.user;

    if (user == null || await user.getIdToken() == null) {
      return null;
    }

    return user;
  }
}
