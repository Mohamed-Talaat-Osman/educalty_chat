import 'package:educalty_chat/modules/auth/view/signup_screen.dart';
import 'package:educalty_chat/utils/assets_manager.dart';
import 'package:educalty_chat/core/go_to.dart';
import 'package:educalty_chat/utils/shared_widgets/custom_button.dart';
import 'package:educalty_chat/utils/shared_widgets/custom_text_field.dart';
import 'package:educalty_chat/utils/shared_widgets/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../controller/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.logo,
              width: 80.w,
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomTextField(
              controller: authProvider.email,
              width: 80.w,
              hintText: 'email',
              maxLines: 1,
              keybordType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 3.h,
            ),
            CustomTextField(
              controller: authProvider.pass,
              width: 80.w,
              hintText: 'password',
              maxLines: 1,
              showEyeIcon: true,
            ),
            SizedBox(
              height: 5.h,
            ),
            Consumer<AuthProvider>(builder: (ctx, provider, child) {
              return provider.loginLoading
                  ? Tools.loader()
                  : CustomButton(
                      text: 'login',
                      width: 80.w,
                      onTap: () {
                        if (authProvider.email.text.isEmpty ||
                            authProvider.pass.text.isEmpty) {
                          Tools.showToast(
                              message: "please enter your email and password",
                              isSuccess: false,
                              context: context);
                        } else {
                          authProvider.login(context);
                        }
                      },
                    );
            }),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("don't have account ? "),
                InkWell(
                    onTap: () {
                      GoTo.screenAndReplacement(const SignupScreen());
                    },
                    child: const Text(
                      "signup",
                      style: TextStyle(color: Colors.deepOrange),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
