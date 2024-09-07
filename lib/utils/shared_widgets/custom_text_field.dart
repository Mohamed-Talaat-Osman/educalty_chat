import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/color_manager.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
        this.controller,
        this.focusNode,
        required this.hintText,
        this.hidden = false,
        this.autofill,
        this.suffixIcon,
        this.prefix,
        this.keybordType,
        this.validate,
        this.color,
        this.showEyeIcon = false,
        this.maxLines,
        this.width,
        this.textInputAction,
        this.onChanged,
        this.onEditingComplete});

  //final Function onChange;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool? hidden;
  final bool showEyeIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Iterable<String>? autofill;
  final TextInputType? keybordType;
  final String? Function(String?)? validate;
  final Color? color;
  final int? maxLines;
  final double? width;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;

  final void Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool get showEyeIcon => widget.showEyeIcon;
  bool? _showPasswordInState;

  @override
  void initState() {
    super.initState();
    showEyeIcon ?
      _showPasswordInState = true : false;

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 100.w,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: widget.onChanged,
        validator: widget.validate,
        keyboardType: widget.keybordType,
        controller: widget.controller,
        focusNode: widget.focusNode,
        autofillHints: widget.autofill,
        obscureText: _showPasswordInState ?? false,
        maxLines: widget.maxLines,
        onEditingComplete: widget.onEditingComplete,

        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          fillColor: ColorManager.lightGrey.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color ?? Colors.transparent,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color ?? Colors.transparent,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          suffixIcon: showEyeIcon ? buildEyeShowIcon() : null,
          prefixIcon: widget.prefix,
          prefixIconColor: ColorManager.lightGrey.withOpacity(0.5),
          contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: ColorManager.lightGrey.withOpacity(0.5),
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
          errorMaxLines: 1,
          errorStyle: TextStyle(
            fontSize: 9.sp,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color ?? ColorManager.lightGrey.withOpacity(0.5),
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color ?? ColorManager.red.withOpacity(0.5),
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color ?? ColorManager.red.withOpacity(0.5),
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color ?? Colors.transparent,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  void handleHidePassword() {
    if (widget.showEyeIcon) {
      setState(() {
        _showPasswordInState = !_showPasswordInState!;
      });
    }
  }

  Widget buildEyeShowIcon() {
    return GestureDetector(
      onTap: handleHidePassword,
      child: Container(
        color: Colors.transparent,
        child: Icon(
          _showPasswordInState ?? false ?
          Icons.visibility_off :  Icons.visibility,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget buildEyeHideIcon() {
    return GestureDetector(
      onTap: handleHidePassword,
      child: Container(
        color: Colors.transparent,
        child: const Icon(
          Icons.visibility,
          color: Colors.grey,
        ),
      ),
    );
  }
}
