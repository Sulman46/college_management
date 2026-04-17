import 'package:equatable/equatable.dart';

abstract class AdminProgramsState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class AdminProgramsInit extends AdminProgramsState{}
class AdminProgramsLoading extends AdminProgramsState{}
class AdminProgramsLoaded extends AdminProgramsState{}
class AdminProgramsError extends AdminProgramsState{}
