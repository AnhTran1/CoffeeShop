class MUser {
  MUser({
    this.id,
    this.name,
    this.email,
    this.apiToken,
    this.emailVerifiedAt,
  });

  int id;
  String name;
  String email;
  String apiToken;
  dynamic emailVerifiedAt;

  factory MUser.fromJson(Map<String, dynamic> json) => MUser(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    apiToken: json["api_token"] == null ? null : json["api_token"],
    emailVerifiedAt: json["email_verified_at"],
  );
}

