

import 'package:cnode_flutter2/models/author_model.dart';

class MessageModel {
  final List<Message> hasReadMessages;
  final List<Message> hasNotReadMessages;

  MessageModel({
    this.hasReadMessages,
    this.hasNotReadMessages,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        hasReadMessages: List<Message>.from(
            json["has_read_messages"].map((x) => Message.fromJson(x))),
        hasNotReadMessages: List<Message>.from(
            json["hasnot_read_messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "has_read_messages":
            List<dynamic>.from(hasReadMessages.map((x) => x.toJson())),
        "hasnot_read_messages":
            List<dynamic>.from(hasNotReadMessages.map((x) => x.toJson())),
      };
}

class Message {
  final String id;
  final String type;
  final bool hasRead;
  final AuthorModel author;
  final MessageTopic topic;
  final MessageReply reply;
  final DateTime createAt;

  Message({
    this.id,
    this.type,
    this.hasRead,
    this.author,
    this.topic,
    this.reply,
    this.createAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        type: json["type"],
        hasRead: json["has_read"],
        author: AuthorModel.fromJson(json["author"]),
        topic: MessageTopic.fromJson(json["topic"]),
        reply: MessageReply.fromJson(json["reply"]),
        createAt: DateTime.parse(json["create_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "has_read": hasRead,
        "author": author.toJson(),
        "topic": topic.toJson(),
        "reply": reply.toJson(),
        "create_at": createAt,
      };
}

class MessageReply {
  final String id;
  final String content;
  final List<dynamic> ups;
  final DateTime createAt;

  MessageReply({
    this.id,
    this.content,
    this.ups,
    this.createAt,
  });

  factory MessageReply.fromJson(Map<String, dynamic> json) => MessageReply(
        id: json["id"],
        content: json["content"],
        ups: List<dynamic>.from(json["ups"].map((x) => x)),
        createAt: DateTime.parse(json["create_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "ups": List<dynamic>.from(ups.map((x) => x)),
        "create_at": createAt,
      };
}

class MessageTopic {
  final String id;
  final String title;
  final DateTime lastReplyAt;

  MessageTopic({
    this.id,
    this.title,
    this.lastReplyAt,
  });

  factory MessageTopic.fromJson(Map<String, dynamic> json) => MessageTopic(
        id: json["id"],
        title: json["title"],
        lastReplyAt: DateTime.parse(json["last_reply_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "last_reply_at": lastReplyAt.toIso8601String(),
      };
}
