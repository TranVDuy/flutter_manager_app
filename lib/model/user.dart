class User {
  String email;
  String password;
  DateTime created_at;
  DateTime updated_at;
  num profile_id;
  String? picture;
  String phone;

  User(
      {required this.email,
      required this.password,
      required this.created_at,
      required this.updated_at,
      required this.profile_id,
      required this.phone}) {
    this.picture = "https://robohash.org/${this.profile_id}";
  }

  factory User.fromJson(Map<String, dynamic> obj) {
    return User(
      email: obj["email"],
      password: obj["password"],
      created_at: obj["created_at"].toDouble(),
      updated_at: obj["updated_at"],
      phone: obj["phone"],
      profile_id: obj["profile_id"].toDouble(),
    );
  }

  // Map<String, dynamic> toJson() => _$UserToJson(this);
}
