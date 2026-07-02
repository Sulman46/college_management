import 'package:equatable/equatable.dart';

abstract class MarkingStudentState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class MarkingStudentInit extends MarkingStudentState{}
class MarkingStudentLoading extends MarkingStudentState{}
class MarkingStudentLoaded extends MarkingStudentState{}
class MarkingStudentError extends MarkingStudentState{}
