class AuthorModel {
  AuthorModel({
    this.loginname,
    this.avatarUrl,
  });

  final String loginname;
  final String avatarUrl;

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
        loginname: json["loginname"],
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "loginname": loginname,
        "avatar_url": avatarUrl,
      };
}
