import '../../../core/enums/user_enums.dart';

class UserModel {
  final String id;
  final UserRole role;
  final String name;
  final String email;
  final String profileImg;
  final List<String> department;

  UserModel({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.profileImg,
    required this.department,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',

      role: json['role']!=null? json['role'] =="Admin"?UserRole.admin:json['role']=="Teacher"?UserRole.teacher:json['role']=="Coordinator"?UserRole.coordinator:json['role']=="Student"?UserRole.student:UserRole.student:UserRole.student,

      name: json['name'] ?? '',

      email: json['email'] ?? '',

      profileImg: json['profileImg'] ?? '',

      department: List<String>.from(
        json['department'] ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "role": role.toJson(),
      "name": name,
      "email": email,
      "profileImg": profileImg,
      "department": department,
    };
  }
}