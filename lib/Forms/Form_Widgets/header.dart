import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/app_colors.dart';


class HeaderWidget extends StatelessWidget {
  final String label;
  final String subtype;

  HeaderWidget({
    required this.label,
    required this.subtype,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (subtype == 'h1')
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(label,textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    color: HexColor.fromHex("000000"),
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          )
          else if(subtype == 'h2' || subtype == 'h3')
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(label,textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    color: HexColor.fromHex("000000"),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          )
        else if(subtype == 'h4' || subtype == 'h5')
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(label,textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: HexColor.fromHex("000000"),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            )
        else
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(label,textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    color: HexColor.fromHex("000000"),
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }
}
