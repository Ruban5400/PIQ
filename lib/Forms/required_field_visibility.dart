import 'package:flutter/material.dart';

class RequiredFieldMessage extends StatelessWidget {
  final bool isVisible;

  const RequiredFieldMessage({
    Key? key,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Text(
        'This field is required',
        style: TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
      ),
    );
  }
}
