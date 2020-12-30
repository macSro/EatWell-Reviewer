import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_review/models/inquiry.dart';
import 'package:flutter/foundation.dart';

class InquiriesRepository {
  FirebaseFirestore _firestore;

  InquiriesRepository({@required FirebaseFirestore firestore}) {
    this._firestore = firestore;
  }

  Future<List<Inquiry>> fetchInquiries() {
    return _firestore
        .collection('inquiries')
        .orderBy('date', descending: false)
        .get()
        .then((snap) => snap.docs.map((doc) {
              final data = doc.data();
              return Inquiry(
                id: doc.id,
                productName: data['productName'],
                date: (data['date'] as Timestamp).toDate(),
              );
            }).toList());
  }

  Future<List<Inquiry>> fetchNewInquiries(DateTime lastUpdated) {
    return _firestore
        .collection('inquiries')
        .where('date', isGreaterThan: Timestamp.fromDate(lastUpdated))
        .orderBy('date', descending: false)
        .get()
        .then((snap) => snap.docs.map((doc) {
              final data = doc.data();
              return Inquiry(
                id: doc.id,
                productName: data['productName'],
                date: (data['date'] as Timestamp).toDate(),
              );
            }).toList());
  }
}
