import 'package:eat_well_review/models/inquiry.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class InquiriesEvent extends Equatable {}

class FetchInquiries extends InquiriesEvent {
  @override
  List<Object> get props => [];
}

class UpdateInquiries extends InquiriesEvent {
  final List<Inquiry> currentInquiries;

  UpdateInquiries({@required this.currentInquiries});

  @override
  List<Object> get props => [currentInquiries];
}
