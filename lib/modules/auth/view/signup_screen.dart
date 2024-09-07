import 'package:educalty_chat/modules/auth/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/assets_manager.dart';
import '../../../core/go_to.dart';
import '../../../utils/shared_widgets/custom_button.dart';
import '../../../utils/shared_widgets/custom_text_field.dart';
import '../../../utils/shared_widgets/tools.dart';
import '../controller/auth_provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: SingleChildScrollView(
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
                controller: authProvider.signupName,
                width: 80.w,
                hintText: 'name',
                maxLines: 1,
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomTextField(
                controller: authProvider.signupEmail,
                width: 80.w,
                hintText: 'email',
                maxLines: 1,
                keybordType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomTextField(
                controller: authProvider.signupPass,
                width: 80.w,
                hintText: 'password',
                maxLines: 1,
                showEyeIcon: true,
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomTextField(
                controller: authProvider.signupConfirmPass,
                width: 80.w,
                hintText: 'confirm password',
                maxLines: 1,
                showEyeIcon: true,
              ),
              SizedBox(
                height: 5.h,
              ),
              Consumer<AuthProvider>(builder: (ctx, provider, child) {
                return provider.signupLoading
                    ? Tools.loader()
                    : CustomButton(
                        text: 'signup',
                        width: 80.w,
                        onTap: () {
                          if (authProvider.signupName.text.isEmpty ||
                              authProvider.signupEmail.text.isEmpty ||
                              authProvider.signupPass.text.isEmpty) {
                            Tools.showToast(
                                message: "please enter your email and password",
                                isSuccess: false,
                                context: context);
                          } else if (authProvider.signupPass.text !=
                              authProvider.signupConfirmPass.text) {
                            Tools.showToast(
                                message: "wrong password",
                                isSuccess: false,
                                context: context);
                          } else {
                            authProvider.signup(context);
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
                  const Text("already have account ? "),
                  InkWell(
                      onTap: () {
                        GoTo.screenAndReplacement(const LoginScreen());
                      },
                      child: const Text(
                        "login",
                        style: TextStyle(color: Colors.deepOrange),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
