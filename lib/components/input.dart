import 'package:flutter/material.dart';
import 'package:shopping_list/config/colors.dart';
import 'package:shopping_list/extensions/string_validator.dart';

class Input extends StatelessWidget {
  final String type;
  final TextEditingController controller;
  final String? label;
  final bool isRequired;
  final int? minLength;
  final int? maxLength;
  final String? placeholder;
  final IconData? icon;

  const Input(
      {Key? key,
      required this.type,
      required this.controller,
      this.label,
      this.isRequired = false,
      this.minLength,
      this.maxLength,
      this.placeholder,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField(builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            cursorColor: ColorPalette.primary,
            controller: controller,
            obscureText: type == 'password',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              isDense: true,
              // isCollapsed: true,
              hintText: placeholder,
              prefixIcon: icon != null ? Icon(icon) : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 25),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.primary,
                  width: 1.5,
                ),
              ),
              errorStyle: const TextStyle(
                color: ColorPalette.danger,
              ),
            ),
            validator: validateField,
          ),
        ],
      );
    });
  }

  String? validateField(String? value) {
    // Check for empty or null value
    if (isRequired && (value == null || value.isEmpty)) {
      return "Campo obbligatorio";
    }

    // Validate field type
    if (type == 'email') {
      return value!.isValidEmail() ? null : "Email non valida";
    }

    // Validate field length
    if (minLength != null && maxLength != null) {
      final isValid =
          value!.isGreatherThan(minLength) && value.isLowerThan(maxLength);
      return isValid
          ? null
          : 'Il campo deve essere tra $minLength e $maxLength caratteri';
    }
    if (maxLength != null) {
      return value!.isLowerThan(maxLength)
          ? null
          : 'Il campo deve essere di massimo $maxLength caratteri';
    }
    if (minLength != null) {
      return value!.isGreatherThan(minLength)
          ? null
          : 'Il campo deve essere di almeno $minLength caratteri';
    }

    return null;
  }
}
