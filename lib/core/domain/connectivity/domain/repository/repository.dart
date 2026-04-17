import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class RepositoryConnection{
  Future<Either<String,bool>> connection({required Connectivity connectivity, required InternetConnectionChecker internetConnectionChecker});

}