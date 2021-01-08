import 'dart:io';

import 'package:eat_well_review/bloc/inquiry/inquiry_bloc.dart';
import 'package:eat_well_review/bloc/inquiry/inquiry_event.dart';
import 'package:eat_well_review/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class InquiryForm extends StatefulWidget {
  final String inquiryId;

  InquiryForm({@required this.inquiryId});

  @override
  _InquiryFormState createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  final _formKey = GlobalKey<FormState>();
  File image;
  final imagePicker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  bool focus1 = false;
  bool focus2 = false;

  @override
  void initState() {
    nameController.addListener(() {
      setState(() {
        if (nameController.text.isNotEmpty) {
          focus1 = true;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    KeyboardAvoider(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: nameController,
                              validator: (val) => val.isEmpty
                                  ? 'Please enter a product name.'
                                  : null,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.fastfood_rounded),
                                hintText: 'Enter the product name',
                                suffixIcon: focus1
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            focus1 = false;
                                          });
                                          nameController.clear();
                                        },
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 16),
                            RaisedButton(
                              onPressed: _getImage,
                              child: Text(
                                'Pick an image',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.white),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                            ),
                            const SizedBox(height: 16),
                            image == null
                                ? Text('No image selected.')
                                : Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: kPrimaryColorLight,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(19),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.file(image),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete_rounded,
                                            size: 28,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              image = null;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 150,
              height: 50,
              child: RaisedButton(
                child: Text(
                  'Reject',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('Do you want to reject the inquiry?'),
                    actions: [
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          BlocProvider.of<InquiryBloc>(context).add(
                            RejectInquiry(inquiryId: widget.inquiryId),
                          );
                        },
                        child: Text('Reject'),
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                ),
                color: Colors.redAccent,
              ),
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: RaisedButton(
                child: Text(
                  'Accept',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Do you want to accept the inquiry?'),
                        actions: [
                          FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              BlocProvider.of<InquiryBloc>(context).add(
                                AcceptInquiry(
                                  inquiryId: widget.inquiryId,
                                  productName: nameController.text,
                                  file: image,
                                ),
                              );
                            },
                            child: Text('Accept'),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    );
                  }
                },
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future _getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
