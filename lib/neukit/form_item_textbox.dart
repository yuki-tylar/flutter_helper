import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '/my_library/flutter_validator/flutter_validator.dart';
import 'form_item_wrapper.dart';
import 'style_form_item.dart';

typedef Callback = void Function(String? val);
const String defaultLabel = 'name';

class FormItemTextbox extends StatefulWidget {
  final String? label;
  final List<Validator> validators;
  final Callback? onSaved;
  final Callback? onChanged;
  final int minLines;
  final int maxLines;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool showLabel;
  final double marginBottom;
  final String? hint;
  final bool obscureText;
  final String? prefix;
  final String? suffix;

  const FormItemTextbox({
    Key? key,
    this.controller,
    this.label = defaultLabel,
    this.validators = const [],
    this.onSaved,
    this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType = TextInputType.name,
    this.showLabel = true,
    this.marginBottom = 50,
    this.hint,
    this.obscureText = false,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  @override
  _FormItemTextboxState createState() => _FormItemTextboxState();
}

class _FormItemTextboxState extends State<FormItemTextbox> {
  late TextEditingController _controller;

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
  }

  @override
  void initState() {
    _controller = widget.controller != null
        ? widget.controller!
        : TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormItemWrapper(
      label: widget.showLabel ? widget.label : null,
      marginBottom: widget.marginBottom,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: _controller,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: styleFormItem(context).copyWith(
          hintText: widget.hint,
          suffixText: widget.suffix,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          prefixIcon: widget.prefix != null
              ? Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                  child: Text(
                    widget.prefix!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).disabledColor),
                  ),
                )
              : null,
        ),
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        validator: (String? value) {
          String? error;
          for (var i = 0; i < widget.validators.length; i++) {
            error = widget.validators[i].validate(value);
            if (error != null) {
              break;
            }
          }

          return error;
        },
      ),
    );
  }
}
