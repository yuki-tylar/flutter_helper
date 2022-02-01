import 'package:flutter/material.dart';

InputDecoration styleFormItem(BuildContext context) {
  return InputDecoration(
    prefixIconConstraints: const BoxConstraints(
      minWidth: 0,
      minHeight: 0,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
    border: InputBorder.none,
    hintStyle: TextStyle(color: Theme.of(context).disabledColor),
  );
}
