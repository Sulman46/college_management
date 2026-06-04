import 'package:equatable/equatable.dart';

abstract class StudentEnrollmentState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class StudentEnrollmentInit extends StudentEnrollmentState{}
class StudentEnrollmentLoading extends StudentEnrollmentState{}
class StudentEnrollmentLoaded extends StudentEnrollmentState{}
class StudentEnrollmentError extends StudentEnrollmentState{}
