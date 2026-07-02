
import 'package:dartz/dartz.dart';
import '../../../announcements/models/announcement_model.dart';
import '../../domain/repository/repository.dart';
import '../../models/bulk_save_marking_model.dart';
import '../../models/marking_student_filter_model.dart';
import '../../models/marks_student_model.dart';
import '../datasource/datasource.dart';

class MarkingStudentRepositoryImpl extends MarkingStudentRepository{
  final MarkingStudentDataSource dataSource;
  MarkingStudentRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,MarksResponseModel>> get({required MarkingStudentFilterModel model}) {
    return dataSource.get(model: model);
  }

  @override
  Future<Either<String,String>> bulkSaveData({required BulkSaveMarksRequest model}){
    return dataSource.bulkSaveData(model: model);
  }

  @override
  Future<Either<String,String>> lockStatus({required BulkSaveMarksRequest model}){
    return dataSource.lockStatus(model: model);
  }

}