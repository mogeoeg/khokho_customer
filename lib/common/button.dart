// import 'package:ev/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// class TNavigationButton extends StatelessWidget {
//   final String buttonTitle;
//   final Callback onTap;
//   final Color color;
//   final bool isDisabled;
//   const TNavigationButton({
//     super.key,
//     required this.buttonTitle,
//     this.color = TColors.primary,
//     required this.onTap,
//     this.isDisabled = false, // <-- Default to false
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors
//           .transparent, // keep transparent so your container's color shows
//       borderRadius: BorderRadius.circular(8),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(
//           8,
//         ), // match ripple to container shape
//         onTap: isDisabled ? null : onTap,
//         child: Container(
//           height: 44,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Center(
//             child: Text(
//               buttonTitle,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//   }
// }


import 'package:flutter/material.dart';
import 'package:ev/utils/colors.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class TNavigationButton extends StatelessWidget {
  final String buttonTitle;
  final Callback onTap;
  final Color color;
  final bool isDisabled;
  final Widget? child;

  
  const TNavigationButton({
    super.key,
    required this.buttonTitle,
    this.color = TColors.primary,
    required this.onTap,
    this.isDisabled = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: isDisabled ? null : onTap,
        child: Container(
          height: 44,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDisabled ? const Color.fromARGB(75, 7, 154, 76) : color, // <-- inactive color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: child?? Text(
              buttonTitle,
             // textAlign: TextAlign.center,
              
              style: TextStyle(
                fontSize: 16,
                
                fontWeight: FontWeight.bold,
                color: isDisabled ? Colors.white : Colors.white, // text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
