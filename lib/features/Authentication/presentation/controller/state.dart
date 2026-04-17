import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationInit extends AuthenticationState{}
class AuthenticationLoading extends AuthenticationState{}
class AuthenticationLoaded extends AuthenticationState{}
class AuthenticationError extends AuthenticationState{}
