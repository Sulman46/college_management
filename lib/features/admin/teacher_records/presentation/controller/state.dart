import 'package:equatable/equatable.dart';

abstract class TeacherRecordsState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class TeacherRecordsInit extends TeacherRecordsState{}
class TeacherRecordsLoading extends TeacherRecordsState{}
class TeacherRecordsLoaded extends TeacherRecordsState{}
class TeacherRecordsError extends TeacherRecordsState{}
