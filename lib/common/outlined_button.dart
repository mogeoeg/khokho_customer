import 'package:ev/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class TOutlinedButton extends StatelessWidget {
  final String buttonTitle;
  final Callback onTap;
  final Color color;
  const TOutlinedButton({
    super.key,
    required this.buttonTitle,
    this.color = TColors.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 44), // full width & height
        side: BorderSide(color: color), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        buttonTitle,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color, 
        ),
      ),
    );
  }
}
