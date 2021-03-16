// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cnode_flutter2/models/author_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.loginname,
    this.avatarUrl,
    this.githubUsername,
    this.createAt,
    this.score,
    this.accesstoken,
    this.id,
    this.recentTopics,
    this.recentReplies,
  });

  final String loginname;
  final String avatarUrl;
  final String githubUsername;
  final DateTime createAt;
  final int score;
  final String accesstoken;
  final String id;
  final List<Recent> recentTopics;
  final List<Recent> recentReplies;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        loginname: json["loginname"],
        avatarUrl: json["avatar_url"],
        githubUsername: json["githubUsername"],
        createAt: DateTime.parse(json["create_at"]),
        score: json["score"],
        accesstoken: json["accesstoken"],
        id: json["id"],
        recentTopics: List<Recent>.from(
            json["recent_topics"].map((x) => Recent.fromJson(x))),
        recentReplies: List<Recent>.from(
            json["recent_replies"].map((x) => Recent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "loginname": loginname,
        "avatar_url": avatarUrl,
        "githubUsername": githubUsername,
        "create_at": createAt.toIso8601String(),
        "score": score,
        "accesstoken": accesstoken,
        "id": id,
        "recent_topics":
            List<dynamic>.from(recentTopics.map((x) => x.toJson())),
        "recent_replies":
            List<dynamic>.from(recentReplies.map((x) => x.toJson())),
      };
}

class Recent {
  Recent({
    this.id,
    this.author,
    this.title,
    this.lastReplyAt,
  });

  final String id;
  final AuthorModel author;
  final String title;
  final DateTime lastReplyAt;

  factory Recent.fromJson(Map<String, dynamic> json) => Recent(
        id: json["id"],
        author: AuthorModel.fromJson(json["author"]),
        title: json["title"],
        lastReplyAt: DateTime.parse(json["last_reply_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author.toJson(),
        "title": title,
        "last_reply_at": lastReplyAt.toIso8601String(),
      };
}
