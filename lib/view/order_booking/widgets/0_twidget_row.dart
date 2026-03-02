// ignore_for_file: file_names

import 'package:ev/utils/colors.dart';
import 'package:flutter/material.dart';

class TWidgetRow extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isTotal;

  const TWidgetRow({
    super.key,
    required this.title,
    required this.subTitle,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPaymentType = title == 'Payment Type';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500, fontSize: 15
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 15,
            color: isPaymentType ? TColors.primary : Colors.black87,
            fontWeight:
                isTotal
                    ? FontWeight.bold
                    : isPaymentType
                    ? FontWeight.bold
                    : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
