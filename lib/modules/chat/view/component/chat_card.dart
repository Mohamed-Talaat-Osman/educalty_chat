import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educalty_chat/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';


class ChatCard extends StatelessWidget {
  const ChatCard({
    this.message,
    this.sentAt,
    this.senderId,
    super.key
  });
  final String? message;
  final Timestamp? sentAt;
  final String? senderId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: senderId == AppConstants.userData?.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        BubbleSpecialThree(
          text: message ?? "",
          color: senderId != AppConstants.userData?.uid ? Colors.grey.withOpacity(0.5) : Colors.green,
          tail: true,
          isSender: senderId != AppConstants.userData?.uid ? false : true,
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16
          ),
        ),
        Text(
        DateFormat('hh:mm').format(sentAt!.toDate()),
          textAlign: senderId == AppConstants.userData?.uid ? TextAlign.end : TextAlign.start,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 10
          ),
        )
      ],
    );

      Container(
      decoration: BoxDecoration(
        color: senderId != AppConstants.userData?.uid ? Colors.grey.withOpacity(0.3) : Colors.green,
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(10),
          topLeft: const Radius.circular(10),
          bottomLeft: senderId != AppConstants.userData?.uid ? Radius.zero : const Radius.circular(10),
          bottomRight: senderId != AppConstants.userData?.uid ? const Radius.circular(8) : Radius.zero,
        )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
        child: Text(
          message ?? "",
          maxLines: 10,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
