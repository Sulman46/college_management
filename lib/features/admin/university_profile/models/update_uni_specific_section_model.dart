import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/university_profile/models/affiliation_model.dart';
import 'package:college_management/features/admin/university_profile/models/attendance_policy_model.dart';
import 'package:college_management/features/admin/university_profile/models/university_profile_model.dart';

class UpdateUniSpecificSectionModel {

  AttendancePolicyModel? attendancePolicyModel;
  AffiliationModel? affiliationModel;
  UniversityProfileModel? universityProfileModel;

  int? index;
  String? id;

  UpdateUniSpecificSectionModel({
    this.attendancePolicyModel,
    this.universityProfileModel,
    this.affiliationModel,
    this.index,
    this.id,
  });


  Map<String, dynamic> toMap() {

     Map<String, dynamic> data = {};

     // if (id != null) {
     //   data['_id'] = id;
     // }
     if(index!=null){
       data['index']=index;
     }

    if (universityProfileModel != null) {

      data['section']="profile";
      data['data'] = universityProfileModel?.toMap();
    }

    if (attendancePolicyModel != null) {
      data['section']="attendancePolicy";
      data['data'] = attendancePolicyModel?.toMap();
    }

    if (affiliationModel != null) {


      data['section']="affiliations";
      data['data'] = affiliationModel?.toMap();
    }

    return data;
  }

  String? deleteUrl(){
    if (affiliationModel != null) {
      return "affiliation/$index";
    }else if (attendancePolicyModel != null) {
      return "attendance/$index";
    }else{
      return null;
    }
  }

  UpdateUniSpecificSectionModel copyWith({
    AttendancePolicyModel? attendancePolicyModel,
    AffiliationModel? affiliationModel,
    UniversityProfileModel? universityProfileModel,
    int? index,
    String? id,
  }) {
    return UpdateUniSpecificSectionModel(
      attendancePolicyModel:
      attendancePolicyModel ?? this.attendancePolicyModel,
      affiliationModel:
      affiliationModel ??
          this.affiliationModel,
index: index??this.index,
      universityProfileModel:
      universityProfileModel ??
          this.universityProfileModel,

      id: id ?? this.id,
    );
  }
}