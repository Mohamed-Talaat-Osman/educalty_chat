import 'package:educalty_chat/modules/chat/view/chat_room_screen.dart';
import 'package:educalty_chat/core/go_to.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/assets_manager.dart';
import '../../controller/chat_provider.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {required this.name, required this.uid, required this.online, super.key});

  final String name;
  final String uid;
  final bool online;

  @override
  Widget build(BuildContext context) {
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return InkWell(
      onTap: () async {
        chatProvider
            .checkChatExists(context, receiverId: uid)
            .then((value) async {
          if (!value) {
            await chatProvider.createNewChat(context, receiverId: uid);
          }
          GoTo.screen(ChatRoomScreen(
            name: name,
            uid: uid,
          ));
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        height: 80,
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage: Image.asset(
                AppAssets.logo,
              ).image,
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'start chat.',
                  style: TextStyle(
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: 6,
              backgroundColor:
                  online ? Colors.green : Colors.black.withOpacity(0.4),
            ),
            SizedBox(
              width: 1.w,
            ),
            Text(
              online ? 'online' : 'offline',
              style: TextStyle(
                fontSize: 12,
                color: online ? Colors.green : Colors.black.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
