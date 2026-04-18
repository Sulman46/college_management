import 'package:equatable/equatable.dart';

abstract class LeaveRequestState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class LeaveRequestInit extends LeaveRequestState{}
class LeaveRequestLoading extends LeaveRequestState{}
class LeaveRequestLoaded extends LeaveRequestState{}
class LeaveRequestError extends LeaveRequestState{}
