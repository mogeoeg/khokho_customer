import 'package:flutter/material.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlaycolor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = 8,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlaycolor;
  final Color? backgroundColor;
  final double width, height, padding;
  @override
  Widget build(BuildContext context) {
   // final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        // if image background color is null then switch it to light and dark mode color design.
        color: backgroundColor ?? (  Colors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image(
        image:
            isNetworkImage
                ? NetworkImage(image)
                : AssetImage(image) as ImageProvider,
        color: overlaycolor,
        fit: fit,
      ),
    );
  }
}
