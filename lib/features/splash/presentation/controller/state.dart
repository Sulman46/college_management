import 'package:equatable/equatable.dart';

abstract class CubitNameState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class CubitNameInit extends CubitNameState{}
class CubitNameLoading extends CubitNameState{}
class CubitNameLoaded extends CubitNameState{}
class CubitNameError extends CubitNameState{}
