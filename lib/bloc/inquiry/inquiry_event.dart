import 'package:eat_well_review/models/inquiry.dart';
import 'package:eat_well_review/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class InquiryEvent extends Equatable {}

class SelectInquiry extends InquiryEvent {
  final Inquiry inquiry;

  SelectInquiry({@required this.inquiry});

  @override
  List<Object> get props => [inquiry];
}

class AcceptInquiry extends InquiryEvent {
  final String inquiryId;
  final Product product;

  AcceptInquiry({this.inquiryId, this.product});

  @override
  List<Object> get props => [inquiryId, product];
}

class RejectInquiry extends InquiryEvent {
  final String inquiryId;

  RejectInquiry({this.inquiryId});

  @override
  List<Object> get props => [inquiryId];
}
