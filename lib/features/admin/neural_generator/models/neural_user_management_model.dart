class NeuralUserManagementModel {
  final String? id;
  final String? previousRole;
  final String? name;
  final String? email;
  final String? username;
  final String? role;
  final String? department;
  final String? status;
  final String? profileImg;
  final String? createdAt;
  final String? updatedAt;

  NeuralUserManagementModel({
    this.id,
    this.previousRole,
    this.name,
    this.email,
    this.username,
    this.role,
    this.department,
    this.status,
    this.profileImg,
    this.createdAt,
    this.updatedAt,
  });


  factory NeuralUserManagementModel.fromMap(Map<String, dynamic> map) {
    return NeuralUserManagementModel(
      id: map['_id'],
      previousRole: map['previousRole'],
      name: map['name'],
      email: map['email'],
      username: map['username'],
      role: map['role'],
      department: map['department'],
      status: map['status'],
      profileImg: map['profileImg'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'previousRole': previousRole,
      'name': name,
      'email': email,
      'username': username,
      'role': role,
      'department': department,
      'status': status,
      'profileImg': profileImg,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }


  NeuralUserManagementModel copyWith({
    String? id,
    String? previousRole,
    String? name,
    String? email,
    String? username,
    String? role,
    String? department,
    String? status,
    String? profileImg,
    String? createdAt,
    String? updatedAt,
  }) {
    return NeuralUserManagementModel(
      id: id ?? this.id,
      previousRole: previousRole ?? this.previousRole,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      role: role ?? this.role,
      department: department ?? this.department,
      status: status ?? this.status,
      profileImg: profileImg ?? this.profileImg,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

}