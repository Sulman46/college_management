import 'package:equatable/equatable.dart';

abstract class UniversityProfileState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class UniversityProfileInit extends UniversityProfileState{}
class UniversityProfileLoading extends UniversityProfileState{}
class UniversityProfileLoaded extends UniversityProfileState{}
class UniversityProfileError extends UniversityProfileState{}
