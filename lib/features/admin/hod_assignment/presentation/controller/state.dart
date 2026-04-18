import 'package:equatable/equatable.dart';

abstract class HODAssignmentState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class HODAssignmentInit extends HODAssignmentState{}
class HODAssignmentLoading extends HODAssignmentState{}
class HODAssignmentLoaded extends HODAssignmentState{}
class HODAssignmentError extends HODAssignmentState{}
