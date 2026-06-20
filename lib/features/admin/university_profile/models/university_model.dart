import 'package:college_management/features/admin/university_profile/models/affiliation_model.dart';
import 'package:college_management/features/admin/university_profile/models/attendance_policy_model.dart';
import 'package:college_management/features/admin/university_profile/models/university_profile_model.dart';

class UniversityModel {

  List<AttendancePolicyModel>? attendancePolicyModel;
  List<AffiliationModel>? affiliationModel;
  UniversityProfileModel? universityProfileModel;
  String? id;

  UniversityModel({
    this.attendancePolicyModel,
    this.universityProfileModel,
    this.affiliationModel,
    this.id,
  });

  factory UniversityModel.fromMap(
      Map<String, dynamic> map) {

    return UniversityModel(

      universityProfileModel:
      map['profile'] != null
          ? UniversityProfileModel.fromMap(
        map['profile'],
      )
          : null,

      attendancePolicyModel:
      map['attendancePolicy'] != null
          ? (map['attendancePolicy'] as List)
          .map(
            (e) =>
            AttendancePolicyModel.fromMap(e),
      )
          .toList()
          : [],

      affiliationModel:
      map['affiliations'] != null
          ? (map['affiliations'] as List)
          .map(
            (e) =>
            AffiliationModel.fromMap(e),
      )
          .toList()
          : null,

      id: map['_id'],
    );
  }

  Map<String, dynamic> toMap() {

    final Map<String, dynamic> data = {};

    if (universityProfileModel != null) {
      data['profile'] =
          universityProfileModel!.toMap();
    }

    if (attendancePolicyModel != null) {
      data['attendancePolicy'] =
          attendancePolicyModel!
              .map((e) => e.toMap())
              .toList();
    }

    if (affiliationModel != null) {
      data['affiliations'] =
          affiliationModel!
              .map((e) => e.toMap())
              .toList();
    }

    if (id != null) {
      data['_id'] = id;
    }

    return data;
  }

  UniversityModel copyWith({
    List<AttendancePolicyModel>? attendancePolicyModel,
    List<AffiliationModel>? affiliationModel,
    UniversityProfileModel? universityProfileModel,
    String? id,
  }) {
    return UniversityModel(
      attendancePolicyModel:
      attendancePolicyModel ??
          this.attendancePolicyModel,

      affiliationModel:
      affiliationModel ??
          this.affiliationModel,

      universityProfileModel:
      universityProfileModel ??
          this.universityProfileModel,

      id: id ?? this.id,
    );
  }
}