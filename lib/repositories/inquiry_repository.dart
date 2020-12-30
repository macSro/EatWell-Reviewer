import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_review/models/product.dart';
import 'package:flutter/foundation.dart';

class InquiryRepository {
  FirebaseFirestore _firestore;

  InquiryRepository({@required FirebaseFirestore firestore}) {
    this._firestore = firestore;
  }

  Future<bool> acceptInquiry(String inquiryId, Product product) async {
    try {
      return _firestore.collection('products').add({
        'name': product.name,
        'imageUrl': product.imageUrl,
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
}
