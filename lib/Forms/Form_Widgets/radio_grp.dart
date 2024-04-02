import 'package:flutter/material.dart';

import '../../Utils/app_colors.dart';

class RadioGroupWidget extends StatefulWidget {
  final String label;
  final List<dynamic> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final bool requiredField;

  const RadioGroupWidget({
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.requiredField,
  });

  @override
  _RadioGroupWidgetState createState() => _RadioGroupWidgetState();
}

class _RadioGroupWidgetState extends State<RadioGroupWidget> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Column(
          children: List<Widget>.generate(widget.items.length, (index) {
            final item = widget.items[index];
            final label = item['label'].toString();
            final value = item['value'].toString();
            final isSelected = value == _selectedValue;

            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: RadioListTile(
                title: Text(label),
                value: value,
                groupValue: _selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    widget.onChanged(newValue);
                    _selectedValue = newValue;
                  });
                },
                selected: isSelected,
                activeColor:
                isSelected ? HexColor.fromHex("bf3a4a") : null,
              ),
            );
          }),
        ),
      ],
    );
  }
}
