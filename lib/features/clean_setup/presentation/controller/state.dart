import 'package:equatable/equatable.dart';

abstract class NewFileNameState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class NewFileNameInit extends NewFileNameState{}
class NewFileNameLoading extends NewFileNameState{}
class NewFileNameLoaded extends NewFileNameState{}
class NewFileNameError extends NewFileNameState{}
