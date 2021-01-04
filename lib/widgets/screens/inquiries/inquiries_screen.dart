import 'package:eat_well_review/bloc/inquiries/inquiries_bloc.dart';
import 'package:eat_well_review/bloc/inquiries/inquiries_event.dart';
import 'package:eat_well_review/bloc/inquiries/inquiries_state.dart';
import 'package:eat_well_review/bloc/inquiry/inquiry_bloc.dart';
import 'package:eat_well_review/bloc/inquiry/inquiry_event.dart';
import 'package:eat_well_review/bloc/user/user_bloc.dart';
import 'package:eat_well_review/bloc/user/user_event.dart';
import 'package:eat_well_review/models/inquiry.dart';
import 'package:eat_well_review/widgets/misc/loading.dart';
import 'package:eat_well_review/widgets/misc/scaffold.dart';
import 'package:eat_well_review/widgets/screens/inquiries/inquiry_list_item.dart';
import 'package:eat_well_review/widgets/screens/inquiry/inquiry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InquiriesScreen extends StatelessWidget {
  static const routeName = '/inquiries';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InquiriesBloc, InquiriesState>(
      builder: (context, state) => MyScaffold(
        title: 'Inquiries',
        child: state is InquiriesFetched
            ? _getContent(context, state.inquiries)
            : LoadingView(text: 'Loading inquiries...'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(SignOut());
            },
          ),
        ],
        floatingActionButton: state is InquiriesFetched
            ? FloatingActionButton(
                onPressed: () => BlocProvider.of<InquiriesBloc>(context).add(
                  UpdateInquiries(currentInquiries: state.inquiries),
                ),
                child: Icon(Icons.refresh_rounded),
              )
            : null,
      ),
    );
  }

  Widget _getContent(context, List<Inquiry> inquiries) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView(
        children: inquiries
            .map(
              (inquiry) => InquiryListItem(
                inquiry: inquiry,
                onTap: () {
                  Navigator.of(context).pushNamed(InquiryScreen.routeName).then(
                        (resolvedId) =>
                            BlocProvider.of<InquiriesBloc>(context).add(
                          DeleteResolved(
                            currentInquiries: inquiries,
                            inquiryId: resolvedId,
                          ),
                        ),
                      );
                  BlocProvider.of<InquiryBloc>(context).add(
                    SelectInquiry(inquiry: inquiry),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
