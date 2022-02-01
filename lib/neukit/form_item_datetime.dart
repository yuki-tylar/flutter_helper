import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '/my_library/flutter_validator/flutter_validator.dart';
import 'style_form_item.dart';
import 'form_item_wrapper.dart';
import 'datetime_picker.dart';

typedef OnSaved = void Function(DateTime? value);

class FormItemDatetime extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final bool showLabel;
  final List<Validator>? validators;
  final OnSaved? onSaved;
  final OnSaved? onChanged;
  final String format;
  final DateTime? minTime;
  final DateTime? maxTime;

  const FormItemDatetime({
    Key? key,
    this.controller,
    this.label = 'service date',
    this.showLabel = true,
    this.validators = const <Validator>[],
    this.format = 'MMM dd, yyyy hh:mm a',
    this.minTime,
    this.maxTime,
    this.onSaved,
    this.onChanged,
  }) : super(key: key);

  @override
  _FormItemDatetimeState createState() => _FormItemDatetimeState();
}

class _FormItemDatetimeState extends State<FormItemDatetime> {
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
      DatePicker.showPicker(
        context,
        showTitleActions: true,
        onConfirm: (dt) {
          controller.text = dateFormatter.format(dt);
        },
        pickerModel: CustomDatetimePicker(
          currentTime: parseDate(controller.text),
          minTime: widget.minTime,
          maxTime: widget.maxTime,
        ),
      );
    }

    controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(parseDate(controller.text));
      }
    });

    return FormItemWrapper(
      label: widget.showLabel ? widget.label : null,
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
