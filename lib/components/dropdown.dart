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
    return DropdownButton<String?>(
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
      borderRadius: BorderRadius.circular(10),
      underline: Container(
        height: 2,
        color: Colors.grey.shade300,
      ),
    );
  }
}
