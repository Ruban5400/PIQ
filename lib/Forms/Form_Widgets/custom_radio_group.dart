import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onSelect;

  CustomRadioButton({
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
                color: (widget.label == 'Yes' || widget.label == 'Corrective'
                    ? Colors.green
                    : widget.label == 'No' || widget.label == 'Preventive'
                    ? Colors.red
                    : Colors.orange)),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          widget.isSelected
              ? widget.label == 'Yes' || widget.label == 'Corrective'
              ? Colors.green
              : widget.label == 'No' || widget.label == 'Preventive'
              ? Colors.red
              : Colors.orange
              : Colors.white,
        ),
      ),
      onPressed: () {
        widget.onSelect(!widget.isSelected);
      },
      child: Text(
        widget.label,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
