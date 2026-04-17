import 'package:equatable/equatable.dart';

abstract class AdminHomeState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class AdminHomeInit extends AdminHomeState{}
class AdminHomeLoading extends AdminHomeState{}
class AdminHomeLoaded extends AdminHomeState{}
class AdminHomeError extends AdminHomeState{}
