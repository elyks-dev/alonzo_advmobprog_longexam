class UserModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final String image;
  const UserModel(
      {required this.id,
      required this.username,
      required this.name,
      required this.email,
      this.image = ''});
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim(),
      email: json['email'] ?? '',
      image: json['image'] ?? '');
}
