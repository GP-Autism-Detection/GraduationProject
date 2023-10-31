import 'package:flutter/cupertino.dart';

class ItemModel {
  final String name;
  final Widget img;
  final String value;
  bool accepting;
  ItemModel(
      {required this.name,
      required this.value,
      required this.img,
      this.accepting = false});
}
