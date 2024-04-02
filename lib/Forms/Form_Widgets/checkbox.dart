import 'package:flutter/material.dart';
import '../../Utils/app_colors.dart';

class CheckboxGroupWidget extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final Function(List<String>) onChanged;
  final bool requiredField;

  CheckboxGroupWidget({
    required this.items,
    required this.onChanged,
    required this.requiredField,
  });

  @override
  _CheckboxGroupWidgetState createState() => _CheckboxGroupWidgetState();
}

class _CheckboxGroupWidgetState extends State<CheckboxGroupWidget> {
  List<String> selectedValues = [];
  Map<String, bool> checkedValues = {};

  @override
  void initState() {
    super.initState();
    widget.items.forEach((item) {
      final String value = item['value'];
      final bool isChecked = item['checked'] == true;
      checkedValues[value] = isChecked;
      if (isChecked) {
        selectedValues.add(value);
      }
    });
  }

  // Get selected values only from checked items
  _getSelectedValues() {
    List<String> selectedValues = [];
    checkedValues.forEach((value, isChecked) {
      if (isChecked == true) {
        selectedValues.add(value);
      }
    });
    return selectedValues;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.map((item) {
        final String label = item['label'];
        final String value = item['value'];
        final bool isChecked = selectedValues.contains(value) ||
            item['checked'] == true ||
            checkedValues[value] == true;

        return GestureDetector(
          onTap: () {
            setState(() {
              checkedValues[value] = !isChecked;
              selectedValues = _getSelectedValues();
              widget.onChanged(selectedValues);
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: isChecked ? HexColor.fromHex("bf3a4a") : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValues[value] = newValue!;
                      selectedValues = _getSelectedValues();
                      widget.onChanged(selectedValues);
                    });
                  },
                  activeColor: HexColor.fromHex("bf3a4a"),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    color: isChecked ? HexColor.fromHex("bf3a4a") : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
