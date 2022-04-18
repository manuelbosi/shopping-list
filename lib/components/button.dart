import 'package:flutter/material.dart';
import 'package:shopping_list/config/colors.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final dynamic child;
  final String type;
  final double? width;

  const Button({
    Key? key,
    required this.type,
    required this.onPressed,
    required this.child,
    this.width,
  }) : super(key: key);

  double isFullWidth(double? width) {
    final double w = width ?? 0;
    return w.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color?>(ColorPalette.white),
        splashFactory: NoSplash.splashFactory,
        backgroundColor: MaterialStateProperty.all<Color?>(
          type == "success" ? ColorPalette.success : ColorPalette.danger,
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(isFullWidth(width), 0),
        ),
        // padding: MaterialStateProperty.all<EdgeInsets>(
        //   const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
        // ),
        alignment: Alignment.center,
      ),
      onPressed: handleOnPressed,
      child: child,
    );
  }

  void handleOnPressed() {
    onPressed();
  }
}
