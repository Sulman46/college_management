class ProgramRequestModel {

  String? id;
  String name;
  String code;

  String department;
  String affiliationName;

  String degree;
  String session;
  String section;

  String status;

  int mids;
  int sessional;
  int finalMarks;

  int totalTheory;
  int theoryPassPercentage;

  int practicalMax;
  int practicalPassPercentage;

  ProgramRequestModel({
    required this.id,
    required this.name,
    required this.code,
    required this.department,
    required this.affiliationName,
    required this.degree,
    required this.session,
    required this.section,
    required this.status,
    required this.mids,
    required this.sessional,
    required this.finalMarks,
    required this.totalTheory,
    required this.theoryPassPercentage,
    required this.practicalMax,
    required this.practicalPassPercentage,
  });

  Map<String, dynamic> toMap() {

    return {

      "name": name,
      "code": code,

      "department": department,
      "affiliationName": affiliationName,

      "degree": degree,
      "session": session,
      "section": section,

      "status": status,

      "mids": mids,
      "sessional": sessional,
      "final": finalMarks,

      "totalTheory": totalTheory,
      "theoryPassPercentage": theoryPassPercentage,

      "practicalMax": practicalMax,
      "practicalPassPercentage":
      practicalPassPercentage,
    };
  }
}