import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:formatter/flutter_formatter.dart';
import 'package:validator/flutter_validator.dart';

import 'style_form_item.dart';
import 'form_item_wrapper.dart';

typedef Callback = Function(String? value);
const String defaultLabel = 'password';

class FormItemPassword extends StatefulWidget {
  final String? label;
  final bool showLabel;
  final Callback? onSaved;
  final Callback? onChanged;
  final TextEditingController? controller;
  final double marginBottom;
  final String? hint;
  final List<Validator> validators;
  final Widget? infoDescription;

  const FormItemPassword({
    Key? key,
    this.label = defaultLabel,
    this.showLabel = true,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.validators = const [],
    this.marginBottom = 50,
    this.hint,
    this.infoDescription,
  }) : super(key: key);

  @override
  _FormItemPasswordState createState() => _FormItemPasswordState();
}

class _FormItemPasswordState extends State<FormItemPassword> {
  late TextEditingController controller;
  TextInputType keyboardType = TextInputType.visiblePassword;
  bool obsecure = true;
  bool showTip = false;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormItemWrapper(
          label: widget.showLabel ? Formatter().titleCase(widget.label) : null,
          marginBottom: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obsecure,
                  controller: controller,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration:
                      styleFormItem(context).copyWith(hintText: widget.hint),
                  onSaved: widget.onSaved,
                  onChanged: widget.onChanged,
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
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    obsecure = !obsecure;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                  child: SvgPicture.asset(
                    obsecure ? 'icons/lock.svg' : 'icons/lock-open.svg',
                    width: 18,
                  ),
                ),
              ),
              if (widget.infoDescription != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showTip = !showTip;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                    child: SvgPicture.asset(
                      'icons/light.svg',
                      width: 16,
                    ),
                  ),
                )
            ],
          ),
        ),
        if (showTip && widget.infoDescription != null) widget.infoDescription!,
        Container(
          height: widget.marginBottom,
        ),
      ],
    );
  }
}
