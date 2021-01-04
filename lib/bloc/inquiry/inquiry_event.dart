import 'dart:io';

import 'package:eat_well_review/models/inquiry.dart';
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
  final String productName;
  final File file;

  AcceptInquiry({@required this.inquiryId, @required this.productName, this.file});

  @override
  List<Object> get props => [inquiryId, productName];
}

class RejectInquiry extends InquiryEvent {
  final String inquiryId;

  RejectInquiry({this.inquiryId});

  @override
  List<Object> get props => [inquiryId];
}
