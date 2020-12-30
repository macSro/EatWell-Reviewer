import 'package:eat_well_review/models/inquiry.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


@immutable
abstract class InquiriesState extends Equatable {}

class InquiriesInitial extends InquiriesState {
  @override
  List<Object> get props => [];
}

class InquiriesLoading extends InquiriesState {
  @override
  List<Object> get props => [];
}

class InquiriesFetched extends InquiriesState {
  final List<Inquiry> inquiries;

  InquiriesFetched({this.inquiries});

  @override
  List<Object> get props => [inquiries];
}
