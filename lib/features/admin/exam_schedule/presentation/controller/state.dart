import 'package:equatable/equatable.dart';

abstract class ExamScheduleState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class ExamScheduleInit extends ExamScheduleState{}
class ExamScheduleLoading extends ExamScheduleState{}
class ExamScheduleLoaded extends ExamScheduleState{}
class ExamScheduleError extends ExamScheduleState{}
