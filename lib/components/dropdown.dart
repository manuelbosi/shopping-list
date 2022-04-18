import 'package:flutter/material.dart';
import 'package:shopping_list/config/colors.dart';
import 'package:shopping_list/models/dropdown_option.dart';

class Dropdown extends StatefulWidget {
  final List<DropdownOption> options;
  final String placeholder;
  final Function onChanged;
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
  DropdownOption? _selectedOption;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DropdownOption>(
      validator: (DropdownOption? option) {
        if (option == null) {
          return "Campo obbligatorio";
        }
        return null;
      },
      hint: Text(widget.placeholder),
      isDense: true,
      value: _selectedOption,
      items: widget.options.map((DropdownOption option) {
        return DropdownMenuItem<DropdownOption>(
          value: option,
          child: Text(
            option.value,
          ),
        );
      }).toList(),
      onChanged: (DropdownOption? currentOption) {
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
    );
  }
}
