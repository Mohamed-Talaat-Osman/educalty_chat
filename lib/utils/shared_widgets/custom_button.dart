import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/color_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {this.onTap,
      required this.text,
      this.height,
      this.width,
      this.color,
      this.radius,
      this.fontSize,
      super.key});
  final String text;
  final Color? color;
  final double? height;
  final double? width;
  final void Function()? onTap;
  final double? radius;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? 100.w,
        decoration: BoxDecoration(
            color: color ?? ColorManager.primaryColor,
            borderRadius: BorderRadius.circular(radius ?? 10)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}



