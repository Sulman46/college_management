import 'dart:developer';

class CourseCatalogModel {
  final String? id;
  final String? courseCode;
  final String? courseTitle;
  final List<String>? departments;
  final String? department;
  final double? creditHours;
  final String? category;
  final String? type;
  final String? status;

  CourseCatalogModel({
    this.id,
    this.courseCode,
    this.courseTitle,
    this.departments,
    this.department,
    this.creditHours,
    this.category,
    this.type,
    this.status,
  });

  factory CourseCatalogModel.fromMap(Map<String, dynamic> map) {

 var data=CourseCatalogModel(
   id: map['_id']??"",
   courseCode: map['courseCode']??"",
   courseTitle: map['courseTitle']??"",
   departments:map['departments'] == null
       ? []
       : (map['departments'] as List)
       .map((e) => e.toString())
       .toList(),
   creditHours: double.parse(map['creditHours']!=null?"${map['creditHours']}":"0"),
   category: map['category']??"",
   type: map['type']??"",
   status: map['status']??"",
   department: null
 );
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'courseCode': courseCode,
      'courseTitle': courseTitle,

      'departments': departments,

      'creditHours': creditHours,
      'category': category,
      'type': type,

      if(status!=null)
      'status': status,
    };
  }

  CourseCatalogModel copyWith({
    String? id,
    String? courseCode,
    String? courseTitle,
    List<String>? departments,
    String? department,
    double? creditHours,
    String? category,
    String? type,
    String? status,
  }) {
    return CourseCatalogModel(
      id: id ?? this.id,
      courseCode: courseCode ?? this.courseCode,
      courseTitle: courseTitle ?? this.courseTitle,
      departments: departments ?? this.departments,
      department: department ?? this.department,
      creditHours: creditHours ?? this.creditHours,
      category: category ?? this.category,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}