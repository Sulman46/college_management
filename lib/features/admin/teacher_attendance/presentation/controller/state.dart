import 'package:equatable/equatable.dart';

abstract class TeacherAttendanceState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class TeacherAttendanceInit extends TeacherAttendanceState{}
class TeacherAttendanceLoading extends TeacherAttendanceState{}
class TeacherAttendanceLoaded extends TeacherAttendanceState{}
class TeacherAttendanceError extends TeacherAttendanceState{}
