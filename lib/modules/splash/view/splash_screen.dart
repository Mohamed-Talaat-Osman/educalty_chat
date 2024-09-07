
import 'package:educalty_chat/modules/auth/view/login_screen.dart';
import 'package:educalty_chat/modules/chat/view/chat_list_screen.dart';
import 'package:educalty_chat/utils/app_constants.dart';
import 'package:educalty_chat/core/go_to.dart';
import 'package:educalty_chat/utils/shared_widgets/once_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/assets_manager.dart';
import '../../auth/controller/auth_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return OnceFutureBuilder(future: () async {
      await authProvider.checkUserState();
      if (AppConstants.userData != null) {
        await authProvider.setupCollection();
        await authProvider.getUser();
        await authProvider.upDateOnline(status: true);
        GoTo.screenAndRemoveUntil(const ChatListScreen());
      } else {
        GoTo.screenAndRemoveUntil(const LoginScreen());
      }
    }, builder: (ctx, snapshot) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            AppAssets.logo,
            height: 60.w,
          ),
        ),
      );
    });
  }
}
