import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Product extends Equatable {
  final String name;
  final String imageUrl;

  Product({@required this.name, this.imageUrl});

  @override
  List<Object> get props => [name, imageUrl];

  @override
  bool get stringify => true;
}