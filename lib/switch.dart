import 'package:flutter_neumorphic/flutter_neumorphic.dart';

typedef void OnChanged(bool isOn);

class NeuSwitch extends StatefulWidget {
  final bool isOn;
  final OnChanged onChanged;
  final Color? activeShadowDarkColor;
  final Color? activeShadowLightColor;
  final Color? activeShadowDarkColorEmboss;
  final Color? activeShadowLightColorEmboss;
  final Color? inactiveShadowDarkColor;
  final Color? inactiveShadowLightColor;
  final Color? inactiveShadowDarkColorEmboss;
  final Color? inactiveShadowLightColorEmboss;
  final NeumorphicBorder trackBorder;

  const NeuSwitch({
    this.isOn = false,
    required this.onChanged,
    this.activeShadowDarkColor,
    this.activeShadowLightColor,
    this.activeShadowDarkColorEmboss,
    this.activeShadowLightColorEmboss,
    this.inactiveShadowDarkColor,
    this.inactiveShadowLightColor,
    this.inactiveShadowDarkColorEmboss,
    this.inactiveShadowLightColorEmboss,
    this.trackBorder = const NeumorphicBorder(width: 0),
    Key? key,
  }) : super(key: key);

  @override
  _NeuSwitchState createState() => _NeuSwitchState();
}

class _NeuSwitchState extends State<NeuSwitch> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.isOn;
  }

  @override
  Widget build(BuildContext context) {
    var themeDataSwitch = NeumorphicTheme.currentTheme(context);

    themeDataSwitch = themeDataSwitch.copyWith(
      shadowDarkColor:
          isOn ? widget.activeShadowDarkColor : widget.inactiveShadowDarkColor,
      shadowLightColor: isOn
          ? widget.activeShadowLightColor
          : widget.inactiveShadowLightColor,
      shadowDarkColorEmboss: isOn
          ? widget.activeShadowDarkColorEmboss
          : widget.inactiveShadowDarkColorEmboss,
      shadowLightColorEmboss: isOn
          ? widget.activeShadowLightColorEmboss
          : widget.inactiveShadowLightColorEmboss,
    );

    return NeumorphicTheme(
      theme: themeDataSwitch,
      child: SizedBox(
        width: 60,
        child: NeumorphicSwitch(
          height: 35,
          duration: const Duration(milliseconds: 160),
          value: isOn,
          onChanged: (val) async {
            setState(() {
              isOn = val;
              widget.onChanged(isOn);
            });
          },
          style: NeumorphicSwitchStyle(
            trackDepth: -4,
            thumbShape: NeumorphicShape.flat,
            trackBorder: widget.trackBorder,
          ),
        ),
      ),
    );
  }
}
