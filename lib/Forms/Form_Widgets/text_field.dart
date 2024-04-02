import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../Utils/app_colors.dart';


class TextFieldWidget extends StatelessWidget {
  final Map<String, dynamic> field;
  final Function(String, dynamic) onChanged;
  final dynamic initialValue;

  TextFieldWidget({
    required this.field,
    required this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: FormBuilderTextField(
        scrollPadding: EdgeInsets.only(bottom: 40),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor.fromHex("bf3a4a")),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        maxLines: 1,
        autovalidateMode: AutovalidateMode.disabled,
        onChanged: (value) {
          onChanged(field['name'], value);
        },
        keyboardType: field['type'] == 'number'
            ? TextInputType.number
            : TextInputType.text,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        initialValue: initialValue,
        name: field['name'],
      ),
    );
  }
}
