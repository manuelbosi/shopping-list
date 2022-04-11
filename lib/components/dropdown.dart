import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<String> options;
  final String placeholder;
  const Dropdown({
    Key? key,
    required this.options,
    required this.placeholder,
  }) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? _selectedOption;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String?>(
      validator: (String? value) {
        if (value == null) {
          return "Campo obbligatorio";
        }
        return null;
      },
      hint: Text(widget.placeholder),
      isDense: false,
      value: _selectedOption,
      items: widget.options.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      onChanged: (String? currentOption) {
        setState(() => _selectedOption = currentOption);
      },
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
    );
  }
}
