import 'package:equatable/equatable.dart';

abstract class AnnouncementsState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class AnnouncementsInit extends AnnouncementsState{}
class AnnouncementsLoading extends AnnouncementsState{}
class AnnouncementsLoaded extends AnnouncementsState{}
class AnnouncementsError extends AnnouncementsState{}
