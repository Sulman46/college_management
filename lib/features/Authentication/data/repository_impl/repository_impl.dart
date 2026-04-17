
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository{
  final AuthenticationDataSource dataSource;
  AuthenticationRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}