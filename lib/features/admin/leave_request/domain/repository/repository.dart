import 'package:dartz/dartz.dart';

import '../../models/faculty_leave_model.dart';
import '../../models/teacher_send_leave_request_model.dart';

abstract class LeaveRequestRepository{
  Future<Either<String,String>> post({required TeacherSendLeaveRequestModel value});
  Future<Either<String,String>> update({required FacultyLeaveModel value});
  Future<Either<String,String>> delete({required FacultyLeaveModel value});
  Future<Either<String,List<FacultyLeaveModel>>> get();}