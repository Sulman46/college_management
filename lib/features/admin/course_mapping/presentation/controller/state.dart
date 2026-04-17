import 'package:equatable/equatable.dart';

abstract class CourseMappingState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class CourseMappingInit extends CourseMappingState{}
class CourseMappingLoading extends CourseMappingState{}
class CourseMappingLoaded extends CourseMappingState{}
class CourseMappingError extends CourseMappingState{}
