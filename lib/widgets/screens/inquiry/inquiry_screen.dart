import 'package:eat_well_review/bloc/inquiry/inquiry_bloc.dart';
import 'package:eat_well_review/bloc/inquiry/inquiry_state.dart';
import 'package:eat_well_review/models/inquiry.dart';
import 'package:eat_well_review/widgets/misc/loading.dart';
import 'package:eat_well_review/widgets/misc/scaffold.dart';
import 'package:eat_well_review/widgets/screens/error/error_screen.dart';
import 'package:eat_well_review/widgets/screens/inquiry/inquiry_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';

class InquiryScreen extends StatelessWidget {
  static const routeName = '/inquiry';

  @override
  Widget build(BuildContext context) {
    return BlocListener<InquiryBloc, InquiryState>(
      listenWhen: (previous, current) =>
          previous is InquiryLoading && current is InquiryResolved,
      listener: (context, state) {
        if ((state as InquiryResolved).successful) {
          Navigator.pop(context, (state as InquiryResolved).inquiryId);
        } else {
          Navigator.pushNamed(
            context,
            ErrorScreen.routeName,
            arguments: kInquiryResolveFailed,
          ).then((_) => Navigator.pop(context));
        }
      },
      child: BlocBuilder<InquiryBloc, InquiryState>(
        builder: (context, state) => MyScaffold(
          title: 'Inquiry details',
          doubleBack: false,
          child: state is InquirySelected
              ? _getContent(context, state.inquiry)
              : LoadingView(text: 'Loading inquiry...'),
        ),
      ),
    );
  }

  Widget _getContent(context, Inquiry inquiry) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              'Missing product reported:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '"${inquiry.productName}"',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: kPrimaryColorDark),
              ),
            ),
            const SizedBox(height: 16),
            Divider(),
            Expanded(
              child: InquiryForm(inquiryId: inquiry.id),
            ),
          ],
        ),
      );
}
