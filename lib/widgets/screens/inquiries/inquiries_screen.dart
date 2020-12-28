import 'package:eat_well_review/widgets/misc/scaffold.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class InquiriesScreen extends StatelessWidget {
  static const routeName = '/inquiries';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: _getContent(context),
    );
  }

  Widget _getContent(context) {
    return Column(
      children: [
        Text(
          'Inquiries',
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: kPrimaryColorDark,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
