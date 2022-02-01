import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'form_item_wrapper.dart';

typedef CallBack<T> = void Function(T? value);

class FormItemDropdown<T> extends StatelessWidget {
  final String? label;
  final T? initialValue;
  final bool disabled;
  final List<DropdownMenuItem<T>> items;
  final CallBack<T> onChanged;
  final bool required;
  final String errorMessage;
  const FormItemDropdown({
    Key? key,
    this.label,
    this.initialValue,
    this.disabled = false,
    this.items = const [],
    this.required = false,
    this.errorMessage = 'Required',
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
        validator: (value) => (required && value == null) ? errorMessage : null,
      ),
    );
  }
}
