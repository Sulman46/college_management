
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class ConnectionImpl extends RepositoryConnection{
  final DataSourceConnection dataSourceConnection;
  ConnectionImpl({required this.dataSourceConnection});

  @override
  Future<Either<String, bool>> connection({required Connectivity connectivity, required InternetConnectionChecker internetConnectionChecker}) {
    return dataSourceConnection.connection(connectivity: connectivity,internetConnectionChecker: internetConnectionChecker);
  }

}