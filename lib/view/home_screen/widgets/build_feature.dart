
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class TBuildFeature extends StatelessWidget {
  const TBuildFeature({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: const Color.fromARGB(255, 244, 251, 245),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: SizedBox(
            height: 80,
            // decoration: BoxDecoration(
            //  color: Colors.green.shade10,
            //   border: Border.all(color: Colors.grey),
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 24, color: Colors.green.shade800),

                const SizedBox(height: 8),
                Text(title, style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          
                        ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
