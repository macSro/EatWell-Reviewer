import 'package:bloc/bloc.dart';
import 'package:eat_well_review/models/inquiry.dart';
import 'package:eat_well_review/models/product.dart';
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
      yield* _acceptInquiry(event.inquiryId, event.product);
    else if (event is RejectInquiry) yield* _rejectInquiry(event.inquiryId);
  }

  Stream<InquiryState> _selectRecipe(Inquiry inquiry) async* {
    yield InquiryLoading();

    yield InquirySelected(inquiry: inquiry);
  }

  Stream<InquiryState> _acceptInquiry(
    String inquiryId,
    Product product,
  ) async* {
    yield InquiryLoading();

    yield InquiryResolved(successful: (await _repository.acceptInquiry(inquiryId, product) != null));
  }

  Stream<InquiryState> _rejectInquiry(
    String inquiryId
  ) async* {
    yield InquiryLoading();

    yield InquiryResolved(successful: (await _repository.deleteInquiry(inquiryId) != null));
  }
}
