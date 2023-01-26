import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoice_builder/shared/firestore_key.dart';

class UserInvoice {
  String id, photoUrl, nickname, email;
  UserInvoice({
    required this.id,
    required this.photoUrl,
    required this.nickname,
    required this.email,
  });

  Map<String, String> toJSON() {
    return {
      FirestoreConstantsKey.nickname: nickname,
      FirestoreConstantsKey.photoUrl: photoUrl,
      FirestoreConstantsKey.email: email,
    };
  }

  factory UserInvoice.fromDocument(DocumentSnapshot doc) {
    String nickname = 'unknow', photoUrl = 'unknow', email = 'unknow';
    try {
      nickname = doc.get(FirestoreConstantsKey.nickname);
    } catch (e) {
      log('Failed to get google nickname');
    }
    try {
      photoUrl = doc.get(FirestoreConstantsKey.photoUrl);
    } catch (e) {
      log('Failed to get user profile image.');
    }
    try {
      email = doc.get(FirestoreConstantsKey.email);
    } catch (e) {
      log('Failed to get user email.');
    }
    return UserInvoice(id: doc.id, photoUrl: photoUrl, nickname: nickname, email: email);
  }
}
