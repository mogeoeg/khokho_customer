import 'package:flutter/material.dart';

class PolicyText extends StatelessWidget {
  const PolicyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'By continuing, you agree that you have read and accept our ',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
          children: [
            TextSpan(
              text: 'T&Cs',
              style: TextStyle(decoration: TextDecoration.underline , fontWeight: FontWeight.w700, color: Colors.black),
            ),
            TextSpan(text: '  and  '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(decoration: TextDecoration.underline,  fontWeight: FontWeight.w700, color: Colors.black),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
