import 'package:flutter/material.dart';
import 'package:shopping_list/config/colors.dart';

class Dropdown<T> extends StatefulWidget {
  final List<T> options;
  final String placeholder;
  final Function(T?) onChanged;

  const Dropdown({
    Key? key,
    required this.options,
    required this.placeholder,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  dynamic _selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
      validator: (dynamic option) {
        if (option == null) {
          return "Campo obbligatorio";
        }
        return null;
      },
      hint: Text(widget.placeholder),
      isDense: true,
      value: _selectedOption,
      items: widget.options.map((dynamic option) {
        return DropdownMenuItem<dynamic>(
          value: option,
          child: Text(
            option.name,
          ),
        );
      }).toList(),
      onChanged: (dynamic currentOption) {
        setState(() => _selectedOption = currentOption);
        widget.onChanged(currentOption);
      },
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
      decoration: const InputDecoration(
        errorStyle: TextStyle(
          color: ColorPalette.danger,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorPalette.primary,
            width: 1.5,
          ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
