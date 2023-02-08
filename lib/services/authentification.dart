import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:invoice_builder/models/usr_invoice.dart';
import 'package:invoice_builder/shared/firestore_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthentificationStatus {
  uinitialized,
  authentificated,
  authentificating,
  authentificateError,
  authentificateCanceled,
}

class AuthentificationProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences preferences;
  final GoogleSignIn googleSignIn;

  AuthentificationStatus _status = AuthentificationStatus.uinitialized;
  AuthentificationStatus get status => _status;

  AuthentificationProvider(
      {required this.firebaseAuth,
      required this.googleSignIn,
      required this.preferences,
      required this.firebaseFirestore});

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn && preferences.getString(FirestoreConstantsKey.id)?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleSignIn() async {
    _status = AuthentificationStatus.authentificating;
    notifyListeners();
    GoogleSignInAccount? user = await googleSignIn.signIn();
    if (user != null) {
      GoogleSignInAuthentication? googleAuth = await user.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      User? firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;
      if (firebaseUser != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstantsKey.userCollectionPath)
            .where(FirestoreConstantsKey.id, isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.isEmpty) {
          firebaseFirestore
              .collection(FirestoreConstantsKey.userCollectionPath)
              .doc(firebaseUser.uid)
              .set({
            FirestoreConstantsKey.nickname: firebaseUser.displayName,
            FirestoreConstantsKey.photoUrl: firebaseUser.photoURL,
            FirestoreConstantsKey.id: firebaseUser.uid,
            'Account Create At': DateTime.now().day.toString()
          });
          User? currentUser = firebaseUser;
          await preferences.setString(FirestoreConstantsKey.id, currentUser.uid);
          await preferences.setString(
              FirestoreConstantsKey.nickname, currentUser.displayName ?? "Anonyme");
          await preferences.setString(
              FirestoreConstantsKey.photoUrl, currentUser.photoURL ?? 'No Profile');
          await preferences.setString(FirestoreConstantsKey.email, currentUser.email ?? '...@..?');
        } else {
          DocumentSnapshot documentSnapshot = documents[0];
          var userInvoice = UserInvoice.fromDocument(documentSnapshot);

          await preferences.setString(FirestoreConstantsKey.id, userInvoice.id);
          await preferences.setString(FirestoreConstantsKey.nickname, userInvoice.nickname);
          await preferences.setString(FirestoreConstantsKey.photoUrl, userInvoice.photoUrl);
          await preferences.setString(FirestoreConstantsKey.email, userInvoice.email);
        }
        _status = AuthentificationStatus.authentificated;
        notifyListeners();
        return true;
      } else {
        _status = AuthentificationStatus.authentificateError;
        notifyListeners();
        return false;
      }
    } else {
      _status = AuthentificationStatus.authentificateCanceled;
      notifyListeners();
      return false;
    }
  }

  Future<void> handleSignOut() async {
    _status = AuthentificationStatus.uinitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }

  String? getUserFirebaseId() {
    return preferences.getString(FirestoreConstantsKey.id);
  }
}
