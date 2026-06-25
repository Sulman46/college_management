
class CourseCatalogModel {
  final String? id;
  final String? courseCode;
  final String? courseTitle;
  final List<CourseCatalogDepartmentModel>? departments;
  final double? creditHours;
  final String? category;
  final String? type;
  final String? status;

  CourseCatalogModel({
    this.id,
    this.courseCode,
    this.courseTitle,
    this.departments,
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
       .map((e) =>CourseCatalogDepartmentModel.fromMap(e))
       .toList(),
   creditHours: double.parse(map['creditHours']!=null?"${map['creditHours']}":"0"),
   category: map['category']??"",
   type: map['type']??"",
   status: map['status']??"",
 );
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      if(id!=null)
        "_id":id,
      'courseCode': courseCode,
      'courseTitle': courseTitle,
      'departments': departments!.map((e) => e.toMap(),).toList(),
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
    List<CourseCatalogDepartmentModel>? departments,
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
      creditHours: creditHours ?? this.creditHours,
      category: category ?? this.category,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}



class CourseCatalogDepartmentModel {
  final String? id;
  final String? name;

  CourseCatalogDepartmentModel({
     this.id,
     this.name,
  });

  CourseCatalogDepartmentModel copyWith({
    String? id,
    String? name,
  }) {
    return CourseCatalogDepartmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
    };
  }

  factory CourseCatalogDepartmentModel.fromMap(Map<String, dynamic> map) {
    return CourseCatalogDepartmentModel(
      id: map['departmentId']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'CourseCatalogDepartmentModel(id: $id, name: $name)';
  }
}