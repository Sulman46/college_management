class NeuralGenerateModel {
  final String? name;
  String? userId;
  String? id;
  final String? userName;
  final String? password;
  final String? email;
  final String? role;
  dynamic departmentValue;

  NeuralGenerateModel({
    this.id,
    this.name,
    this.userId,
    this.userName,
    this.password,
    this.email,
    this.role,
    this.departmentValue,
  });

  factory NeuralGenerateModel.fromMap(Map<String, dynamic> map) {
    return NeuralGenerateModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      userName: map['username'] ?? '',
      password: map['password'] ?? '',
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      departmentValue: map['departmentValue'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (userId != null) 'userId': userId,
      if (userName != null) 'username': userName,
      if (password != null) 'password': password,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (role != null) 'departmentValue': departmentValue,
    };
  }

  NeuralGenerateModel copyWith({
    String? id,
    String? name,
    String? userId,
    String? userName,
    String? password,
    String? email,
    String? role,
    String? departmentValue,
  }) {
    return NeuralGenerateModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      email: email ?? this.email,
      role: role ?? this.role,
      departmentValue: departmentValue ?? this.departmentValue,
    );
  }

  @override
  String toString() {
    return 'NeuralGenerateModel(name: $name, userName: $userName, password: $password, email: $email, role: $role)';
  }
}