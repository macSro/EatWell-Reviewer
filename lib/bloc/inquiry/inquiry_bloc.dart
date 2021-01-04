import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:eat_well_review/models/inquiry.dart';
import 'package:eat_well_review/repositories/inquiry_repository.dart';
import 'package:flutter/foundation.dart';

import 'inquiry_event.dart';
import 'inquiry_state.dart';

class InquiryBloc extends Bloc<InquiryEvent, InquiryState> {
  InquiryRepository _repository;

  InquiryBloc({
    @required repository,
  }) : super(InquiryInitial()) {
    _repository = repository;
  }

  @override
  Stream<InquiryState> mapEventToState(InquiryEvent event) async* {
    if (event is SelectInquiry)
      yield* _selectRecipe(event.inquiry);
    else if (event is AcceptInquiry)
      yield* _acceptInquiry(event.inquiryId, event.productName, event.file);
    else if (event is RejectInquiry) yield* _rejectInquiry(event.inquiryId);
  }

  Stream<InquiryState> _selectRecipe(Inquiry inquiry) async* {
    yield InquiryLoading();

    yield InquirySelected(inquiry: inquiry);
  }

  Stream<InquiryState> _acceptInquiry(
    String inquiryId,
    String productName,
    File file,
  ) async* {
    yield InquiryLoading();

    yield InquiryResolved(
      inquiryId: inquiryId,
      successful: (await _repository.acceptInquiry(inquiryId, productName, file) != null),
    );
  }

  Stream<InquiryState> _rejectInquiry(String inquiryId) async* {
    yield InquiryLoading();

    yield InquiryResolved(
      inquiryId: inquiryId,
      successful: (await _repository.deleteInquiry(inquiryId) != null),
    );
  }
}
