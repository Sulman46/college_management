import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationUseCase _useCase;
  AuthenticationCubit(this._useCase) : super(AuthenticationInit());

}
