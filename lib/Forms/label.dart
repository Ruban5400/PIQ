import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/app_colors.dart';

class RichTextFieldWidget extends StatelessWidget {
  final String label;
  final bool requiredField;

  RichTextFieldWidget({
    required this.label,
    required this.requiredField,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: GoogleFonts.lato(
                color: HexColor.fromHex("000000"),
                fontSize: 14,
              ),
            ),
            if (requiredField == true)
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
