import 'package:eat_well_review/models/inquiry.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class InquiryState extends Equatable {}

class InquiryInitial extends InquiryState {
  @override
  List<Object> get props => [];
}

class InquiryLoading extends InquiryState {
  @override
  List<Object> get props => [];
}

class InquirySelected extends InquiryState {
  final Inquiry inquiry;

  InquirySelected({@required this.inquiry});

  @override
  List<Object> get props => [inquiry];
}

class InquiryResolved extends InquiryState {
  final bool successful;

  InquiryResolved({@required this.successful});

  @override
  List<Object> get props => [];
}
