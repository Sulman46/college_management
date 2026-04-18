import 'package:equatable/equatable.dart';

abstract class StudentRegistrationState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class StudentRegistrationInit extends StudentRegistrationState{}
class StudentRegistrationLoading extends StudentRegistrationState{}
class StudentRegistrationLoaded extends StudentRegistrationState{}
class StudentRegistrationError extends StudentRegistrationState{}
