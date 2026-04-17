import 'package:equatable/equatable.dart';

abstract class SemesterAdminState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class SemesterAdminInit extends SemesterAdminState{}
class SemesterAdminLoading extends SemesterAdminState{}
class SemesterAdminLoaded extends SemesterAdminState{}
class SemesterAdminError extends SemesterAdminState{}
