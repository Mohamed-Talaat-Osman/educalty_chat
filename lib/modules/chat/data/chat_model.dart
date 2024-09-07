
import 'package:educalty_chat/modules/chat/data/message_model.dart';

class ChatModel {
  String? id;
  bool? isTyping;
  List<dynamic>? participating;
  List<MessageModel>? messages;

  ChatModel({
    this.id,
    this.isTyping,
    this.participating,
    this.messages,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isTyping = json['isTyping'];
    participating = json['participating'];
    if (json['messages'] != null) {
      messages = <MessageModel>[];
      json['messages'].forEach((v) {
        messages!.add(new MessageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isTyping'] = isTyping;
    data['participating'] = participating;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
