import 'package:dartz/dartz.dart';

import '../../models/faculty_leave_model.dart';

abstract class LeaveRequestRepository{
  Future<Either<String,String>> post({required FacultyLeaveModel value});
  Future<Either<String,String>> update({required FacultyLeaveModel value});
  Future<Either<String,String>> delete({required FacultyLeaveModel value});
  Future<Either<String,List<FacultyLeaveModel>>> get();}