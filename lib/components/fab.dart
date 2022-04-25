import 'package:flutter/material.dart';
import 'package:shopping_list/config/colors.dart';

class FabButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const FabButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: LayoutBuilder(
        builder: ((context, constraints) =>
            Icon(icon, size: constraints.maxHeight / 2)),
      ),
      onPressed: onPressed,
      backgroundColor: ColorPalette.primary,
      splashColor: Colors.transparent,
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
    );
  }
}
