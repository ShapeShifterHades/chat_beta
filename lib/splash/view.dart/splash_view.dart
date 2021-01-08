import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: Text(
          'Loading...',
          style: GoogleFonts.jura(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
    );
  }
}
