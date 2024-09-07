import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educalty_chat/modules/auth/data/user_model.dart';
import 'package:educalty_chat/modules/chat/data/chat_model.dart';
import 'package:educalty_chat/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/controller/auth_provider.dart';
import '../data/message_model.dart';

class ChatProvider extends ChangeNotifier {
  DateTime? currentBackPressTime;

  /// Retrieves a stream of user profiles excluding the current user.
  Stream<QuerySnapshot<UserModel>>? getUsersProfiles(BuildContext context) {
    return Provider.of<AuthProvider>(context, listen: false)
        .usersCollection
        ?.where('uid', isNotEqualTo: AppConstants.userData?.uid)
        .snapshots() as Stream<QuerySnapshot<UserModel>>?;
  }

  /// Generates a unique chat ID based on two user IDs.
  String generateChatId({required String uid1, required String uid2}) {
    List<String> uids = [uid1, uid2];
    // Sort user IDs to ensure consistent chat ID generation
    uids.sort();
    String chatID = uids.fold("", (id, uid) => "$id$uid");
    return chatID;
  }

  /// Checks if a chat already exists between the current user and the receiver.
  Future<bool> checkChatExists(BuildContext context, {required String receiverId}) async {
    String chatID = generateChatId(uid1: AppConstants.userData!.uid, uid2: receiverId);
    final result = await Provider.of<AuthProvider>(context, listen: false)
        .chatCollection
        ?.doc(chatID)
        .get();
    return result?.exists ?? false; // Return true if chat exists
  }

  /// Creates a new chat document in Firestore for the current user and the receiver.
  Future<void> createNewChat(BuildContext context, {required String receiverId}) async {
    try {
      String chatID = generateChatId(uid1: AppConstants.userData!.uid, uid2: receiverId);
      final docRef = Provider.of<AuthProvider>(context, listen: false)
          .chatCollection
          ?.doc(chatID);
      final chat = ChatModel(
        id: chatID,
        participating: [AppConstants.userData!.uid, receiverId],
        isTyping: false,
        messages: [],
      );
      await docRef?.set(chat); // Save chat to Firestore
    } catch (e) {
      log("Error creating chat: $e");
    }
  }

  List<MessageModel>? messagesList; // List to hold messages

  /// Updates the typing status for the chat.
  Future<void> upIsTyping(BuildContext context, String chatID, bool status, String receiverId) async {
    final docRef = Provider.of<AuthProvider>(context, listen: false)
        .chatCollection
        ?.doc(chatID);
    await docRef?.update(
      ChatModel(
        id: chatID,
        participating: [AppConstants.userData!.uid, receiverId],
        isTyping: status,
        messages: messagesList,
      ).toJson(),
    );
  }

  /// Retrieves a stream of messages for a specific chat.
  Stream<DocumentSnapshot<ChatModel>> getChatMessages(BuildContext context, String receiverId) {
    String chatID = generateChatId(uid1: AppConstants.userData!.uid, uid2: receiverId);
    currantChatID = chatID; // Store the current chat ID
    return Provider.of<AuthProvider>(context, listen: false)
        .chatCollection
        ?.doc(currantChatID)
        .snapshots() as Stream<DocumentSnapshot<ChatModel>>;
  }

  TextEditingController messageController = TextEditingController(); // Controller for message input
  String? currantChatID; // Holds the current chat ID

  /// Sends a message and updates the Firestore document.
  Future<void> sendMessage(BuildContext context) async {
    final docRef = Provider.of<AuthProvider>(context, listen: false)
        .chatCollection
        ?.doc(currantChatID);
    await docRef?.update({
      "messages": FieldValue.arrayUnion([
        MessageModel(
          senderID: AppConstants.userData!.uid,
          content: messageController.text,
          sentAt: Timestamp.now(),
        ).toJson(),
      ]),
    });
    messageController.clear(); // Clear the input field after sending
  }
}