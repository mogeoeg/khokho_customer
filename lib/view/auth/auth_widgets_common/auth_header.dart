
import 'package:flutter/material.dart';

class TAuthHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isLogoNeeded;
  const TAuthHeader({
    super.key,
    required this.title,
    required this.subTitle,
    this.isLogoNeeded = false,
  });

  @override
  Widget build(BuildContext context) {
    // return isLogoNeeded
    //     ? Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Container(
    //         height: 200,
    //         width: double.infinity,
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage(TImages.logImg),
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //       ),

    //         SizedBox(height: 8),

    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               title,
    //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    //             ),
    //             const SizedBox(height: 8),
    //             Text(subTitle),
    //           ],
    //         ),
    //       ],
    //     )
    //     :
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(subTitle),
          ],
        );
  }
}
