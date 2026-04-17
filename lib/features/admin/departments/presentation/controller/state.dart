import 'package:equatable/equatable.dart';

abstract class AdminDepartmentState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class AdminDepartmentInit extends AdminDepartmentState{}
class AdminDepartmentLoading extends AdminDepartmentState{}
class AdminDepartmentLoaded extends AdminDepartmentState{}
class AdminDepartmentError extends AdminDepartmentState{}
