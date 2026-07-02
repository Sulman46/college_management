class FreezeRequestModel {
  final String? id;
  final String? studentId;
  final String? srNo;
  final String? studentName;
  final String? department;
  final String? program;
  final String? section;
  final String? session;
  final String? semesterId;
  final String? semesterAtRequest;
  final String? requestType;
  final String? reason;
  final String? requestStatus;
  final String? attachmentUrl;
  final String? adminRemarks;
  final String? requestDate;

  FreezeRequestModel({
    this.id,
    this.studentId,
    this.srNo,
    this.studentName,
    this.department,
    this.program,
    this.section,
    this.session,
    this.semesterId,
    this.semesterAtRequest,
    this.requestType,
    this.reason,
    this.requestStatus,
    this.attachmentUrl,
    this.adminRemarks,
    this.requestDate,
  });

  factory FreezeRequestModel.fromMap(Map<String, dynamic> map) {
    return FreezeRequestModel(
      id: map['_id'],
      studentId: map['studentId'],
      srNo: map['srNo'],
      studentName: map['studentName'],
      department: map['department'],
      program: map['program'],
      section: map['section'],
      session: map['session'],
      semesterId: map['semesterId'],
      semesterAtRequest: map['semesterAtRequest'],
      requestType: map['requestType'],
      reason: map['reason'],
      requestStatus: map['requestStatus'],
      attachmentUrl: map['attachmentUrl'],
      adminRemarks: map['adminRemarks'],
      requestDate: map['requestDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'studentId': studentId,
      'srNo': srNo,
      'studentName': studentName,
      'department': department,
      'program': program,
      'section': section,
      'session': session,
      'semesterId': semesterId,
      'semesterAtRequest': semesterAtRequest,
      'requestType': requestType,
      'reason': reason,
      'requestStatus': requestStatus,
      'attachmentUrl': attachmentUrl,
      'adminRemarks': adminRemarks,
      'requestDate': requestDate,
    };
  }

  FreezeRequestModel copyWith({
    String? id,
    String? studentId,
    String? srNo,
    String? studentName,
    String? department,
    String? program,
    String? section,
    String? session,
    String? semesterId,
    String? semesterAtRequest,
    String? requestType,
    String? reason,
    String? requestStatus,
    String? attachmentUrl,
    String? adminRemarks,
    String? requestDate,
  }) {
    return FreezeRequestModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      srNo: srNo ?? this.srNo,
      studentName: studentName ?? this.studentName,
      department: department ?? this.department,
      program: program ?? this.program,
      section: section ?? this.section,
      session: session ?? this.session,
      semesterId: semesterId ?? this.semesterId,
      semesterAtRequest: semesterAtRequest ?? this.semesterAtRequest,
      requestType: requestType ?? this.requestType,
      reason: reason ?? this.reason,
      requestStatus: requestStatus ?? this.requestStatus,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      adminRemarks: adminRemarks ?? this.adminRemarks,
      requestDate: requestDate ?? this.requestDate,
    );
  }
}