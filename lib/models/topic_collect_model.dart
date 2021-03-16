// To parse this JSON data, do
//
//     final topicCollectModel = topicCollectModelFromJson(jsonString);

import 'dart:convert';

import 'package:cnode_flutter2/models/author_model.dart';

TopicCollectModel topicCollectModelFromJson(String str) =>
    TopicCollectModel.fromJson(json.decode(str));

String topicCollectModelToJson(TopicCollectModel data) =>
    json.encode(data.toJson());

class TopicCollectModel {
  TopicCollectModel({
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
  });

  final String id;
  final String authorId;
  final String tab;
  final String content;
  final String title;
  final DateTime lastReplyAt;
  final bool good;
  final bool top;
  final int replyCount;
  final int visitCount;
  final DateTime createAt;
  final AuthorModel author;

  factory TopicCollectModel.fromJson(Map<String, dynamic> json) =>
      TopicCollectModel(
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
      };
}
