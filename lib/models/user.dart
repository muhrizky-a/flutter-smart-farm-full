class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.token,
    required this.picturePath,
    this.photoUrl = "",
  });

  final int id;
  final String name;
  final String username;
  final String token;
  final String? picturePath;
  final String photoUrl;

  @override
  bool operator ==(Object other) {
    return other is User && hashCode == other.hashCode;
  }

  @override
  int get hashCode => id;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      picturePath: json['picture_path'],
      photoUrl: json['picture_link'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['picture_path'] = picturePath;
    data['picture_link'] = photoUrl;

    data['token'] = token;

    return data;
  }
}
