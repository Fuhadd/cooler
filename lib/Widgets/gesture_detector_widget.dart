import 'package:flutter/material.dart';

import 'constant_widget.dart';

class GestureButtonWidget extends StatefulWidget {
  final Color? buttonColor;
  final Color? textColor;
  final String? text;
  final VoidCallback? onPress;

  const GestureButtonWidget(
      {super.key, this.buttonColor, this.text, this.onPress, this.textColor});

  @override
  _GestureButtonWidgetState createState() => _GestureButtonWidgetState();
}

class _GestureButtonWidgetState extends State<GestureButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                color: widget.buttonColor),
            child: TextButton(
              onPressed: widget.onPress,
              child: TextWidget(
                textSize: 18,
                fontWeight: FontWeight.w700,
                text: widget.text,
                color: widget.textColor,
              ),
            ),
          ),
        ),
      ),
    );

  }
}
