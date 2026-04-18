import 'package:equatable/equatable.dart';

abstract class TimetableManagerState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class TimetableManagerInit extends TimetableManagerState{}
class TimetableManagerLoading extends TimetableManagerState{}
class TimetableManagerLoaded extends TimetableManagerState{}
class TimetableManagerError extends TimetableManagerState{}
