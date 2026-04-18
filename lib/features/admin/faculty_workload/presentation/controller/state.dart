import 'package:equatable/equatable.dart';

abstract class FacultyWorkLoadState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class FacultyWorkLoadInit extends FacultyWorkLoadState{}
class FacultyWorkLoadLoading extends FacultyWorkLoadState{}
class FacultyWorkLoadLoaded extends FacultyWorkLoadState{}
class FacultyWorkLoadError extends FacultyWorkLoadState{}
