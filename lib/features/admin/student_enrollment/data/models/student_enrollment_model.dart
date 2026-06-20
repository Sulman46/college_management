import 'dart:developer';

class StudentEnrollmentModel {
  final String? id;
  final String? studentId;
  final String? srNo;
  final String? rollNo;
  final String? name;
  final String? semester;
  final String? section;
  final String? session;
  final String? department;
  final String? programName;
  final String? degree;
  final String? affiliation;
  final String? status;
  final String? rollNumberSlip;

  StudentEnrollmentModel({
    this.id,
    this.studentId,
    this.srNo,
    this.rollNo,
    this.name,
    this.semester,
    this.section,
    this.session,
    this.department,
    this.programName,
    this.degree,
    this.affiliation,
    this.status,
    this.rollNumberSlip,
  });

  factory StudentEnrollmentModel.fromMap(Map<String, dynamic> map) {
    log("3242324: ${map}");
    return StudentEnrollmentModel(
      id: map['_id']?.toString(),
      studentId: map['studentId']?.toString(),
      srNo: map['srNo']?.toString(),
      rollNo: map['rollNo']?.toString(),
      name: map['name']?.toString(),
      semester: map['semester']?.toString(),
      section: map['section']?.toString(),
      session: map['session']?.toString(),
      department: map['department']?.toString(),
      programName: map['programName']?.toString(),
      degree: map['degree']?.toString(),
      affiliation: map['affiliation']?.toString(),
      status: map['status']?.toString(),
      rollNumberSlip: map['rollNumberSlip']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null && id!.isNotEmpty) '_id': id,
      'studentId': studentId,
      'srNo': srNo,
      'rollNo': rollNo,
      'name': name,
      'semester': semester,
      'section': section,
      'session': session,
      'department': department,
      'programName': programName,
      'degree': degree,
      'affiliation': affiliation,
      'status': status,
      'rollNumberSlip': rollNumberSlip,
    };
  }

  StudentEnrollmentModel copyWith({
    String? id,
    String? studentId,
    String? srNo,
    String? rollNo,
    String? name,
    String? semester,
    String? section,
    String? session,
    String? department,
    String? programName,
    String? degree,
    String? affiliation,
    String? status,
    String? rollNumberSlip,
  }) {
    return StudentEnrollmentModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      srNo: srNo ?? this.srNo,
      rollNo: rollNo ?? this.rollNo,
      name: name ?? this.name,
      semester: semester ?? this.semester,
      section: section ?? this.section,
      session: session ?? this.session,
      department: department ?? this.department,
      programName: programName ?? this.programName,
      degree: degree ?? this.degree,
      affiliation: affiliation ?? this.affiliation,
      status: status ?? this.status,
      rollNumberSlip: rollNumberSlip ?? this.rollNumberSlip,
    );
  }
}