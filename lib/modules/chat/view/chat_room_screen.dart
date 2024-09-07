import 'package:educalty_chat/modules/chat/data/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/assets_manager.dart';
import '../../../utils/shared_widgets/custom_text_field.dart';
import '../../../utils/shared_widgets/no_data.dart';
import '../../../utils/shimmer_helper.dart';
import '../controller/chat_provider.dart';
import '../data/message_model.dart';
import 'component/chat_card.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({required this.name, required this.uid, super.key});

  final String name;
  final String uid;

  @override
  Widget build(BuildContext context) {
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.2),
              backgroundImage: Image.asset(
                AppAssets.logo,
              ).image,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextField(
              controller: chatProvider.messageController,
              width: 82.w,
              hintText: 'write a message...',
              onChanged: (v) {
                if (v.isNotEmpty) {
                  chatProvider.upIsTyping(
                      context, chatProvider.currantChatID!, true,uid);
                }
              },
              onEditingComplete: () {
                chatProvider.upIsTyping(
                    context, chatProvider.currantChatID!, false,uid);
              },
            ),
            InkWell(
              onTap: () {
                if(chatProvider.messageController.text.isNotEmpty){
                  chatProvider.sendMessage(context);
                }
              },
              child: const Icon(
                Icons.send_rounded,
                size: 35,
              ),
            ),
          ],
        ),
      ),
        floatingActionButtonLocation : FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
          height: 85.h,
          width: 100.w,
          color: Colors.black.withOpacity(0.9),
          child: StreamBuilder(
              stream: chatProvider.getChatMessages(context, uid),
              builder: (context, snapshot) {
                ChatModel? chat = snapshot.data?.data();
                List<MessageModel> messages = [];
                if(chat != null && chat.messages != null){
                  messages = chat.messages!;
                  chatProvider.messagesList = messages;
                }
                if (snapshot.hasData && snapshot.data != null) {
                  return ListView.separated(
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, index) {
                      return SizedBox(
                        width: 300,
                        child: ChatCard(
                          message: messages[index].content,
                          sentAt: messages[index].sentAt,
                          senderId: messages[index].senderID,
                        ),
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
              }),
        ),
      ),
    );
  }
}
