
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../repository/repository.dart';

class UseCaseConnection{
  final RepositoryConnection repository;
  UseCaseConnection({required this.repository});

  Future<Either<String, bool>> connection({required Connectivity connectivity, required InternetConnectionChecker internetConnectionChecker})async {
    return repository.connection(internetConnectionChecker: internetConnectionChecker,connectivity:connectivity );
  }
}
