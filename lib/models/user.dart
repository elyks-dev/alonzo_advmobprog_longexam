class UserModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final String image;

  final String phone;
  final String gender;
  final String city;
  final String companyTitle;

  const UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    this.image = '',
    this.phone = '',
    this.gender = '',
    this.city = '',
    this.companyTitle = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? 0,
        username: json['username'] ?? '',
        name:
            '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim(),
        email: json['email'] ?? '',
        image: json['image'] ?? '',
        phone: json['phone'] ?? '',
        gender: json['gender'] ?? '',
        city: json['address']?['city'] ?? '',
        companyTitle: json['company']?['title'] ?? '',
      );
}