class DepartmentModel {
  String id;
  String name;
  String code;
  DepartmentStatus status;
  DateTime? date;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
    required this.date,
  });

  factory DepartmentModel.fromMap(
      Map<String, dynamic> map) {
    return DepartmentModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      status: map['status']!=null?map['status']=="Active" ? DepartmentStatus.Active:DepartmentStatus.Inactive:DepartmentStatus.Inactive,
      date: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'code': code,
      'status': status.name,
      'createdAt': date?.toIso8601String(),
    };
  }
}

enum DepartmentStatus{
  Active,Inactive,
}