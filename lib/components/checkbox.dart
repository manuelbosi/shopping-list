import 'package:flutter/material.dart';
import 'package:shopping_list/config/colors.dart';

class InputCheckbox extends StatefulWidget {
  final Function onChange;
  final bool isChecked;
  final double size;
  final Color _checkedBackground = ColorPalette.blue;
  final Color _checkedIconColor = ColorPalette.white;
  final Color _borderColor = ColorPalette.blue;
  final IconData _icon = Icons.check;

  InputCheckbox({
    Key? key,
    required this.isChecked,
    required this.onChange,
    required this.size,
  }) : super(key: key);

  @override
  _InputCheckboxState createState() => _InputCheckboxState();
}

class _InputCheckboxState extends State<InputCheckbox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onChange(_isSelected);
        });
      },
      child: AnimatedContainer(
        // margin: const EdgeInsets.all(4),
        duration: const Duration(milliseconds: 100),
        curve: _isSelected ? Curves.easeIn : Curves.easeOut,
        decoration: BoxDecoration(
          color: _isSelected ? widget._checkedBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: widget._borderColor,
            width: 1.5,
          ),
        ),
        width: widget.size,
        height: widget.size,
        child: _isSelected
            ? Icon(
                widget._icon,
                color: widget._checkedIconColor,
                size: widget.size - 5,
              )
            : null,
      ),
    );
  }
}
