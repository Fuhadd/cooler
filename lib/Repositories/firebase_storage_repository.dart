import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStorageRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  CollectionReference firestoreRepository =
      FirebaseFirestore.instance.collection('employees');

  CollectionReference employeeFirebaseFirestore =
      FirebaseFirestore.instance.collection('employees');

  CollectionReference groupFirebaseFirestore =
      FirebaseFirestore.instance.collection('groups');

  Future uploadImage(File image) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    Reference ref = firebaseStorage.ref().child('$uid/images');
    await ref.putFile(image);
    String downloadedUrl = await ref.getDownloadURL();
    await employeeFirebaseFirestore.doc(uid.toString()).set(

        //document().set(
        {
          'imageUrl': downloadedUrl,
        },
        SetOptions(
          merge: true,
        ));
  }

  Future updateImage(File image) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    Reference ref = firebaseStorage.ref().child('$uid/images');
    await ref.putFile(image);
    String downloadedUrl = await ref.getDownloadURL();
    await employeeFirebaseFirestore.doc(uid.toString()).update(
      //document().set(
      {
        'imageUrl': downloadedUrl,
      },
    );
  }

  Future uploadGroupImage(File image, String groupId) async {
    Reference ref = firebaseStorage.ref().child('$groupId/images');
    await ref.putFile(image);
    String downloadedUrl = await ref.getDownloadURL();
    await groupFirebaseFirestore.doc(groupId).set(

        //document().set(
        {
          'imageUrl': downloadedUrl,
        },
        SetOptions(
          merge: true,
        ));
  }
}
