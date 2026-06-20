class NeuralGenerateModel {
  final String? name;
  final String? userName;
  final String? password;
  final String? email;
  final String? role;

  NeuralGenerateModel({
    this.name,
    this.userName,
    this.password,
    this.email,
    this.role,
  });

  factory NeuralGenerateModel.fromMap(Map<String, dynamic> map) {
    return NeuralGenerateModel(
      name: map['name'] ?? '',
      userName: map['username'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (name != null) 'name': name,
      if (userName != null) 'username': userName,
      if (password != null) 'password': password,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
    };
  }

  NeuralGenerateModel copyWith({
    String? name,
    String? userName,
    String? password,
    String? email,
    String? role,
  }) {
    return NeuralGenerateModel(
      name: name ?? this.name,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  @override
  String toString() {
    return 'NeuralGenerateModel(name: $name, userName: $userName, password: $password, email: $email, role: $role)';
  }
}