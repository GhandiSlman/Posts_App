// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FloatingBtn extends StatelessWidget {
  void Function()? onPressed;
  Icon icon;
  final Object? herTag;
  Color backGroundColor;
  FloatingBtn(
      {super.key,
      this.onPressed,
      required this.icon,
      required this.backGroundColor,  this.herTag});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: herTag,
      backgroundColor: backGroundColor,
      onPressed: onPressed,
      child: icon,
    );
  }
}
