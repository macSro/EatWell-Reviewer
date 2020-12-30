import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Inquiry extends Equatable {
  final String id;
  final String productName;
  final DateTime date;

  Inquiry({@required this.id, @required this.productName, @required this.date});

  @override
  List<Object> get props => [id, productName, date];

  @override
  bool get stringify => true;
}
