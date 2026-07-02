import 'package:equatable/equatable.dart';

abstract class StudentResultState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class StudentResultInit extends StudentResultState{}
class StudentResultLoading extends StudentResultState{}
class StudentResultLoaded extends StudentResultState{}
class StudentResultError extends StudentResultState{}
