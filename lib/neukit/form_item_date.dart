import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '/my_library/flutter_validator/flutter_validator.dart';
import 'style_form_item.dart';
import 'form_item_wrapper.dart';

List<Validator> defaultValidators = [Validator.required()];
const String defaultLabel = 'date';
typedef Callback = void Function(DateTime? value);

class FormItemDate extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final bool showLabel;
  final List<Validator>? validators;
  final DateTime? minTime;
  final DateTime? maxTime;
  final Callback? onSaved;
  final Callback? onChanged;
  final String format;

  const FormItemDate({
    Key? key,
    this.controller,
    this.label = defaultLabel,
    this.showLabel = true,
    this.validators = const <Validator>[],
    this.format = 'MMMM dd, yyyy',
    this.onSaved,
    this.onChanged,
    this.minTime,
    this.maxTime,
  }) : super(key: key);

  @override
  _FormItemDateState createState() => _FormItemDateState();
}

class _FormItemDateState extends State<FormItemDate> {
  late TextEditingController controller;

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) {
      controller.dispose();
    }
  }

  @override
  void initState() {
    controller = widget.controller != null
        ? widget.controller!
        : TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat(widget.format);

    parseDate(String? value) {
      return (value != null && value.isNotEmpty)
          ? dateFormatter.parse(value)
          : null;
    }

    showDatetimePicker() {
      DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        currentTime: parseDate(controller.text),
        minTime: widget.minTime,
        maxTime: widget.maxTime,
        onConfirm: (dt) {
          controller.text = dateFormatter.format(dt);
        },
      );
    }

    controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(parseDate(controller.text));
      }
    });

    return FormItemWrapper(
      label: (widget.label != null && widget.showLabel) ? widget.label! : null,
      child: TextFormField(
        readOnly: true,
        controller: controller,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: styleFormItem(context),
        onTap: showDatetimePicker,
        onSaved: (value) {
          if (widget.onSaved != null) {
            widget.onSaved!(parseDate(value));
          }
        },
        validator: (String? value) {
          String? error;
          if (widget.validators != null) {
            for (var i = 0; i < widget.validators!.length; i++) {
              error = widget.validators![i].validate(value);
              if (error != null) {
                break;
              }
            }
          }

          return error;
        },
      ),
    );
  }
}
