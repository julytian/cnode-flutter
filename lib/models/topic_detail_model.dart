// To parse this JSON data, do
//
//     final topicDetailModel = topicDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:cnode_flutter2/models/author_model.dart';

TopicDetailModel topicDetailModelFromJson(String str) =>
    TopicDetailModel.fromJson(json.decode(str));

String topicDetailModelToJson(TopicDetailModel data) =>
    json.encode(data.toJson());

class TopicDetailModel {
  TopicDetailModel({
    this.id,
    this.authorId,
    this.tab,
    this.content,
    this.title,
    this.lastReplyAt,
    this.good,
    this.top,
    this.replyCount,
    this.visitCount,
    this.createAt,
    this.author,
    this.replies,
    this.isCollect,
  });

  String id;
  String authorId;
  String tab;
  String content;
  String title;
  DateTime lastReplyAt;
  bool good;
  bool top;
  int replyCount;
  int visitCount;
  DateTime createAt;
  AuthorModel author;
  List<Reply> replies;
  bool isCollect;

  factory TopicDetailModel.fromJson(Map<String, dynamic> json) =>
      TopicDetailModel(
        id: json["id"],
        authorId: json["author_id"],
        tab: json["tab"],
        content: json["content"],
        title: json["title"],
        lastReplyAt: DateTime.parse(json["last_reply_at"]),
        good: json["good"],
        top: json["top"],
        replyCount: json["reply_count"],
        visitCount: json["visit_count"],
        createAt: DateTime.parse(json["create_at"]),
        author: AuthorModel.fromJson(json["author"]),
        replies:
            List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
        isCollect: json["is_collect"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author_id": authorId,
        "tab": tab,
        "content": content,
        "title": title,
        "last_reply_at": lastReplyAt.toIso8601String(),
        "good": good,
        "top": top,
        "reply_count": replyCount,
        "visit_count": visitCount,
        "create_at": createAt.toIso8601String(),
        "author": author.toJson(),
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
        "is_collect": isCollect,
      };
}

class Reply {
  Reply({
    this.id,
    this.author,
    this.content,
    this.ups,
    this.createAt,
    this.replyId,
    this.isUped,
  });

  String id;
  AuthorModel author;
  String content;
  List<String> ups;
  DateTime createAt;
  String replyId;
  bool isUped;

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"],
        author: AuthorModel.fromJson(json["author"]),
        content: json["content"],
        ups: List<String>.from(json["ups"].map((x) => x)),
        createAt: DateTime.parse(json["create_at"]),
        replyId: json["reply_id"] == null ? null : json["reply_id"],
        isUped: json["is_uped"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author.toJson(),
        "content": content,
        "ups": List<dynamic>.from(ups.map((x) => x)),
        "create_at": createAt.toIso8601String(),
        "reply_id": replyId == null ? null : replyId,
        "is_uped": isUped,
      };
}
