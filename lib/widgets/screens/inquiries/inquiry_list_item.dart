import 'package:eat_well_review/models/inquiry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InquiryListItem extends StatelessWidget {
  final Inquiry inquiry;
  final Function onTap;

  InquiryListItem({@required this.inquiry, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(
          'Missing product: "${inquiry.productName}"',
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
        ),
        subtitle: Text(
          'Reported: ${inquiry.date.day}-${inquiry.date.month}-${inquiry.date.year}',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontStyle: FontStyle.italic, fontSize: 13),
        ),
        trailing: Icon(Icons.chevron_right_rounded, size: 32),
        onTap: onTap,
      ),
    );
  }
}
