class HodAssignModel {
  final String? id;
  final String? teacherId;
  final String? teacherName;
  final String? departmentId;
  final String? departmentName;
  final DateTime? assignedDate;
  final String? status;

  HodAssignModel({
    this.id,
    this.teacherId,
    this.teacherName,
    this.departmentId,
    this.departmentName,
    this.assignedDate,
    this.status,
  });

  factory HodAssignModel.fromMap(Map<String, dynamic> map) {
    return HodAssignModel(
      id: map['_id'] ?? map['id'] ?? "",
      teacherId: map['teacherId'] ?? "",
      teacherName: map['teacherName'] ?? "",
      departmentId: map['departmentId'] ?? "",
      departmentName: map['departmentName'] ?? "",
      assignedDate: map['assignedDate'] != null
          ? DateTime.tryParse(map['assignedDate'].toString())
          : null,
      status: map['status'] ?? "Active",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null && id!.isNotEmpty) '_id': id,
      if (teacherId != null && teacherId!.isNotEmpty)
        'teacherId': teacherId,
      if (teacherName != null && teacherName!.isNotEmpty)
        'teacherName': teacherName,
      if (departmentId != null && departmentId!.isNotEmpty)
        'departmentId': departmentId,
      if (departmentName != null && departmentName!.isNotEmpty)
        'departmentName': departmentName,
      if (assignedDate != null)
        'assignedDate': assignedDate!.toIso8601String(),
      if (status != null && status!.isNotEmpty)
        'status': status,
    };
  }

  HodAssignModel copyWith({
    String? id,
    String? teacherId,
    String? teacherName,
    String? departmentId,
    String? departmentName,
    DateTime? assignedDate,
    String? status,
  }) {
    return HodAssignModel(
      id: id ?? this.id,
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
      departmentId: departmentId ?? this.departmentId,
      departmentName: departmentName ?? this.departmentName,
      assignedDate: assignedDate ?? this.assignedDate,
      status: status ?? this.status,
    );
  }
}