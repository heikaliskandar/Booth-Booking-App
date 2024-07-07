import 'package:flutter/material.dart';

// Gradient Button
class ButtonGradient extends StatelessWidget {
  const ButtonGradient({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.textStyle,
    required this.borderRadius,
    required this.gradientColor,
    this.stretch,
  }) : super(key: key);

  final void Function() onPressed;
  final String label;
  final TextStyle textStyle;
  final double borderRadius;
  final List<Color> gradientColor;
  final bool? stretch;

  @override
  Widget build(BuildContext context) {
    double minWidth = 0;
    if (stretch != null && stretch == true) {
      minWidth = double.infinity;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        gradient: LinearGradient(
          colors: gradientColor,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          minimumSize: Size(minWidth, 0),
          padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ),
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );
  }
}

// Link Button Style
class LinkButton extends StatelessWidget {
  const LinkButton({
    Key? key,
    required this.text,
    required this.style,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}