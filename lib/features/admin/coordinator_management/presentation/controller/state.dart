import 'package:equatable/equatable.dart';

abstract class CoordinatorManagementState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class CoordinatorManagementInit extends CoordinatorManagementState{}
class CoordinatorManagementLoading extends CoordinatorManagementState{}
class CoordinatorManagementLoaded extends CoordinatorManagementState{}
class CoordinatorManagementError extends CoordinatorManagementState{}
