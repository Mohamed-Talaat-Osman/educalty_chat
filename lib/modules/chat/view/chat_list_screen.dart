import 'package:educalty_chat/modules/auth/data/user_model.dart';
import 'package:educalty_chat/modules/chat/controller/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/assets_manager.dart';
import '../../../utils/shared_widgets/no_data.dart';
import '../../../utils/shared_widgets/tools.dart';
import '../../../utils/shimmer_helper.dart';
import '../../auth/controller/auth_provider.dart';
import 'component/user_card.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return PopScope(
      canPop: false,
      onPopInvoked:(v)async{
        DateTime now = DateTime.now();
        if (chatProvider.currentBackPressTime == null ||
            now.difference(chatProvider.currentBackPressTime!) >
                const Duration(seconds: 2)){
          Tools.showToast(
              message: "please tap back again to exit",
              isSuccess: true,
              context: context);
        }else{
          await authProvider.upDateOnline(status: false);
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Image.asset(
            AppAssets.logo,
            width: 35.w,
          ),
          actions: [
            InkWell(
                onTap: () {
                  authProvider.logout();
                },
                child: const Icon(Icons.logout,)),
            SizedBox(width: 2.w,),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
          width: 100.w,
          height: 100.h,
          color: Colors.black.withOpacity(0.9),
          child: StreamBuilder(
            stream: chatProvider.getUsersProfiles(context),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView.separated(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (BuildContext context, index) {
                    UserModel user = snapshot.data!.docs[index].data();
                    return UserCard(
                      name: user.name ?? "",
                      uid: user.uid ?? "",
                      online: user.online ?? false,
                    );
                  },
                  separatorBuilder: (BuildContext context, index) {
                    return SizedBox(
                      height: 1.h,
                    );
                  },
                );
              }
              if (snapshot.hasError || snapshot.data == null) {
                return const AppNoData();
              }
              return ShimmerHelper().buildUsersShimmer();
            },
          ),
        ),
      ),
    );
  }
}
