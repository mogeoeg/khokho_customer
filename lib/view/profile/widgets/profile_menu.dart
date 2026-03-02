import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProfileMenu extends StatelessWidget {
  const TProfileMenu({
    super.key,
    this.icon = Iconsax.arrow_right_34,
   // required this.onPressed,
    required this.title,
    required this.value,
  });

  final IconData? icon;
 // final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,

              style: TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
           Expanded(
            flex: 1,
            child: Text(
              ":",

              style: TextStyle(fontWeight: FontWeight.w500),
              
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w700),
              // style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
         // Expanded(child: Icon(icon, size: 18)),
        ],
      ),
    );
  }
}
