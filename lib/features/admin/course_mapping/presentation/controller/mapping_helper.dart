import 'package:college_management/features/admin/course_catalog/models/course_catalog_model.dart';
import 'package:college_management/features/admin/course_mapping/model/course_mapping_model.dart';
import 'package:college_management/features/admin/semesters/models/semester_levels_model.dart';

class MappingHelper {
 static String? getSemesterId(List<SemesterLevelsModel> semesterList,CourseMappingModel courseMappingModel){

    var tempList=semesterList.where((element) => element.programModel?.departmentName==courseMappingModel.departmentName &&
        element.programModel?.departmentName==courseMappingModel.departmentName &&
      element.programModel?.name==courseMappingModel.programName &&
      element.programModel?.session== courseMappingModel.session &&
      element.programModel?.section == courseMappingModel.section &&
      element.semesterName == courseMappingModel.semesterName &&
      element.programModel?.degree== courseMappingModel.degree).toList();
    if(tempList.isNotEmpty){
      var model=tempList.first;
      return model.id;
    }
    return null;
  }


}