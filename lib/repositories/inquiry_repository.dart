import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_review/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import '../tools.dart';

class InquiryRepository {
  FirebaseFirestore _firestore;
  FirebaseStorage _storage;

  InquiryRepository({
    @required FirebaseFirestore firestore,
    @required FirebaseStorage storage,
  }) {
    this._firestore = firestore;
    this._storage = storage;
  }

  Future<bool> acceptInquiry(
    String inquiryId,
    String productName,
    File file,
  ) async {
    try {
      return _firestore.collection('products').add({
        'name': productName,
        'imageUrl': (await _uploadImage(productName, file)) ??
            kIngredientImageUrlBasePath + 'unknown.jpg',
      }).then(
        (_) => deleteInquiry(inquiryId),
      );
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future<bool> deleteInquiry(String inquiryId) async {
    try {
      return _firestore
          .collection('inquiries')
          .doc(inquiryId)
          .delete()
          .then((_) => true);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future<String> _uploadImage(String productName, File file) async {
    if (file == null) return null;

    Reference ref = _storage
        .ref()
        .child('product-images/${Tools.getImageName(productName)}');

    return ref.putFile(file).then((_) => ref.getDownloadURL());
  }
}
