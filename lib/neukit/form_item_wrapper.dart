import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '/my_library/formatter/flutter_formatter.dart';
import 'package:neukit/widgets/text_block.dart';

class FormItemWrapper extends StatelessWidget {
  final Widget child;
  final String? label;
  final double marginBottom;
  const FormItemWrapper({
    Key? key,
    required this.child,
    this.label,
    this.marginBottom = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (label != null)
          TextBlock(
            Formatter().titleCase(label),
            margin: const EdgeInsets.only(bottom: 10),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        Neumorphic(
          margin: EdgeInsets.only(bottom: marginBottom),
          padding: const EdgeInsets.symmetric(vertical: 5),
          style: NeumorphicStyle(
            depth: -3,
            border: NeumorphicBorder(
              color: NeumorphicTheme.currentTheme(context).borderColor,
              width: 1.5,
            ),
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(16),
            ),
          ),
          child: child,
        )
      ],
    );
  }
}
