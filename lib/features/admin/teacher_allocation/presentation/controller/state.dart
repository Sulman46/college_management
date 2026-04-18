import 'package:equatable/equatable.dart';

abstract class TeacherAllocationState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class TeacherAllocationInit extends TeacherAllocationState{}
class TeacherAllocationLoading extends TeacherAllocationState{}
class TeacherAllocationLoaded extends TeacherAllocationState{}
class TeacherAllocationError extends TeacherAllocationState{}
