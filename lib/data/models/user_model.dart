class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? token;
  final String? profileImage;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.token,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      profileImage: json['profileImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'profileImage': profileImage,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
    String? profileImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
