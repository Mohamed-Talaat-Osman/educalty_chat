import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';


class Tools {
  static showToast({
    required String message,
    required bool isSuccess,
    required BuildContext context,
  }) {
    var fToast = FToast().init(context);
    return fToast.showToast(
      gravity: ToastGravity.BOTTOM,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
        decoration: BoxDecoration(
          color: isSuccess ? Colors.green : Colors.redAccent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: SizedBox(
          width: 80.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSuccess ? Icons.check : Icons.clear,
                color: Colors.white,
              ),
              const SizedBox(
                width: 6,
              ),
              SizedBox(
                width: 70.w,
                child: Text(
                  message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static loader() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    );
  }
}





