
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class AuthenticationUseCase{
  final AuthenticationRepository repository;
  AuthenticationUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
