import 'package:smartcast/src/domain/entities/user.dart';

class UserModel extends User {
  final String? token;

  const UserModel({
    required String id,
    required String email,
    required String fullName,
    String? phone,
    String? avatar,
    required DateTime createdAt,
    DateTime? updatedAt,
    this.token,
  }) : super(
          id: id,
          email: email,
          fullName: fullName,
          phone: phone,
          avatar: avatar,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      phone: json['phone'],
      avatar: json['avatar'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'avatar': avatar,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'token': token,
    };
  }
}
