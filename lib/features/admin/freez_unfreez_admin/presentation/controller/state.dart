import 'package:equatable/equatable.dart';

abstract class FreezUnFreezState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class FreezUnFreezInit extends FreezUnFreezState{}
class FreezUnFreezLoading extends FreezUnFreezState{}
class FreezUnFreezLoaded extends FreezUnFreezState{}
class FreezUnFreezError extends FreezUnFreezState{}
