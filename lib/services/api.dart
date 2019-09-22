import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipesbook/models/recipes.dart';
import 'package:recipesbook/models/steps.dart';

enum AuthVariant { Anonymously, GoogleSingIn, EmailPassword, NotAuth }

class Api {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  FirebaseUser firebaseUser;

  // Api(this.firebaseUser);
  // List<DocumentSnapshot> d =await Api.getRecipes();
  // print(d);
  // DocumentSnapshot d1 = await Api.getSteps(d[0].data['steps'].path);
  // print(d1);
  // static Future<List<DocumentSnapshot>> getRecipes() async {
  //   (await Firestore.instance.collection('recipes').getDocuments()).documents.map((item){
  //     print("asdsadsadassadasasd"+item.data['image']);
  //     print(item.data['content']);
  //     print(item.data['steps']);
  //     print(item.data['title']);
  //   });
  //   return (await Firestore.instance.collection('recipes').getDocuments()).documents;
  // }

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

  // static Future<DocumentSnapshot> getSteps(String path) async {
  //   return (await Firestore.instance.document(path).get());
  // }

  static Future<List<Steps>> getSteps(String path) async {
    List<Steps> steps = [];
    Map<String, dynamic> map =
        (await Firestore.instance.document(path).get()).data;
    List<String> content = map['content'];
    List<String> images = map['images'];
    for (int i = 0; i < content.length; i++) {
      Steps step = new Steps();
      step.content = content[i];
      step.image = images[i];
      steps.add(step);
    }

    return steps;
  }

  static createRecipe() async {
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child("sadsadasdsa");

// final StorageUploadTask uploadTask = storageRef.putFile(
//       File(filePath),
//       StorageMetadata(
//         contentType: type + '/' + extension,
//       ),
//     );

//     final StorageTaskSnapshot downloadUrl =
// (await uploadTask.onComplete);
// final String url = (await downloadUrl.ref.getDownloadURL());
// print('URL Is $url');

    Map<String, dynamic> regionData = new Map<String, dynamic>();
    regionData["title"] = "_textController.text;";

    // regionData["image"] = ;

    // DocumentReference currentRegion =
    //     Firestore.instance.collection("region").document(fileName);

    // Firestore.instance.runTransaction((transaction) async {
    //   await transaction.set(currentRegion, regionData);
    print("instance created");
    // });
    // await Firestore.instance.collection('recipes')
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

  // static Future<Api> signInWithGoogle() async{
  //   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  // }
}
