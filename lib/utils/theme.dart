// import 'package:ev/utils/colors.dart';
// import 'package:flutter/material.dart';

// class TextBoxTheme {
//   static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
//     filled: true,
//     fillColor: Colors.grey[100], // light background for input
//     errorMaxLines: 2,

//     prefixIconColor: Color(0xFF4F4F4F),
//     suffixIconColor: Color(0xFF4F4F4F),

//     labelStyle: TextStyle(
//       fontSize: 15,
//       fontWeight: FontWeight.w600,
//       color: Color(0xFF4F4F4F),
//     ),
//     hintStyle: TextStyle(
//       fontSize: 15,
//       fontWeight: FontWeight.w500,
//       color: Colors.black54,
//     ),
//     errorStyle: TextStyle(
//       fontSize: 13,
//       fontWeight: FontWeight.w600,
//       color: Colors.redAccent,
//     ),
//     floatingLabelStyle: const TextStyle().copyWith(
//       color: TColors.primary,
//       fontWeight: FontWeight.w600,
//     ),

//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(
//         width: 1,
//         color: Color(0xFFE0E0E0),
//       ),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(
//         width: 1,
//         color: Color(0xFFBDBDBD),
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(
//         width: 1,
//         color: TColors.primary,
//       ),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(
//         width: 1,
//         color: Colors.redAccent,
//       ),
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(
//         width: 1,
//         color: Colors.redAccent,
//       ),
//     ),

//     // decrease box height
//     constraints: const BoxConstraints(
//       minHeight: 50,
//     ),
//   );
// }
import 'package:ev/utils/colors.dart';
import 'package:flutter/material.dart';

class TextBoxTheme {
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
    errorMaxLines: 2,

    prefixIconColor: const Color(0xFF4F4F4F),
    suffixIconColor: const Color(0xFF4F4F4F),

    labelStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Color(0xFF4F4F4F),
    ),
    hintStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    ),
    errorStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Colors.redAccent,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: TColors.primary,
      fontWeight: FontWeight.w600,
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFE0E0E0),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFBDBDBD),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 1,
        color: TColors.primary,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.redAccent,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.redAccent,
      ),
    ),

    // 🔽 reduce height by lowering vertical padding
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 10,
    ),

    constraints: const BoxConstraints(minHeight: 42), // reduce box height
  );
}
