import 'form_item_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

typedef CallBack<T> = void Function(T? value);

class FormItemDropdown<T> extends StatelessWidget {
  final String? label;
  final T? initialValue;
  final bool disabled;
  final List<DropdownMenuItem<T>> items;
  final CallBack<T> onChanged;
  const FormItemDropdown({
    Key? key,
    this.label,
    this.initialValue,
    this.disabled = false,
    this.items = const [],
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T? selectedValue = initialValue;

    return FormItemWrapper(
      label: label,
      child: DropdownButtonFormField<T>(
        value: selectedValue,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.bodyText1,
        onChanged: (newValue) {
          selectedValue = newValue;
          onChanged(newValue);
        },
        items: items,
        validator: (value) => value == null ? 'Please select city' : null,
      ),
    );
  }
}