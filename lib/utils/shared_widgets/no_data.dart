import '../../Utils/color_manager.dart';
import '../../utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'custom_button.dart';

class AppNoData extends StatelessWidget {
  const AppNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AppAssets.appNoData,
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'no data available',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
