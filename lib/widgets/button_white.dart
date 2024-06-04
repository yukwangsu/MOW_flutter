import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/info_screen_2.dart';

class ButtonWhite extends StatelessWidget {
  final String text;
  final Color bgcolor;
  final Color textColor;
  final Color borderColor;

  const ButtonWhite({
    super.key,
    required this.text,
    required this.bgcolor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InfoScreen2(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'SF_Pro',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
