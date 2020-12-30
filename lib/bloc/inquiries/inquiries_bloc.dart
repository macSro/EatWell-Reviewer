import 'package:bloc/bloc.dart';
import 'package:eat_well_review/models/inquiry.dart';
import 'package:flutter/foundation.dart';

import '../../repositories/inquiries_repository.dart';
import 'inquiries_event.dart';
import 'inquiries_state.dart';

class InquiriesBloc extends Bloc<InquiriesEvent, InquiriesState> {
  InquiriesRepository _repository;

  InquiriesBloc({@required InquiriesRepository repository})
      : super(InquiriesInitial()) {
    _repository = repository;
  }

  @override
  Stream<InquiriesState> mapEventToState(InquiriesEvent event) async* {
    if (event is FetchInquiries)
      yield* _fetchInquiries();
    else if (event is UpdateInquiries)
      yield* _updateInquiries(event.currentInquiries);
  }

  Stream<InquiriesState> _fetchInquiries() async* {
    yield InquiriesLoading();

    final List<Inquiry> inquiries = await _repository.fetchInquiries();

    yield InquiriesFetched(inquiries: inquiries);
  }

  Stream<InquiriesState> _updateInquiries(
      List<Inquiry> currentInquiries) async* {
    yield InquiriesLoading();

    final List<Inquiry> newInquiries =
        await _repository.fetchNewInquiries(currentInquiries.first.date);

    currentInquiries.addAll(newInquiries);

    yield InquiriesFetched(inquiries: currentInquiries);
  }
}
