import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? senderID;
  String? content;
  Timestamp? sentAt;

  MessageModel({
    this.senderID,
    this.content,
    this.sentAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderID = json['senderID'];
    content = json['content'];
    sentAt = json['sentAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderID'] = senderID;
    data['content'] = content;
    data['sentAt'] = sentAt;
    return data;
  }
}
